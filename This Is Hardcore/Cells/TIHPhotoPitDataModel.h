//
//  TIHPhotoPitDataModel.h
//  This Is Hardcore
//
//  Created by Odin on 6/13/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHBaseDataModel.h"

@interface TIHPhotoPitDataModel : TIHBaseDataModel

- (NSString *)photoId;
- (NSDate *)createdAt;
- (NSString *)createdAgo;
- (NSString *)imageUrl;
- (NSArray *)tags;
- (NSString *)tagDisplay;

@end
