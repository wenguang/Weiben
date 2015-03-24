//
//  WBTagItem.m
//  Weiben
//
//  Created by wenguang pan on 1/5/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBTagItem.h"

@implementation WBTagItem

+ (instancetype)tagItemWithName:(NSString *)name identifier:(NSString *)identifier
{
    WBTagItem *tagItem = [[WBTagItem alloc] init];
    tagItem.name = name;
    tagItem.identifier = identifier;
    return tagItem;
}

@end
