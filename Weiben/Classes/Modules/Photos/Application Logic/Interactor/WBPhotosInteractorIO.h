//
//  WBPhotosInteractorIO.h
//  Weiben
//
//  Created by wenguang pan on 12/15/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@protocol WBPhotosInteractorInput <NSObject>

- (void)findPhotoPosts;

@end

@protocol WBPhotosInteractorOutput <NSObject>

- (void)foundPhotoPosts:(NSArray *)posts;

@end
