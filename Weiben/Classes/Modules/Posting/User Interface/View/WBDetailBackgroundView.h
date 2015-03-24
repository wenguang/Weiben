//
//  WBDetailBackgroundView.h
//  Weiben
//
//  Created by wenguang pan on 3/22/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBDetailBackgroundView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign, readonly) CGFloat imageHeight;
@property (nonatomic, assign) CGFloat imageOffsetY;

- (instancetype)initWithFrame:(CGRect)rect image:(UIImage *)image imageHeight:(CGFloat)height;

@end
