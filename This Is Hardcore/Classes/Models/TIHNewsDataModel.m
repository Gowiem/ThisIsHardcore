//
//  TIHNewsDataModel.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "NSString+AppRenaissance.h"
#import "TIHNewsDataModel.h"

@implementation TIHNewsDataModel

- (NSString *)newsId
{
    return [_properties objectForKey:@"id"];
}

- (NSString *)provider
{
    return [[_properties objectForKey:@"value"] objectForKey:@"provider"];
}

- (NSDate *)createdAt
{
    NSNumber *epochSeconds = [[_properties objectForKey:@"value"] objectForKey:@"created_at"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[epochSeconds doubleValue]];
    return date;
}

- (NSString *)body
{
    return [[_properties objectForKey:@"value"] objectForKey:@"body"];
}

- (NSString *)newsUrl
{
    return [[_properties objectForKey:@"value"] objectForKey:@"url"];
}

- (BOOL)hasURL
{
    return (![[self newsUrl] isBlank]);
}
@end
