//
//  TIHPhotoPitDataModel.m
//  This Is Hardcore
//
//  Created by Odin on 6/13/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHPhotoPitDataModel.h"
#import "NSDate+Formatting.h"

@implementation TIHPhotoPitDataModel

- (NSString *)photoId
{
    return [_properties objectForKey:@"id"];
}

- (NSString *)createdAgo
{
    return [[self createdAt] distanceOfTimeInWords];
}

- (NSDate *)createdAt
{
    NSNumber *epochSeconds = [[_properties objectForKey:@"value"] objectForKey:@"created_at"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[epochSeconds doubleValue]];
    return date;
}

- (NSString *)imageUrl
{
    return [[_properties objectForKey:@"value"] objectForKey:@"url"];
}

- (NSArray *)tags
{
    return [[_properties objectForKey:@"value"] objectForKey:@"tags"];
}

- (NSString *)tagDisplay
{
    return [self.tags componentsJoinedByString:@","];
}


- (NSString *)body
{
    return [[_properties objectForKey:@"value"] objectForKey:@"body"];
}



@end
