//
//  TIHApplicationConfiguration.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

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

/* Google Analytics configuration */
extern NSString *const GOOGLE_ANALYTICS_ACCOUNT_ID;

/* UNIFEED API configuration */
#if 1
    #define UNIFEED_API_PROTOCOL @"http"
    #define UNIFEED_API_HOST @"unifeed.heroku.com"
    #define UNIFEED_API_PORT @"80"
    #define UNIFEED_API_ROOT @"api-v2"
#else
    //#define UNIFEED_API_PROTOCOL @"http"
    //#define UNIFEED_API_HOST @"unifeed-staging.heroku.com"
    //#define UNIFEED_API_PORT @"80"
    //#define UNIFEED_API_ROOT @"api-v2"
    #define UNIFEED_API_PROTOCOL @"http"
    #define UNIFEED_API_HOST @"unifeed.10.0.1.27.xip.io"
    #define UNIFEED_API_PORT @"80"
    #define UNIFEED_API_ROOT @"api-v2"
    //#define UNIFEED_API_PROTOCOL @"http"
    //#define UNIFEED_API_HOST @"localhost"
    //#define UNIFEED_API_PORT @"3000"
    //#define UNIFEED_API_ROOT @"api-v2"
  
#endif

#define UNIFEED_USER_API_PREFIX [NSString stringWithFormat:@"%@://%@:%@", UNIFEED_API_PROTOCOL, UNIFEED_API_HOST, UNIFEED_API_PORT ]
#define UNIFEED_API_PREFIX [NSString stringWithFormat:@"%@://%@:%@/%@", UNIFEED_API_PROTOCOL, UNIFEED_API_HOST, UNIFEED_API_PORT, UNIFEED_API_ROOT ]
#define UNIFEED_API_URL [NSString stringWithFormat:@"%@/%@", UNIFEED_API_PREFIX, PERSONA_ID ]