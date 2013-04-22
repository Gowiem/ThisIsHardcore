//
//  GoogleAnalytics.m
//  appRenaissance
//
//  Created by Scott Wasserman on 10/15/10.
//  Copyright 2010 appRenaissance. All rights reserved.
//

#import "GoogleAnalytics.h"
#import "GANTracker.h"
#import "TIHApplicationConfiguration.h"

// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 10;

@implementation GoogleAnalytics

+ (void)startTracker {
//	[[GANTracker sharedTracker] startTrackerWithAccountID:GOOGLE_ANALYTICS_ACCOUNT_ID
//										   dispatchPeriod:kGANDispatchPeriodSec
//												 delegate:nil];
//	[GoogleAnalytics trackEvent:@"Started app"];
}

+ (void)stopTracker {
//	[GoogleAnalytics trackEvent:@"Exited app"];
//	[[GANTracker sharedTracker] stopTracker];
}

+ (void)trackEvent:(NSString*)actionName {
//	NSError *error;
//	if (![[GANTracker sharedTracker] trackEvent:[NSString stringWithFormat:@"%@ iphone", PERSONA_TITLE]
//										 action:actionName
//										  label:@""
//										  value:0
//									  withError:&error]) {
//		// Handle error here
//		NSLog(@"Failed to track event %@ because %@",actionName,[error localizedFailureReason]);
//	}
}

+ (void)trackPageView:(NSString*)pageName {
//	NSError *error;
//	if (![[GANTracker sharedTracker] trackPageview:[NSString stringWithFormat:@"/%@",pageName]
//										 withError:&error]) {
//		// Handle error here
//		NSLog(@"Failed to track event %@ because %@, localized failure reason %@",pageName, [error description], [error localizedFailureReason]);
//	}
}

@end
