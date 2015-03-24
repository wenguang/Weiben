//
//  WBDetailBackgroundView.m
//  Weiben
//
//  Created by wenguang pan on 3/22/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBDetailBackgroundView.h"

@interface WBDetailBackgroundView()
{
    UIImageView *_imageView;
}
@end

@implementation WBDetailBackgroundView

- (instancetype)initWithFrame:(CGRect)rect image:(UIImage *)image imageHeight:(CGFloat)imageHeight
{
    if (self = [super initWithFrame:rect])
    {
        _imageOffsetY = 0;
        _imageHeight = 0;
        
        if (image)
        {
            _image = image;
            _imageHeight = imageHeight;
            
            
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, imageHeight)];
            _imageView.contentMode = UIViewContentModeScaleAspectFill;
            _imageView.image = _image;
            [self addSubview:_imageView];
        }
    }
    return self;
}

- (void)setImageOffsetY:(CGFloat)imageOffsetY
{
    if (_image)
    {
        _imageOffsetY = imageOffsetY;
        _imageView.frame = CGRectMake(0, -imageOffsetY/2, self.frame.size.width, _imageHeight);
    }
}

@end
