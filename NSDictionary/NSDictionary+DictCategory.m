//
//  NSDictionary+DictCategory.m
//  NSDictionary
//
//  Created by Puvanarajan on 10/2/17.
//  Copyright © 2017 Puvanarajan. All rights reserved.
//
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

#import "NSDictionary+DictCategory.h"

@implementation NSDictionary (DictCategory)

- (NSDictionary *)dictionaryRemovingNSNullValues {
    return [self removeNull];
}

#pragma mark - Replace null values to empty string
- (NSDictionary*)removeNull {
    
    NSMutableDictionary *replaced = [NSMutableDictionary dictionaryWithDictionary: self];
    
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in [self allKeys]) {
        
        const id object = [self objectForKey: key];
        if (object == nul) {
            [replaced setObject: blank forKey: key];
        } else if([object isKindOfClass: [NSDictionary class]]) {
            [replaced setObject: [self replaceNull:object] forKey: key];
        } else if([object isKindOfClass: [NSArray class]]) {
            [replaced setObject: [self replaceNullArray:object] forKey: key];
        }
    }
    return [NSDictionary dictionaryWithDictionary: replaced];
}

- (NSArray *)replaceNullArray:(NSArray *)array {
    
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    NSMutableArray *replaced = [NSMutableArray arrayWithArray:array];
    
    for (int i=0; i < [array count]; i++) {
        const id object = [array objectAtIndex:i];
        if (object == nul) {
            [replaced replaceObjectAtIndex:i withObject:blank];
        } else if([object isKindOfClass: [NSDictionary class]]) {
            [replaced replaceObjectAtIndex:i withObject:[self replaceNull:object]];
        } else if([object isKindOfClass: [NSArray class]]) {
            [replaced replaceObjectAtIndex:i withObject:[self replaceNullArray:object]];
        }
    }
    return replaced;
}

- (NSDictionary *)replaceNull:(NSDictionary *)dict {
    
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    NSMutableDictionary *replaced = [NSMutableDictionary dictionaryWithDictionary: dict];
    
    for (NSString *key in [dict allKeys]) {
        const id object = [dict objectForKey: key];
        if (object == nul) {
            [replaced setObject: blank forKey: key];
        } else if ([object isKindOfClass: [NSDictionary class]]) {
            [replaced setObject: [self replaceNull:object] forKey: key];
        } else if([object isKindOfClass: [NSArray class]]) {
            [replaced setObject: [self replaceNullArray:object] forKey: key];
        }
    }
    return replaced;
}
@end
