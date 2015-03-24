//
//  NSArray+WBUtility.m
//  Weiben
//
//  Created by wenguang pan on 3/13/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "NSArray+WBUtility.h"

@implementation NSArray(WBUtility)

- (NSArray *)reverse
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

@end
