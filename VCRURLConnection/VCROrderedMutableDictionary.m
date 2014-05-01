//
// VCROrderedMutableDictionary.m
//
// Copyright (c) 2013 Dustin Barker
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "VCROrderedMutableDictionary.h"

@interface VCROrderedMutableDictionary ()

/**
 An internal dictionary used for the actual data storage.
 */
@property (strong, nonatomic) NSMutableDictionary *dictionary;

/**
 An internal array used for key storage and ordering.
 */
@property (strong, nonatomic) NSMutableArray *array;

@end

NSString *DescriptionForObject(NSObject *object, id locale, NSUInteger indent) {
	NSString *objectString;
    
	if ([object isKindOfClass:[NSString class]]) {
		objectString = (NSString *)object;
	} else if ([object respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
		objectString = [(NSDictionary *)object descriptionWithLocale:locale indent:indent];
	} else if ([object respondsToSelector:@selector(descriptionWithLocale:)]) {
		objectString = [(NSSet *)object descriptionWithLocale:locale];
	} else {
		objectString = object.description;
	}
    
	return objectString;
}

@implementation VCROrderedMutableDictionary

- (instancetype)init {
	return [self initWithCapacity:0];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
	if ((self = [super init])) {
		_dictionary = [NSMutableDictionary dictionaryWithCapacity:capacity];
		_array = [NSMutableArray arrayWithCapacity:capacity];
	}
	return self;
}

- (instancetype)copy {
	return [self mutableCopy];
}

- (void)setObject:(id)anObject forKey:(id)aKey {
    if (!aKey) {
        return;
    }
	if (!self.dictionary[aKey]) {
        [self.array addObject:aKey];
    }
	self.dictionary[aKey] = anObject;
}

- (void)removeObjectForKey:(id)aKey {
	[self.dictionary removeObjectForKey:aKey];
	[self.array removeObject:aKey];
}

- (NSUInteger)count {
	return [self.dictionary count];
}

- (id)objectForKey:(id)aKey {
	return self.dictionary[aKey];
}

- (NSEnumerator *)keyEnumerator {
	return [self.array objectEnumerator];
}

- (NSEnumerator *)reverseKeyEnumerator {
	return [self.array reverseObjectEnumerator];
}

- (NSArray *)sortedKeys {
    return [[self allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)insertObject:(id)anObject forKey:(id)aKey atIndex:(NSUInteger)anIndex {
	if (self.dictionary[aKey]) {
        [self removeObjectForKey:aKey];
    }
    
	[self.array insertObject:aKey atIndex:anIndex];
	self.dictionary[aKey] = anObject;
}

- (id)keyAtIndex:(NSUInteger)anIndex {
	return self.array[anIndex];
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
	NSMutableString *indentString = [NSMutableString string];
	NSUInteger i, count = level;
	for (i = 0; i < count; i++) [indentString appendFormat:@"    "];
	
	NSMutableString *description = [NSMutableString string];
	[description appendFormat:@"%@{\n", indentString];
	for (NSObject *key in self) {
		[description appendFormat:@"%@    %@ = %@;\n",
         indentString,
         DescriptionForObject(key, locale, level),
         DescriptionForObject([self objectForKey:key], locale, level)];
	}
    
	[description appendFormat:@"%@}\n", indentString];
	return description;
}

@end