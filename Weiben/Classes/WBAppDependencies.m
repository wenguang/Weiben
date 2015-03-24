//
//  WBAppDependencies.m
//  Weiben
//
//  Created by wenguang pan on 11/25/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBAppDependencies.h"

#import "WBMainInteractor.h"
#import "WBMainPresenter.h"
#import "WBMainWireframe.h"
#import "WBPhotosInteractor.h"
#import "WBPhotosPresenter.h"
#import "WBPhotosWireframe.h"
#import "WBTagsInteractor.h"
#import "WBTagsPresenter.h"
#import "WBTagsWireframe.h"
#import "WBTimelineInteractor.h"
#import "WBTimelinePresenter.h"
#import "WBTimelineWireframe.h"
#import "WBStarredInteractor.h"
#import "WBStarredPresenter.h"
#import "WBStarredWireframe.h"
#import "WBPostingInteractor.h"
#import "WBPostingPresenter.h"
#import "WBPostingWireframe.h"
#import "WBDetailInteractor.h"
#import "WBDetailPresenter.h"
#import "WBDetailWireframe.h"
#import "WBSettingsInteractor.h"
#import "WBSettingsPresenter.h"
#import "WBSettingsWireframe.h"

@interface WBAppDependencies()

// MainWireframe will connect other wireframes and their module
@property (nonatomic, strong) WBMainWireframe *mainWireframe;

@end

@implementation WBAppDependencies

- (id)init
{
    if ((self = [super init]))
    {
        [self configure];
    }
    
    return self;
}

- (void)installRootViewIntoWindow:(UIWindow *)window
{
    [self.mainWireframe showMainViewFromWindow:window];
}

- (void)configure
{
    // Main module
    WBMainInteractor *mainInteractor = [[WBMainInteractor alloc] init];
    WBMainPresenter *mainPresenter = [[WBMainPresenter alloc] init];
    self.mainWireframe = [[WBMainWireframe alloc] init];
    
    // Photos module
    WBPhotosInteractor *photosInteractor = [[WBPhotosInteractor alloc] init];
    WBPhotosPresenter *photosPresenter = [[WBPhotosPresenter alloc] init];
    WBPhotosWireframe *photosWireframe = [[WBPhotosWireframe alloc] init];
    
    // Tags module
    WBTagsInteractor *tagsInteractor = [[WBTagsInteractor alloc] init];
    WBTagsPresenter *tagsPresenter = [[WBTagsPresenter alloc] init];
    WBTagsWireframe *tagsWireframe = [[WBTagsWireframe alloc] init];
    
    // Timeline module
    WBTimelineInteractor *timelineInteractor = [[WBTimelineInteractor alloc] init];
    WBTimelinePresenter *timelinePresenter = [[WBTimelinePresenter alloc] init];
    WBTimelineWireframe *timelineWireframe = [[WBTimelineWireframe alloc] init];
    
    // Starred momule
    WBStarredInteractor *starredInteractor = [[WBStarredInteractor alloc] init];
    WBStarredPresenter *starredPresenter = [[WBStarredPresenter alloc] init];
    WBStarredWireframe *starredWireframe = [[WBStarredWireframe alloc] init];
    
    // Posting module
    WBPostingInteractor *postingInteractor = [[WBPostingInteractor alloc] init];
    WBPostingPresenter *postingPresenter = [[WBPostingPresenter alloc] init];
    WBPostingWireframe *postingWireframe = [[WBPostingWireframe alloc] init];
    
    // Detail module
    WBDetailInteractor *detailInteractor = [[WBDetailInteractor alloc] init];
    WBDetailPresenter *detailPresenter = [[WBDetailPresenter alloc] init];
    WBDetailWireframe *detailWireframe = [[WBDetailWireframe alloc] init];
    
    // Settings module
    WBSettingsInteractor *settingsInteractor = [[WBSettingsInteractor alloc] init];
    WBSettingsPresenter *settingsPresenter = [[WBSettingsPresenter alloc] init];
    WBSettingsWireframe *settingsWireframe = [[WBSettingsWireframe alloc] init];
    
    // Main module
    mainInteractor.output = mainPresenter;
    mainPresenter.mainInteractor = mainInteractor;
    mainPresenter.mainWireframe = self.mainWireframe;
    self.mainWireframe.mainPresenter = mainPresenter;
    self.mainWireframe.photosWireframe = photosWireframe;
    self.mainWireframe.tagsWireframe = tagsWireframe;
    self.mainWireframe.timelineWireframe = timelineWireframe;
    self.mainWireframe.starredWireframe = starredWireframe;
    self.mainWireframe.postingWireframe = postingWireframe;
    self.mainWireframe.settingsWireframe = settingsWireframe;
    
    // Photos module
    photosInteractor.output = photosPresenter;
    photosPresenter.photosInteractor = photosInteractor;
    photosPresenter.photosWireframe = photosWireframe;
    photosWireframe.photosPresenter = photosPresenter;
    photosWireframe.postingWireframe = postingWireframe;
    photosWireframe.detailWireframe = detailWireframe;
    
    // Tags module
    tagsInteractor.output = tagsPresenter;
    tagsPresenter.tagsInteractor = tagsInteractor;
    tagsPresenter.tagsWireframe = tagsWireframe;
    tagsWireframe.tagsPresenter = tagsPresenter;
    tagsWireframe.postingWireframe = postingWireframe;
    tagsWireframe.detailWireframe = detailWireframe;
    
    // Timeline module
    timelineInteractor.output = timelinePresenter;
    timelinePresenter.timelineInteractor = timelineInteractor;
    timelinePresenter.timelineWireframe = timelineWireframe;
    timelineWireframe.timelinePresenter = timelinePresenter;
    timelineWireframe.posingWireframe = postingWireframe;
    timelineWireframe.detailWireframe = detailWireframe;
    
    // Starred module
    starredInteractor.output = starredPresenter;
    starredPresenter.starredInteractor = starredInteractor;
    starredPresenter.starredWireframe = starredWireframe;
    starredWireframe.starredPresenter = starredPresenter;
    starredWireframe.postingWireframe = postingWireframe;
    
    // Posting module
    postingInteractor.output = postingPresenter;
    postingPresenter.postingInteractor = postingInteractor;
    postingPresenter.postingWireframe = postingWireframe;
    postingWireframe.postingPresenter = postingPresenter;
    postingWireframe.detailWireframe = detailWireframe;
    
    // Detail module
    detailInteractor.output = detailPresenter;
    detailPresenter.detailInteractor = detailInteractor;
    detailPresenter.detailWireframe = detailWireframe;
    detailWireframe.detailPresenter = detailPresenter;
    detailWireframe.postingWireframe = postingWireframe;
    
    // Settings module
    settingsInteractor.output = settingsPresenter;
    settingsPresenter.settingsInteractor = settingsInteractor;
    settingsPresenter.settingsWireframe = settingsWireframe;
    settingsWireframe.settingsPresenter = settingsPresenter;
}

@end
