//
//  TIHEventDataModel.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/15/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHBaseDataModel.h"

@interface TIHEventDataModel : TIHBaseDataModel

- (int) eventId;
- (NSString *) artistName;
- (NSString *) artistDescription;
- (NSString *) artistWebsite;
- (NSString *) artistFBUrl;
- (NSString *) artistTwitterUrl;
- (NSString *) imageUrl;
- (NSString *) iconUrl;
- (NSDate *) startTime;
- (NSDate *) endTime;

@end
