//
//  WBPhotosViewController.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPhotosViewInterface.h"
#import "WBPhotosModuleInterface.h"

@interface WBPhotosViewController : UIViewController <WBPhotosViewInterface, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) id<WBPhotosModuleInterface> eventHandler;

@end
