//
//  WBBarItemImageView.h
//  Weiben
//
//  Created by wenguang pan on 2/15/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBBarItemImageView : UIImageView

@property (nonatomic, assign) id target;
@property (nonatomic) SEL action;

@end
