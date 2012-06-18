//
//  TIHEventDataModel.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/15/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHEventDataModel.h"
#import "NSDictionary+NoNulls.h"

@implementation TIHEventDataModel

- (NSString *)artistName
{
    return [_properties smartObjectForKey:@"artist_name"];
}

- (NSString *)artistWebsite
{
    return [_properties smartObjectForKey:@"artist_website"];
}

- (NSString *)artistDescription
{
    return [_properties smartObjectForKey:@"description"];
}

- (NSString *)artistFBUrl
{
    return [_properties smartObjectForKey:@"facebook_url"];
}

- (NSString *)artistTwitterUrl
{
    return [_properties smartObjectForKey:@"twitter_url"];
}


- (NSDate *)startTime
{
    NSNumber *epochSeconds = [_properties smartObjectForKey:@"start_time"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[epochSeconds doubleValue]];
    return date;
}

- (NSDate *)endTime
{
    NSNumber *epochSeconds = [_properties smartObjectForKey:@"end_time"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[epochSeconds doubleValue]];
    return date;
}


@end

/*
 - (NSString *) artistName;
 - (NSString *) artistDescription;
 - (NSString *) artistWebsite;
 - (NSString *) artistFBUrl;
 - (NSString *) artistTwitterUrl;
 - (NSString *) imageUrl;
 - (NSString *) iconUrl;
 - (NSDate *) startTime;
 - (NSDate *) endTime;
*/