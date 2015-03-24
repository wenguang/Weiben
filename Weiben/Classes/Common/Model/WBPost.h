//
//  WBPostItem.h
//  Weiben
//
//  Created by wenguang pan on 12/3/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@interface WBPost : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL star;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, strong) NSMutableArray *tags;

+ (instancetype)postWithText:(NSString *)text imageData:(NSData *)imageData date:(NSDate *)date star:(BOOL)star location:(CLLocation *)location place:(NSString *)place tags:(NSArray *)tags identifier:(NSString *)identifier;

@end
