//
//  WBWritingModuleInterface.h
//  Weiben
//
//  Created by wenguang pan on 11/30/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPostDisplayData.h"

@protocol WBPostingModuleInterface <NSObject>

- (void)requestPostWithIdentifier:(NSString *)identifier;
- (void)savePostWithText:(NSString *)text tags:(NSArray *)tags image:(UIImage *)image star:(BOOL)star location:(CLLocation *)location place:(NSString *)place;
- (void)updatePost:(WBPostDisplayData *)displayData;
- (void)cancelPost;
- (void)deletePost:(NSString *)postID;

@end
