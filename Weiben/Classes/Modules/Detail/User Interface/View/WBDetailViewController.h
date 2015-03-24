//
//  WBDetailViewController.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBDetailViewInterface.h"
#import "WBDetailModuleInterface.h"

@interface WBDetailViewController : UIViewController <WBDetailViewInterface>

@property (nonatomic, strong) id<WBDetailModuleInterface> eventHandler;

@end
