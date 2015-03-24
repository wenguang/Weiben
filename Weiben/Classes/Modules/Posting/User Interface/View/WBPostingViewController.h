//
//  WBWritingViewController.h
//  Weiben
//
//  Created by wenguang pan on 11/30/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPostingViewInterface.h"
#import "WBPostingModuleInterface.h"

@class WBPostDisplayData;

typedef NS_ENUM(NSInteger, WBPostViewMode)
{
    WBPostViewModeEditing,
    WBPostViewModeDetail
};

@interface WBPostingViewController : UIViewController <WBPostingViewInterface, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, CLLocationManagerDelegate, UIScrollViewDelegate, UITextViewDelegate>

@property (nonatomic, strong) id<WBPostingModuleInterface> eventHandler;
@property (nonatomic,strong) NSString *postID;
@property (nonatomic, strong) WBPostDisplayData *displayData;
@property (nonatomic, assign) WBPostViewMode mode;

- (void)preImage:(UIImage *)image;

@end
