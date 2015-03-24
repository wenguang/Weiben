//
//  WBMainViewController.h
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBMainViewInterface.h"
#import "WBMainModuleInterface.h"

@interface WBMainViewController : UIViewController <WBMainViewInterface, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) id<WBMainModuleInterface> eventHandler;

@end
