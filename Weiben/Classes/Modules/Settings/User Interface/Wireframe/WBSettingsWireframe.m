//
//  WBSettingsWireframe.m
//  Weiben
//
//  Created by wenguang pan on 12/14/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBSettingsWireframe.h"
#import "WBSettingsViewController.h"
#import "WBSettingsPresenter.h"

#import "WBUtility.h"

static NSString *settingsViewControllerID = @"WBSettingsViewController";

@interface WBSettingsWireframe()

@property (nonatomic, strong) WBSettingsViewController *settingsViewController;

@end

@implementation WBSettingsWireframe

- (void)showSettingsViewFromViewController:(UIViewController *)fromViewController
{
    if (self.settingsViewController == nil)
    {
        self.settingsViewController = [self instantiateViewController];
        self.settingsViewController.eventHandler = self.settingsPresenter;
        self.settingsPresenter.userInterface = self.settingsViewController;
    }
    [fromViewController.navigationController pushViewController:self.settingsViewController animated:YES];
}
- (void)dismissSettingsView
{
    
}

#pragma mark - Private

- (WBSettingsViewController *)instantiateViewController
{
    return (WBSettingsViewController *)[WBUtility instantiateViewControllerWithStoryboardName:@"Main" viewControllerID:settingsViewControllerID];
}

@end
