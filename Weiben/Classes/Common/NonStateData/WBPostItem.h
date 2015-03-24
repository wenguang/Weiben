//
//  WBPostItem.h
//  Weiben
//
//  Created by wenguang pan on 1/5/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

@interface WBPostItem : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL star;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, strong) NSMutableArray *tags;

+ (instancetype)postItemWithText:(NSString *)text image:(UIImage *)image date:(NSDate *)date star:(BOOL)star location:(CLLocation *)location place:(NSString *)place tags:(NSArray *)tags identifier:(NSString *)identifier;

@end
