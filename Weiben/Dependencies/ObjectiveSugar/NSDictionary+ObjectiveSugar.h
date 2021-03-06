//
//  NSDictionary+ObjectiveSugar.h
//  SampleProject
//
//  Created by Marin Usalj on 11/23/12.
//  Copyright (c) 2012 @supermarin | supermar.in. All rights reserved.
//

@interface NSDictionary (ObjectiveSugar)

- (void)each:(void (^)(id key, id value))block;
- (void)eachKey:(void (^)(id key))block;
- (void)eachValue:(void (^)(id value))block;
- (NSArray *)map:(id (^)(id key, id value))block;
- (BOOL)hasKey:(id)key;

@end
