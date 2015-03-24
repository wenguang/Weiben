//
//  WBWritingInteractor.h
//  Weiben
//
//  Created by wenguang pan on 12/1/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBPostingInteractorIO.h"

@interface WBPostingInteractor : NSObject <WBPostingInteractorInput>

@property (nonatomic, strong) id<WBPostingInteractorOutput> output;

@end
