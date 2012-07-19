//
//  TIHDirectionManager.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 7/19/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHDirectionManager.h"

@implementation TIHDirectionManager

+ (NSString*) getDirectionsUrlForVenue: (NSString*) venueName
{
    venueName = [venueName lowercaseString];
    if ([venueName isEqualToString:@"union transfer"]) {
        return @"http://goo.gl/maps/14kG";
    } else if ([venueName isEqualToString:@"electric factory"] || [venueName isEqualToString:@"the electric factory"]) {
        return @"http://goo.gl/maps/crNL1";
    } else if ([venueName isEqualToString:@"phila moca"] || [venueName isEqualToString:@"philamoca"]) {
        return @"http://goo.gl/maps/uVKb";
    } else if ([venueName isEqualToString:@"barbary"] || [venueName isEqualToString:@"the barbary"]) {
        return @"http://goo.gl/maps/1tY1";
    }
    else {
        return nil;
    }
}
                                                             
@end
