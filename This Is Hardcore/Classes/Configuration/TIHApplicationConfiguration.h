//
//  TIHApplicationConfiguration.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "PersonaTypes.h"

/* Application Version */
extern NSString *const VersionNumber;

/* Persona */
extern NSString *const PERSONA_ID;
extern NSString *const PERSONA_TITLE;
extern const NSInteger PERSONA_TYPE;

/* Application Version */
extern const NSInteger MajorVersionNumber;
extern const NSInteger MinorVersionNumber;

/* General Settings */
extern const NSInteger NUM_OF_ITEMS_PER_API_REQUEST;
extern const NSInteger CACHE_INVALIDATION_AGE;

/* Facebook API configuration */
extern NSString *const FB_API_KEY;
extern NSString *const FB_SECRET;

/* Twitter API configuration */
extern NSString *const TWITTER_CONSUMER_KEY;
extern NSString *const TWITTER_CONSUMER_SECRET;

/* UNIFEED API configuration */
#define UNIFEED_API_PROTOCOL @"http"
#define UNIFEED_API_HOST @"allfanz-unifeed.heroku.com"
#define UNIFEED_API_PORT @"80"
#define UNIFEED_API_ROOT @"api"

#define UNIFEED_USER_API_PREFIX [NSString stringWithFormat:@"%@://%@:%@", UNIFEED_API_PROTOCOL, UNIFEED_API_HOST, UNIFEED_API_PORT ]
#define UNIFEED_API_PREFIX [NSString stringWithFormat:@"%@://%@:%@/%@", UNIFEED_API_PROTOCOL, UNIFEED_API_HOST, UNIFEED_API_PORT, UNIFEED_API_ROOT ]