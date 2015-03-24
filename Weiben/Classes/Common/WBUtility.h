//
//  Utility.h
//  Weiben
//
//  Created by wenguang pan on 12/4/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@class WBPostItem;
@class WBPost;

@interface WBUtility : NSObject

+ (NSURL *)applicationDocumentsDirectory;

+ (UIViewController *)instantiateViewControllerWithStoryboardName:(NSString *)storyboardName viewControllerID:(NSString *)viewControllerID;

+ (NSString *)stringForPlacemark:(CLPlacemark *)placemark;

+ (WBPostItem *)getItemWithPost:(WBPost *)post;

+ (CGSize)screenWidth;

+ (NSString *)postChangedNotification;
+ (NSString *)postChangedAction;
+ (NSString *)postChangedActionAdd;
+ (NSString *)postChangedActionUpdate;
+ (NSString *)postChangedActionDelete;
+ (NSString *)postChangedItem;
+ (NSString *)postDeletedItemID;

@end
