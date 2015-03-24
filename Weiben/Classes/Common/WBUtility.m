//
//  Utility.m
//  Weiben
//
//  Created by wenguang pan on 12/4/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBUtility.h"
#import "WBPostItem.h"
#import "WBPost.h"

@implementation WBUtility

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (UIViewController *)instantiateViewControllerWithStoryboardName:(NSString *)storyboardName viewControllerID:(NSString *)viewControllerID
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    return viewController;
}

+ (NSString *)stringForPlacemark:(CLPlacemark *)placemark
{
    NSString *placeDescription = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", placemark.country ? [placemark.country stringByAppendingString:@""] : @"", placemark.administrativeArea ? [placemark.administrativeArea stringByAppendingString:@""] : @"", placemark.subAdministrativeArea ? [placemark.subAdministrativeArea stringByAppendingString:@""] : @"", placemark.locality ? [placemark.locality stringByAppendingString:@""] : @"", placemark.subLocality ? [placemark.subLocality stringByAppendingString:@""] : @"", placemark.thoroughfare ? [placemark.thoroughfare stringByAppendingString:@""] : @"", placemark.subThoroughfare ? [placemark.subThoroughfare stringByAppendingString:@""] : @""];
    return placeDescription;
}

+ (WBPostItem *)getItemWithPost:(WBPost *)post
{
    WBPostItem *item;
    if (post)
    {
        UIImage *image = post.imageData ? [UIImage imageWithData:post.imageData] : nil;
        item = [WBPostItem postItemWithText:post.text image:image date:post.date star:post.star location:post.location place:post.place tags:nil identifier:post.identifier];
    }
    return item;
}

+ (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (NSString *)postChangedNotification
{
    return @"PostCountChangedNotification";
}
+ (NSString *)postChangedAction;
{
    return @"action";
}
+ (NSString *)postChangedActionAdd
{
    return @"add";
}
+ (NSString *)postChangedActionUpdate
{
    return @"update";
}
+ (NSString *)postChangedActionDelete
{
    return @"delete";
}
+ (NSString *)postChangedItem
{
    return @"postItem";
}
+ (NSString *)postDeletedItemID
{
    return @"postItemID";
}

@end
