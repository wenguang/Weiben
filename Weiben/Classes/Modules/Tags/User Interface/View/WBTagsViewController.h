//
//  WBTagsViewController.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTagsModuleInterface.h"
#import "WBTagsViewInterface.h"

@interface WBTagsViewController : UIViewController <WBTagsViewInterface>

@property (nonatomic, strong) id<WBTagsModuleInterface> eventHandler;

@end
