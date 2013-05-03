//
//  GoogleAnalytics.m
//  appRenaissance
//
//  Created by Scott Wasserman on 10/15/10.
//  Copyright 2010 appRenaissance. All rights reserved.
//

#import "GoogleAnalytics.h"
#import "GAI.h"
#import "TIHApplicationConfiguration.h"

// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 10;

@interface GoogleAnalytics () {
    id<GAITracker> tracker;
}


@end

@implementation GoogleAnalytics

+ (id)instance
{
    static dispatch_once_t once;
    static GoogleAnalytics *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [GAI sharedInstance].trackUncaughtExceptions = YES;
        [GAI sharedInstance].dispatchInterval = kGANDispatchPeriodSec;
        // Enable debug mode.
        // [GAI sharedInstance].debug = YES;
        tracker = [[GAI sharedInstance] trackerWithTrackingId:GOOGLE_ANALYTICS_ACCOUNT_ID];
        [GAI sharedInstance].defaultTracker = tracker;
    }
    return self;
}

+ (void)startTracker {
	[[GoogleAnalytics instance] trackEvent:@"Started app"];
}

+ (void)stopTracker {
	[[GoogleAnalytics instance] trackEvent:@"Exited app"];
}

- (void)trackEvent:(NSString*)actionName {
	if (![[GAI sharedInstance].defaultTracker sendEventWithCategory:[NSString stringWithFormat:@"%@ iphone test", PERSONA_TITLE]
                                                         withAction:actionName
                                                          withLabel:@""
                                                          withValue:0]) {
		// Handle error here
		NSLog(@"Failed to track event %@", actionName);
	}
}

- (void)trackPageView:(NSString*)pageName {
	if (![[GAI sharedInstance].defaultTracker sendView:[NSString stringWithFormat:@"/%@",pageName]]) {
		// Handle error here
		NSLog(@"Failed to track event %@", pageName);
	}
}

@end
