//
//  WBTagItem.h
//  Weiben
//
//  Created by wenguang pan on 1/5/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

@interface WBTagItem : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, copy) NSString *name;

+ (instancetype)tagItemWithName:(NSString *)name identifier:(NSString *)identifier;

@end
