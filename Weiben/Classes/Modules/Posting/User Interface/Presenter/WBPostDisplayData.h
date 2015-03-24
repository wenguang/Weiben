//
//  WBPostDisplayData.h
//  Weiben
//
//  Created by wenguang pan on 1/25/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

@interface WBPostDisplayData : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL star;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, strong) CLLocation *location;

+ (instancetype)postDisplayDataWith:(NSString *)text image:(UIImage *)image date:(NSDate *)date star:(BOOL)star place:(NSString *)place identifier:(NSString *)identifier;

@end
