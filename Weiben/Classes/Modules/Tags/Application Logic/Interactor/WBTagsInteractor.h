//
//  WBTagsInteractor.h
//  Weiben
//
//  Created by wenguang pan on 12/9/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBTagsInteractorIO.h"

@interface WBTagsInteractor : NSObject <WBTagsInteractorInput>

@property (nonatomic, strong) id<WBTagsInteractorOutput> output;

@end
