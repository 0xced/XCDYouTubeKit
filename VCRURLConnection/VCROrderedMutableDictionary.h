//
// VCROrderedMutableDictionary.h
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

#import <Foundation/Foundation.h>

/**
 A decorator around NSMutableDictionary that maintains the orders of its keys.
 */
@interface VCROrderedMutableDictionary : NSMutableDictionary

/**
 Inserts an object into the dictionary for a key at a given index.
 
 @param anObject The object to insert.
 @param aKey The key under which to store the object.
 @param anIndex The index at which to place the key.
 */
- (void)insertObject:(id)anObject forKey:(id)aKey atIndex:(NSUInteger)anIndex;

/**
 Returns the key at a given index.

 @param anIndex The index for which to retrieve the key.
 @returns The key found at the index, or NSNotFound if... well, not found.
 */
- (id)keyAtIndex:(NSUInteger)anIndex;

/**
 Returns the reverse key enumerator.
 
 @returns The reverse key enumerator for this class.
 */
- (NSEnumerator *)reverseKeyEnumerator;

/**
 Returns an array of the keys from the dictionary, sorted alphabetically.
 
 @returns The sorted array of dictionary keys.
 */
- (NSArray *)sortedKeys;

@end