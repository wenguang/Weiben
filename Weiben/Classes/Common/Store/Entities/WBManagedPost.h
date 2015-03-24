//
//  WBManagedPost.h
//  Weiben
//
//  Created by wenguang pan on 1/2/15.
//  Copyright (c) 2015 wenguang. All rights reserved.
//

#import "WBDataManager.h"
#import "ObjectiveRecord.h"
#import "ObjectiveSugar.h"

@class WBManagedTag;

@interface WBManagedPost : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSNumber * star;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSSet *tags;
@end

@interface WBManagedPost (CoreDataGeneratedAccessors)

- (void)addTagsObject:(WBManagedTag *)value;
- (void)removeTagsObject:(WBManagedTag *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
