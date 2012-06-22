//
//  TIHEventDataModel.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/15/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHEventDataModel.h"
#import "NSDictionary+NoNulls.h"
#import "TIHBookmarkManager.h"

@implementation TIHEventDataModel

- (NSNumber *) eventId
{
    return [_properties smartObjectForKey:@"id"];
}

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

- (NSString *)venueName
{
    return [_properties smartObjectForKey:@"venue"];
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

- (NSString *) setTimeDisplay
{
    NSDateFormatter *startDateFormat = [[NSDateFormatter alloc] init];
    [startDateFormat setDateFormat:@"h:mm"];
    NSDateFormatter *endDateFormat = [[NSDateFormatter alloc] init];
    [endDateFormat setDateFormat:@"h:mm a"];
    
    NSString *startDateString = [startDateFormat stringFromDate:[self startTime]];
    NSString *endDateString = [endDateFormat stringFromDate:[self endTime]];
    
    return [NSString stringWithFormat:@"%@ - %@", startDateString, endDateString];
}

- (NSString *)iconUrl
{
    return [_properties smartObjectForKey:@"icon_url"];
}

- (NSString *)imageUrl
{
    return [_properties smartObjectForKey:@"image_url"];
}

- (NSComparisonResult)compare:(TIHEventDataModel *)otherObject {
    return [self.startTime compare:otherObject.startTime];
}

- (bool)isEventBookmarked
{
    NSSet *bookmarks = [[[TIHBookmarkManager alloc] init] getBookmarks];
    return [bookmarks containsObject:[self eventId]];
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