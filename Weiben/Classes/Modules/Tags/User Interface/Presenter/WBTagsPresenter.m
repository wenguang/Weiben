//
//  WBTagsPresenter.m
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTagsPresenter.h"
#import "WBTagsWireframe.h"

@implementation WBTagsPresenter

#pragma mark - WBTagsModuleInterface

- (void)toPostingView
{
    [self.tagsWireframe showPostingView];
}
- (void)toDetailView
{
    [self.tagsWireframe showDetailView];
}

@end
