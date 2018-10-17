/* Copyright (c) 2011 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  GTLRuntimeCommon.m
//

#include <objc/runtime.h>
#include <TargetConditionals.h>

#import "GTLRuntimeCommon.h"

#import "GTLDateTime.h"
#import "GTLObject.h"
#import "GTLUtilities.h"

// Note: NSObject's class is used as a marker for the expected/default class
// when Discovery says it can be any type of object.

@implementation GTLRuntimeCommon

// Helper to generically convert JSON to an api object type.
+ (id)objectFromJSON:(id)json
        defaultClass:(Class)defaultClass
          surrogates:(NSDictionary *)surrogates
         isCacheable:(BOOL*)isCacheable {
  id result = nil;
  BOOL canBeCached = YES;

  // TODO(TVL): use defaultClass to validate things like expectedClass is
  // done in jsonFromAPIObject:expectedClass:isCacheable:?

  if ([json isKindOfClass:[NSDictionary class]]) {
    // If no default, or the default was any object, then default to base
    // object here (and hope there is a kind to get the right thing).
    if ((defaultClass == Nil) || [defaultClass isEqual:[NSObject class]]) {
      defaultClass = [GTLObject class];
    }
    result = [GTLObject objectForJSON:json
                         defaultClass:defaultClass
                           surrogates:surrogates
                        batchClassMap:nil];
  } else if ([json isKindOfClass:[NSArray class]]) {
    NSArray *jsonArray = json;
    // make an object for each JSON dictionary in the array
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:[jsonArray count]];
    for (id jsonItem in jsonArray) {
      id item = [self objectFromJSON:jsonItem
                        defaultClass:defaultClass
                          surrogates:surrogates
                         isCacheable:NULL];
      [resultArray addObject:item];
    }
    result = resultArray;
  } else if ([json isKindOfClass:[NSString class]]) {
    // DateTimes live in JSON as strings, so convert
    if ([defaultClass isEqual:[GTLDateTime class]]) {
      result = [GTLDateTime dateTimeWithRFC3339String:json];
    } else if ([defaultClass isEqual:[NSNumber class]]) {
      result = GTL_EnsureNSNumber(json);
      canBeCached = NO;
    } else {
      result = json;
      canBeCached = NO;
    }
  } else if ([json isKindOfClass:[NSNumber class]] ||
             [json isKindOfClass:[NSNull class]]) {
    result = json;
    canBeCached = NO;
  } else {
    GTL_DEBUG_LOG(@"GTLRuntimeCommon: unsupported class '%s' in objectFromJSON",
                  class_getName([json class]));
  }

  if (isCacheable) {
    *isCacheable = canBeCached;
  }
  return result;
}

// Helper to generically convert an api object type to JSON.
// |expectedClass| is the type that was expected for |obj|.
+ (id)jsonFromAPIObject:(id)obj
          expectedClass:(Class)expectedClass
            isCacheable:(BOOL*)isCacheable {
  id result = nil;
  BOOL canBeCached = YES;
  BOOL checkExpected = (expectedClass != Nil);

  if ([obj isKindOfClass:[NSString class]]) {
    result = [[obj copy] autorelease];
    canBeCached = NO;
  } else if ([obj isKindOfClass:[NSNumber class]] ||
             [obj isKindOfClass:[NSNull class]]) {
      result = obj;
      canBeCached = NO;
  } else if ([obj isKindOfClass:[GTLObject class]]) {
    result = [(GTLObject *)obj JSON];
    if (result == nil) {
      // adding an empty object; it should have a JSON dictionary so it can
      // hold future assignments
      [(GTLObject *)obj setJSON:[NSMutableDictionary dictionary]];
      result = [(GTLObject *)obj JSON];
    }
  } else if ([obj isKindOfClass:[NSArray class]]) {
    checkExpected = NO;
    NSArray *array = obj;
    // get the JSON for each thing in the array
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:[array count]];
    for (id item in array) {
      id itemJSON = [self jsonFromAPIObject:item
                              expectedClass:expectedClass
                                isCacheable:NULL];
      [resultArray addObject:itemJSON];
    }
    result = resultArray;
  } else if ([obj isKindOfClass:[GTLDateTime class]]) {
    // DateTimes live in JSON as strings, so convert.
    GTLDateTime *dateTime = obj;
    result = [dateTime stringValue];
  } else {
    checkExpected = NO;
    if (obj) {
      GTL_DEBUG_LOG(@"GTLRuntimeCommon: unsupported class '%s' in jsonFromAPIObject",
                    class_getName([obj class]));
    }
  }

  if (checkExpected) {
    // If the default was any object, then clear it to skip validation checks.
    if ([expectedClass isEqual:[NSObject class]] ||
        [obj isKindOfClass:[NSNull class]]) {
      expectedClass = nil;
    }
    if (expectedClass && ![obj isKindOfClass:expectedClass]) {
      GTL_DEBUG_LOG(@"GTLRuntimeCommon: jsonFromAPIObject expected class '%s' instead got '%s'",
                    class_getName(expectedClass), class_getName([obj class]));
    }
  }

  if (isCacheable) {
    *isCacheable = canBeCached;
  }
  return result;
}

#pragma mark Runtime lookup support

static objc_property_t PropertyForSel(Class<GTLRuntimeCommon> startClass,
                                      SEL sel, BOOL isSetter,
                                      Class<GTLRuntimeCommon> *outFoundClass) {
  const char *selName = sel_getName(sel);
  const char *baseName = selName;
  size_t baseNameLen = strlen(baseName);
  if (isSetter) {
    baseName += 3;    // skip "set"
    baseNameLen -= 4; // subtract "set" and the final colon
  }

  // walk from this class up the hierarchy to the ancestor class
  Class<GTLRuntimeCommon> topClass = class_getSuperclass([startClass ancestorClass]);
  for (Class currClass = startClass;
       currClass != topClass;
       currClass = class_getSuperclass(currClass)) {
    // step through this class's properties
    objc_property_t foundProp = NULL;
    objc_property_t *properties = class_copyPropertyList(currClass, NULL);
    if (properties) {
      for (objc_property_t *prop = properties; *prop != NULL; ++prop) {
        const char *propAttrs = property_getAttributes(*prop);
        const char *dynamicMarker = strstr(propAttrs, ",D");
        if (!dynamicMarker ||
            (dynamicMarker[2] != 0 && dynamicMarker[2] != ',' )) {
          // It isn't dynamic, skip it.
          continue;
        }

        if (!isSetter) {
          // See if this property has an explicit getter=. (the attributes always start with a T,
          // so we can check for the leading ','.
          const char *getterMarker = strstr(propAttrs, ",G");
          if (getterMarker) {
            const char *getterStart = getterMarker + 2;
            const char *getterEnd = getterStart;
            while ((*getterEnd != 0) && (*getterEnd != ',')) {
              ++getterEnd;
            }
            size_t getterLen = (size_t)(getterEnd - getterStart);
            if ((strncmp(selName, getterStart, getterLen) == 0)
                && (selName[getterLen] == 0)) {
              // return the actual property
              foundProp = *prop;
              // if requested, return the class containing the property
              if (outFoundClass) *outFoundClass = currClass;
              break;
            }
          }  // if (getterMarker)
        }  // if (!isSetter)

        // Search for an exact-name match (a getter), but case-insensitive on the
        // first character (in case baseName comes from a setter)
        const char *propName = property_getName(*prop);
        size_t propNameLen = strlen(propName);
        if (baseNameLen == propNameLen
            && strncasecmp(baseName, propName, 1) == 0
            && (baseNameLen <= 1
                || strncmp(baseName + 1, propName + 1, baseNameLen - 1) == 0)) {
          // return the actual property
          foundProp = *prop;

          // if requested, return the class containing the property
          if (outFoundClass) *outFoundClass = currClass;
          break;
        }
      }  // for (prop in properties)
      free(properties);
    }
    if (foundProp) return foundProp;
  }

  // not found; this occasionally happens when the system looks for a method
  // like "getFoo" or "descriptionWithLocale:indent:"
  return NULL;
}

typedef NS_ENUM(NSUInteger, GTLPropertyType) {
#if !defined(__LP64__) || !__LP64__
  // These two only needed in 32bit builds since NSInteger in 64bit ends up in the LongLong paths.
  GTLPropertyTypeInt32 = 1,
  GTLPropertyTypeUInt32,
#endif
  GTLPropertyTypeLongLong = 3,
  GTLPropertyTypeULongLong,
  GTLPropertyTypeFloat,
  GTLPropertyTypeDouble,
  GTLPropertyTypeBool,
  GTLPropertyTypeNSString,
  GTLPropertyTypeNSNumber,
  GTLPropertyTypeGTLDateTime,
  GTLPropertyTypeNSArray,
  GTLPropertyTypeNSObject,
  GTLPropertyTypeGTLObject,
};

typedef struct {
  const char *attributePrefix;

  GTLPropertyType propertyType;
  const char *setterEncoding;
  const char *getterEncoding;

  // These are the "fixed" return classes, but some properties will require
  // looking up the return class instead (because it is a subclass of
  // GTLObject).
  const char *returnClassName;
  Class       returnClass;
  BOOL extractReturnClass;

} GTLDynamicImpInfo;

static const GTLDynamicImpInfo *DynamicImpInfoForProperty(objc_property_t prop,
                                                          Class *outReturnClass) {

  if (outReturnClass) *outReturnClass = nil;

  // dynamic method resolution:
  // http://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtDynamicResolution.html
  //
  // property runtimes:
  // http://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html

  // Get and parse the property attributes, which look something like
  //   T@"NSString",&,D,P
  //   Ti,D -- NSInteger on 32bit
  //   Tq,D -- NSInteger on 64bit, long long on 32bit & 64bit
  //   TB,D -- BOOL comes as bool on 64bit iOS
  //   Tc,D -- BOOL comes as char otherwise
  //   T@"NSString",D
  //   T@"GTLLink",D
  //   T@"NSArray",D


  static GTLDynamicImpInfo kImplInfo[] = {
#if !defined(__LP64__) || !__LP64__
    { // NSInteger on 32bit
      "Ti",
      GTLPropertyTypeInt32,
      "v@:i",
      "i@:",
      nil, nil,
      NO
    },
    { // NSUInteger on 32bit
      "TI",
      GTLPropertyTypeUInt32,
      "v@:I",
      "I@:",
      nil, nil,
      NO
    },
#endif
    { // NSInteger on 64bit, long long on 32bit and 64bit.
      "Tq",
      GTLPropertyTypeLongLong,
      "v@:q",
      "q@:",
      nil, nil,
      NO
    },
    { // NSUInteger on 64bit, long long on 32bit and 64bit.
      "TQ",
      GTLPropertyTypeULongLong,
      "v@:Q",
      "Q@:",
      nil, nil,
      NO
    },
    { // float
      "Tf",
      GTLPropertyTypeFloat,
      "v@:f",
      "f@:",
      nil, nil,
      NO
    },
    { // double
      "Td",
      GTLPropertyTypeDouble,
      "v@:d",
      "d@:",
      nil, nil,
      NO
    },
// This conditional matches the one in iPhoneOS.platform version of
// <objc/objc.h> that controls the definition of BOOL.
#if !defined(OBJC_HIDE_64) && TARGET_OS_IPHONE && (defined(__LP64__) && __LP64__)
    { // BOOL as bool
      "TB",
      GTLPropertyTypeBool,
      "v@:B",
      "B@:",
      nil, nil,
      NO
    },
#else
    { // BOOL as char
      "Tc",
      GTLPropertyTypeBool,
      "v@:c",
      "c@:",
      nil, nil,
      NO
    },
#endif
    { // NSString
      "T@\"NSString\"",
      GTLPropertyTypeNSString,
      "v@:@",
      "@@:",
      "NSString", nil,
      NO
    },
    { // NSNumber
      "T@\"NSNumber\"",
      GTLPropertyTypeNSNumber,
      "v@:@",
      "@@:",
      "NSNumber", nil,
      NO
    },
    { // GTLDateTime
#if !defined(GTL_TARGET_NAMESPACE)
      "T@\"GTLDateTime\"",
      GTLPropertyTypeGTLDateTime,
      "v@:@",
      "@@:",
      "GTLDateTime", nil,
      NO
#else
      "T@\"" GTL_TARGET_NAMESPACE_STRING "_" "GTLDateTime\"",
      GTLPropertyTypeGTLDateTime,
      "v@:@",
      "@@:",
      GTL_TARGET_NAMESPACE_STRING "_" "GTLDateTime", nil,
      NO
#endif
    },
    { // NSArray with type
      "T@\"NSArray\"",
      GTLPropertyTypeNSArray,
      "v@:@",
      "@@:",
      "NSArray", nil,
      NO
    },
    { // id (any of the objects above)
      "T@,",
      GTLPropertyTypeNSObject,
      "v@:@",
      "@@:",
      "NSObject", nil,
      NO
    },
    { // GTLObject - Last, cause it's a special case and prefix is general
      "T@\"",
      GTLPropertyTypeGTLObject,
      "v@:@",
      "@@:",
      nil, nil,
      YES
    },
  };

  static BOOL hasLookedUpClasses = NO;
  if (!hasLookedUpClasses) {
    // Unfortunately, you can't put [NSString class] into the static structure,
    // so this lookup has to be done at runtime.
    hasLookedUpClasses = YES;
    for (uint32_t idx = 0; idx < sizeof(kImplInfo)/sizeof(kImplInfo[0]); ++idx) {
      if (kImplInfo[idx].returnClassName) {
        kImplInfo[idx].returnClass = objc_getClass(kImplInfo[idx].returnClassName);
        NSCAssert1(kImplInfo[idx].returnClass != nil,
                   @"GTLRuntimeCommon: class lookup failed: %s", kImplInfo[idx].returnClassName);
      }
    }
  }

  const char *attr = property_getAttributes(prop);

  const char *dynamicMarker = strstr(attr, ",D");
  if (!dynamicMarker ||
      (dynamicMarker[2] != 0 && dynamicMarker[2] != ',' )) {
    GTL_DEBUG_LOG(@"GTLRuntimeCommon: property %s isn't dynamic, attributes %s",
                  property_getName(prop), attr ? attr : "(nil)");
    return NULL;
  }

  const GTLDynamicImpInfo *result = NULL;

  // Cycle over the list

  for (uint32_t idx = 0; idx < sizeof(kImplInfo)/sizeof(kImplInfo[0]); ++idx) {
    const char *attributePrefix = kImplInfo[idx].attributePrefix;
    if (strncmp(attr, attributePrefix, strlen(attributePrefix)) == 0) {
      result = &kImplInfo[idx];
      if (outReturnClass) *outReturnClass = result->returnClass;
      break;
    }
  }

  if (result == NULL) {
    GTL_DEBUG_LOG(@"GTLRuntimeCommon: unexpected attributes %s for property %s",
                  attr ? attr : "(nil)", property_getName(prop));
    return NULL;
  }

  if (result->extractReturnClass && outReturnClass) {

    // add a null at the next quotation mark
    char *attrCopy = strdup(attr);
    char *classNameStart = attrCopy + 3;
    char *classNameEnd = strstr(classNameStart, "\"");
    if (classNameEnd) {
      *classNameEnd = '\0';

      // Lookup the return class
      *outReturnClass = objc_getClass(classNameStart);
      if (*outReturnClass == nil) {
        GTL_DEBUG_LOG(@"GTLRuntimeCommon: did not find class with name \"%s\" "
                      "for property \"%s\" with attributes \"%s\"",
                      classNameStart, property_getName(prop), attr);
      }
    } else {
      GTL_DEBUG_LOG(@"GTLRuntimeCommon: Failed to find end of class name for "
                    "property \"%s\" with attributes \"%s\"",
                    property_getName(prop), attr);
    }
    free(attrCopy);
  }

  return result;
}

// Helper to get the IMP for wiring up the getters.
// NOTE: Every argument passed in should be safe to capture in a block. Avoid
// passing something like selName instead of sel, because nothing says that
// pointer will be valid when it is finally used when the method IMP is invoked
// some time later.
static IMP GTLRuntimeGetterIMP(SEL sel,
                               GTLPropertyType propertyType,
                               NSString *jsonKey,
                               Class containedClass,
                               Class returnClass) {
  // Only used in DEBUG logging.
#pragma unused(sel)

  IMP resultIMP;
  switch (propertyType) {

#if !defined(__LP64__) || !__LP64__
    case GTLPropertyTypeInt32:
      resultIMP = imp_implementationWithBlock(^(id obj) {
        NSNumber *num = [obj JSONValueForKey:jsonKey];
        num = GTL_EnsureNSNumber(num);
        NSInteger result = [num integerValue];
        return result;
      });
      break;

    case GTLPropertyTypeUInt32:
      resultIMP = imp_implementationWithBlock(^(id obj) {
        NSNumber *num = [obj JSONValueForKey:jsonKey];
        num = GTL_EnsureNSNumber(num);
        NSUInteger result = [num unsignedIntegerValue];
        return result;
      });
      break;
#endif  // __LP64__

    case GTLPropertyTypeLongLong:
      resultIMP = imp_implementationWithBlock(^(id obj) {
        NSNumber *num = [obj JSONValueForKey:jsonKey];
        num = GTL_EnsureNSNumber(num);
        long long result = [num longLongValue];
        return result;
      });
      break;

    case GTLPropertyTypeULongLong:
      resultIMP = imp_implementationWithBlock(^(id obj) {
        NSNumber *num = [obj JSONValueForKey:jsonKey];
        num = GTL_EnsureNSNumber(num);
        unsigned long long result = [num unsignedLongLongValue];
        return result;
      });
      break;


    case GTLPropertyTypeFloat:
      resultIMP = imp_implementationWithBlock(^(id obj) {
        NSNumber *num = [obj JSONValueForKey:jsonKey];
        num = GTL_EnsureNSNumber(num);
        float result = [num floatValue];
        return result;
      });
      break;

    case GTLPropertyTypeDouble:
      resultIMP = imp_implementationWithBlock(^(id obj) {
        NSNumber *num = [obj JSONValueForKey:jsonKey];
        num = GTL_EnsureNSNumber(num);
        double result = [num doubleValue];
        return result;
      });
      break;

    case GTLPropertyTypeBool:
      resultIMP = imp_implementationWithBlock(^(id obj) {
        NSNumber *num = [obj JSONValueForKey:jsonKey];
        BOOL flag = [num boolValue];
        return flag;
      });
      break;

    case GTLPropertyTypeNSString:
      resultIMP = imp_implementationWithBlock(^(id obj) {
        NSString *str = [obj JSONValueForKey:jsonKey];
        return str;
      });
      break;

    case GTLPropertyTypeGTLDateTime:
      resultIMP = imp_implementationWithBlock(^GTLDateTime *(GTLObject<GTLRuntimeCommon> *obj) {
        // Return the cached object before creating on demand.
        GTLDateTime *cachedDateTime = [obj cacheChildForKey:jsonKey];
        if (cachedDateTime != nil) {
          return cachedDateTime;
        }
        NSString *str = [obj JSONValueForKey:jsonKey];
        id cacheValue, resultValue;
        if (![str isKindOfClass:[NSNull class]]) {
          GTLDateTime *dateTime = [GTLDateTime dateTimeWithRFC3339String:str];

          cacheValue = dateTime;
          resultValue = dateTime;
        } else {
          cacheValue = nil;
          resultValue = [NSNull null];
        }
        [obj setCacheChild:cacheValue forKey:jsonKey];
        return resultValue;
      });
      break;

    case GTLPropertyTypeNSNumber:
      resultIMP = imp_implementationWithBlock(^(id obj) {
        NSNumber *num = [obj JSONValueForKey:jsonKey];
        num = GTL_EnsureNSNumber(num);
        return num;
      });
      break;

    case GTLPropertyTypeGTLObject:
      // Default return calss to GTLObject if it wasn't found.
      if (returnClass == Nil) {
        returnClass = [GTLObject class];
      }
      resultIMP = imp_implementationWithBlock(^GTLObject *(GTLObject<GTLRuntimeCommon> *obj) {
        // Return the cached object before creating on demand.
        GTLObject *cachedObj = [obj cacheChildForKey:jsonKey];
        if (cachedObj != nil) {
          return cachedObj;
        }
        NSMutableDictionary *dict = [obj JSONValueForKey:jsonKey];
        if ([dict isKindOfClass:[NSMutableDictionary class]]) {
          NSDictionary *surrogates = obj.surrogates;
          GTLObject *subObj = [GTLObject objectForJSON:dict
                                          defaultClass:returnClass
                                            surrogates:surrogates
                                         batchClassMap:nil];
          [obj setCacheChild:subObj forKey:jsonKey];
          return subObj;
        } else if ([dict isKindOfClass:[NSNull class]]) {
          [obj setCacheChild:nil forKey:jsonKey];
          return (GTLObject*)[NSNull null];
        } else if (dict != nil) {
          // unexpected; probably got a string -- let the caller figure it out
          GTL_DEBUG_LOG(@"GTLObject: unexpected JSON: %@.%@ should be a dictionary, actually is a %@:\n%@",
                        NSStringFromClass([obj class]),
                        NSStringFromSelector(sel),
                        NSStringFromClass([dict class]), dict);
          return (GTLObject *)dict;
        }
        return nil;
      });
      break;

    case GTLPropertyTypeNSArray:
      resultIMP = imp_implementationWithBlock(^(GTLObject<GTLRuntimeCommon> *obj) {
        // Return the cached array before creating on demand.
        NSMutableArray *cachedArray = [obj cacheChildForKey:jsonKey];
        if (cachedArray != nil) {
          return cachedArray;
        }
        NSMutableArray *result = nil;
        NSArray *array = [obj JSONValueForKey:jsonKey];
        if (array != nil) {
          if ([array isKindOfClass:[NSArray class]]) {
            NSDictionary *surrogates = obj.surrogates;
            result = [GTLRuntimeCommon objectFromJSON:array
                                         defaultClass:containedClass
                                           surrogates:surrogates
                                          isCacheable:NULL];
          } else {
#if DEBUG
            if (![array isKindOfClass:[NSNull class]]) {
              GTL_DEBUG_LOG(@"GTLObject: unexpected JSON: %@.%@ should be an array, actually is a %@:\n%@",
                            NSStringFromClass([obj class]),
                            NSStringFromSelector(sel),
                            NSStringFromClass([array class]), array);
            }
#endif
            result = (NSMutableArray *)array;
          }
        }
        [obj setCacheChild:result forKey:jsonKey];
        return result;
      });
      break;

    case GTLPropertyTypeNSObject:
      resultIMP = imp_implementationWithBlock(^id(GTLObject<GTLRuntimeCommon> *obj) {
        // Return the cached object before creating on demand.
        id cachedObj = [obj cacheChildForKey:jsonKey];
        if (cachedObj != nil) {
          return cachedObj;
        }
        id jsonObj = [obj JSONValueForKey:jsonKey];
        if (jsonObj != nil) {
          BOOL shouldCache = NO;
          NSDictionary *surrogates = obj.surrogates;
          id result = [GTLRuntimeCommon objectFromJSON:jsonObj
                                          defaultClass:nil
                                            surrogates:surrogates
                                           isCacheable:&shouldCache];

          [obj setCacheChild:(shouldCache ? result : nil)
                      forKey:jsonKey];
          return result;
        }
        return nil;
      });
      break;

  }  // switch(propertyType)

  return resultIMP;
}

// Helper to get the IMP for wiring up the setters.
// NOTE: Every argument passed in should be safe to capture in a block. Avoid
// passing something like selName instead of sel, because nothing says that
// pointer will be valid when it is finally used when the method IMP is invoked
// some time later.
static IMP GTLRuntimeSetterIMP(SEL sel,
                               GTLPropertyType propertyType,
                               NSString *jsonKey,
                               Class containedClass,
                               Class returnClass) {
#pragma unused(sel, returnClass)
  IMP resultIMP;
  switch (propertyType) {

#if !defined(__LP64__) || !__LP64__
    case GTLPropertyTypeInt32:
      resultIMP = imp_implementationWithBlock(^(id obj, NSInteger val) {
        [obj setJSONValue:@(val) forKey:jsonKey];
      });
      break;

    case GTLPropertyTypeUInt32:
      resultIMP = imp_implementationWithBlock(^(id obj, NSUInteger val) {
        [obj setJSONValue:@(val) forKey:jsonKey];
      });
      break;
#endif  // __LP64__

    case GTLPropertyTypeLongLong:
      resultIMP = imp_implementationWithBlock(^(id obj, long long val) {
        [obj setJSONValue:@(val) forKey:jsonKey];
      });
      break;

    case GTLPropertyTypeULongLong:
      resultIMP = imp_implementationWithBlock(^(id obj,
                                                unsigned long long val) {
        [obj setJSONValue:@(val) forKey:jsonKey];
      });
      break;

    case GTLPropertyTypeFloat:
      resultIMP = imp_implementationWithBlock(^(id obj, float val) {
        [obj setJSONValue:@(val) forKey:jsonKey];
      });
      break;

    case GTLPropertyTypeDouble:
      resultIMP = imp_implementationWithBlock(^(id obj, double val) {
        [obj setJSONValue:@(val) forKey:jsonKey];
      });
      break;

    case GTLPropertyTypeBool:
      resultIMP = imp_implementationWithBlock(^(id obj, BOOL val) {
        [obj setJSONValue:@(val) forKey:jsonKey];
      });
      break;

    case GTLPropertyTypeNSString:
      resultIMP = imp_implementationWithBlock(^(id obj, NSString *val) {
        NSString *copiedStr = [val copy];
        [obj setJSONValue:copiedStr forKey:jsonKey];
        [copiedStr release];
      });
      break;

    case GTLPropertyTypeGTLDateTime:
      resultIMP = imp_implementationWithBlock(^(GTLObject<GTLRuntimeCommon> *obj,
                                                GTLDateTime *val) {
        id cacheValue, jsonValue;
        if (![val isKindOfClass:[NSNull class]]) {
          jsonValue = [val stringValue];
          cacheValue = val;
        } else {
          jsonValue = [NSNull null];
          cacheValue = nil;
        }

        [obj setJSONValue:jsonValue forKey:jsonKey];
        [obj setCacheChild:cacheValue forKey:jsonKey];
      });
      break;

    case GTLPropertyTypeNSNumber:
      resultIMP = imp_implementationWithBlock(^(id obj, NSNumber *val) {
        [obj setJSONValue:val forKey:jsonKey];
      });
      break;

    case GTLPropertyTypeGTLObject:
      resultIMP = imp_implementationWithBlock(^(GTLObject<GTLRuntimeCommon> *obj,
                                                GTLObject *val) {
        id cacheValue, jsonValue;
        if (![val isKindOfClass:[NSNull class]]) {
          NSMutableDictionary *dict = [val JSON];
          if (dict == nil && val != nil) {
            // adding an empty object; it should have a JSON dictionary so it
            // can hold future assignments
            val.JSON = [NSMutableDictionary dictionary];
            jsonValue = val.JSON;
          } else {
            jsonValue = dict;
          }
          cacheValue = val;
        } else {
          jsonValue = [NSNull null];
          cacheValue = nil;
        }
        [obj setJSONValue:jsonValue forKey:jsonKey];
        [obj setCacheChild:cacheValue forKey:jsonKey];
      });
      break;

    case GTLPropertyTypeNSArray:
      resultIMP = imp_implementationWithBlock(^(GTLObject<GTLRuntimeCommon> *obj,
                                                NSMutableArray *val) {
        id json = [GTLRuntimeCommon jsonFromAPIObject:val
                                        expectedClass:containedClass
                                          isCacheable:NULL];
        [obj setJSONValue:json forKey:jsonKey];
        [obj setCacheChild:val forKey:jsonKey];
      });
      break;

    case GTLPropertyTypeNSObject:
      resultIMP = imp_implementationWithBlock(^(GTLObject<GTLRuntimeCommon> *obj,
                                                id val) {
        BOOL shouldCache = NO;
        id json = [GTLRuntimeCommon jsonFromAPIObject:val
                                        expectedClass:Nil
                                          isCacheable:&shouldCache];
        [obj setJSONValue:json forKey:jsonKey];
        [obj setCacheChild:(shouldCache ? val : nil)
                     forKey:jsonKey];
      });
      break;

  }  // switch(propertyType)

  return resultIMP;
}

#pragma mark Runtime - wiring point

+ (BOOL)resolveInstanceMethod:(SEL)sel onClass:(Class<GTLRuntimeCommon>)onClass {
  // dynamic method resolution:
  // http://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtDynamicResolution.html
  //
  // property runtimes:
  // http://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html

  const char *selName = sel_getName(sel);
  size_t selNameLen = strlen(selName);
  char lastChar = selName[selNameLen - 1];
  BOOL isSetter = (lastChar == ':');

  // look for a declared property matching this selector name exactly
  Class<GTLRuntimeCommon> foundClass = nil;

  objc_property_t prop = PropertyForSel(onClass, sel, isSetter, &foundClass);
  if (prop == NULL || foundClass == nil) {
    return NO;  // No luck, out of here.
  }

  Class returnClass = nil;
  const GTLDynamicImpInfo *implInfo = DynamicImpInfoForProperty(prop,
                                                                &returnClass);
  if (implInfo == NULL) {
    GTL_DEBUG_LOG(@"GTLRuntimeCommon: unexpected return type class %s for "
                    "property \"%s\" of class \"%s\"",
                    returnClass ? class_getName(returnClass) : "<nil>",
                    property_getName(prop),
                    class_getName(onClass));
    return NO;  // Failed to find our impl info, out of here.
  }

  const char *propName = property_getName(prop);
  NSString *propStr = [NSString stringWithUTF8String:propName];

  // replace the property name with the proper JSON key if it's
  // special-cased with a map in the found class; otherwise, the property
  // name is the JSON key
  // NOTE: These caches that are built up could likely be dropped and do this
  // lookup on demand from the class tree. Most are checked once when a method
  // is first resolved, so eventually become wasted memory.
  NSDictionary *keyMap =
    [[foundClass ancestorClass] propertyToJSONKeyMapForClass:foundClass];
  NSString *jsonKey = [keyMap objectForKey:propStr];
  if (jsonKey == nil) {
    jsonKey = propStr;
  }

  // For arrays we need to look up what the contained class is.
  Class containedClass = nil;
  if (implInfo->propertyType == GTLPropertyTypeNSArray) {
    NSDictionary *classMap =
      [[foundClass ancestorClass] arrayPropertyToClassMapForClass:foundClass];
    containedClass = [classMap objectForKey:jsonKey];
    if (containedClass == Nil) {
      GTL_DEBUG_LOG(@"GTLRuntimeCommon: expected array item class for "
                    "property \"%s\" of class \"%s\"",
                    property_getName(prop), class_getName(foundClass));
    }
  }

  // Wire in the method.
  IMP imp;
  const char *encoding;
  if (isSetter) {
    imp = GTLRuntimeSetterIMP(sel, implInfo->propertyType,
                              jsonKey, containedClass, returnClass);
    encoding = implInfo->setterEncoding;
  } else {
    imp = GTLRuntimeGetterIMP(sel, implInfo->propertyType,
                              jsonKey, containedClass, returnClass);
    encoding = implInfo->getterEncoding;
  }
  if (class_addMethod(foundClass, sel, imp, encoding)) {
    return YES;
  }
  // Not much we can do if this fails, but leave a breadcumb in the log.
  GTL_DEBUG_LOG(@"GTLRuntimeCommon: Failed to wire %@ on %@ (encoding: %s).",
                NSStringFromSelector(sel),
                NSStringFromClass(foundClass),
                encoding);
  return NO;
}

@end
