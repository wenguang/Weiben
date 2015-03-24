//
//  WBTag.m
//  Weiben
//
//  Created by wenguang pan on 12/4/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTag.h"

@implementation WBTag

+ (instancetype)tagWithName:(NSString *)name identifier:(NSString *)identifier
{
    WBTag *tag = [[WBTag alloc] init];
    tag.name = name;
    tag.identifier = identifier;
    return tag;
}

@end
