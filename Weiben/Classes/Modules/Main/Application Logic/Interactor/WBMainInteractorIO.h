//
//  WBMainInteractorIO.h
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@protocol WBMainInteractorInput <NSObject>

- (void)findPostStatistics;

@end

@protocol WBMainInteractorOutput <NSObject>

- (void)foundPostStatistics:(NSArray *)items;

@end
