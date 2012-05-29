//
//  TIHNewsDataModel.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHBaseDataModel.h"

@interface TIHNewsDataModel : TIHBaseDataModel

- (NSString *)newsId;
- (NSString *)provider;
- (NSDate *)createdAt;
- (NSString *)body;
- (NSString *)newsUrl;
- (BOOL)hasURL;

@end
