//
//  GoogleAnalytics.h
//  appRenaissance
//
//  Created by Scott Wasserman on 10/15/10.
//  Copyright 2010 appRenaissance. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GoogleAnalytics : NSObject {
	
}

+ (id)instance;

+ (void)startTracker;
+ (void)stopTracker;
- (void)trackEvent:(NSString*)actionName;
- (void)trackPageView:(NSString*)pageName;

@end
