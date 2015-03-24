//
//  WBTag.h
//  Weiben
//
//  Created by wenguang pan on 12/4/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@interface WBTag : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, copy) NSString *name;

+ (instancetype)tagWithName:(NSString *)name identifier:(NSString *)identifier;

@end
