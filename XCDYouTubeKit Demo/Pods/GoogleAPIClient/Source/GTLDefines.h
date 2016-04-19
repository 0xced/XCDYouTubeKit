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
// GTLDefines.h
//

// Ensure Apple's conditionals we depend on are defined.
#import <TargetConditionals.h>
#import <AvailabilityMacros.h>

//
// The developer may choose to define these in the project:
//
//   #define GTL_TARGET_NAMESPACE Xxx  // preface all GTL class names with Xxx (recommended for building plug-ins)
//   #define GTL_FOUNDATION_ONLY 1     // builds without AppKit or Carbon (default for iPhone builds)
//   #define STRIP_GTM_FETCH_LOGGING 1 // omit http logging code (default for iPhone release builds)
//
// Mac developers may find GTL_SIMPLE_DESCRIPTIONS and STRIP_GTM_FETCH_LOGGING useful for
// reducing code size.
//

// Define later OS versions when building on earlier versions
#ifdef MAC_OS_X_VERSION_10_0
  #ifndef MAC_OS_X_VERSION_10_6
    #define MAC_OS_X_VERSION_10_6 1060
  #endif
#endif


#ifdef GTL_TARGET_NAMESPACE
// prefix all GTL class names with GTL_TARGET_NAMESPACE for this target
  #import "GTLTargetNamespace.h"
#endif

// Provide a common definition for externing constants/functions
#if defined(__cplusplus)
  #define GTL_EXTERN extern "C"
#else
  #define GTL_EXTERN extern
#endif

#if TARGET_OS_IPHONE // iPhone SDK

  #define GTL_IPHONE 1

#endif

#if GTL_IPHONE

  #define GTL_FOUNDATION_ONLY 1

#endif

//
// GTL_ASSERT defaults to bridging to NSAssert. This macro exists just in case
// it needs to be remapped.
// GTL_DEBUG_ASSERT is similar, but compiles in only for debug builds
//

#ifndef GTL_ASSERT
  // NSCAssert to avoid capturing self if used in a block.
  #define GTL_ASSERT(condition, ...) NSCAssert(condition, __VA_ARGS__)
#endif // GTL_ASSERT

#ifndef GTL_DEBUG_ASSERT
  #if DEBUG && !defined(NS_BLOCK_ASSERTIONS)
    #define GTL_DEBUG_ASSERT(condition, ...) GTL_ASSERT(condition, __VA_ARGS__)
  #elif DEBUG
    // In DEBUG builds with assertions blocked, log to avoid unused variable warnings.
    #define GTL_DEBUG_ASSERT(condition, ...) if (!(condition)) { NSLog(__VA_ARGS__); }
  #else
    #define GTL_DEBUG_ASSERT(condition, ...) do { } while (0)
  #endif
#endif

#ifndef GTL_DEBUG_LOG
  #if DEBUG
    #define GTL_DEBUG_LOG(...) NSLog(__VA_ARGS__)
  #else
    #define GTL_DEBUG_LOG(...) do { } while (0)
  #endif
#endif

#ifndef STRIP_GTM_FETCH_LOGGING
  #if GTL_IPHONE && !DEBUG
    #define STRIP_GTM_FETCH_LOGGING 1
  #else
    #define STRIP_GTM_FETCH_LOGGING 0
  #endif
#endif

// Some support for advanced clang static analysis functionality
// See http://clang-analyzer.llvm.org/annotations.html
#ifndef __has_feature      // Optional.
  #define __has_feature(x) 0 // Compatibility with non-clang compilers.
#endif
#ifndef NS_RETURNS_NOT_RETAINED
  #if __has_feature(attribute_ns_returns_not_retained)
    #define NS_RETURNS_NOT_RETAINED __attribute__((ns_returns_not_retained))
  #else
    #define NS_RETURNS_NOT_RETAINED
  #endif
#endif

#ifndef __has_attribute
  #define __has_attribute(x) 0
#endif

#ifndef GTL_NONNULL
  #if __has_attribute(nonnull)
    #define GTL_NONNULL(x) __attribute__((nonnull x))
  #else
    #define GTL_NONNULL(x)
  #endif
#endif

#ifndef GTL_DECLARE_GENERICS
  #if __has_feature(objc_generics) \
    && ((!TARGET_OS_IPHONE && defined(MAC_OS_X_VERSION_10_11) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_11) \
      || (TARGET_OS_IPHONE && defined(__IPHONE_9_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0))
    #define GTL_DECLARE_GENERICS 1
  #else
    #define GTL_DECLARE_GENERICS 0
  #endif
#endif

#ifndef GTL_NSArrayOf
  #if GTL_DECLARE_GENERICS
    #define GTL_NSArrayOf(value) NSArray<value>
    #define GTL_NSDictionaryOf(key, value) NSDictionary<key, value>
    #define GTL_NSMutableDictionaryOf(key, value) NSMutableDictionary<key, value>
  #else
    #define GTL_NSArrayOf(value) NSArray
    #define GTL_NSDictionaryOf(key, value) NSDictionary
    #define GTL_NSMutableDictionaryOf(key, value) NSMutableDictionary
  #endif // GTL_DECLARE_GENERICS
#endif  // GTL_NSArrayOf
