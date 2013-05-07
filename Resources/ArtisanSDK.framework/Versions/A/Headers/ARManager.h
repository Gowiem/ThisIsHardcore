//
//  ARManager.h
//
//  Copyright (c) 2013 Artisan Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * This string constant can be used to set an boolean value @YES or @NO in the options dictionary which is an optional argument to startWithAppId:version:options:. Setting this to @NO will allow no one to perform the gesture on a device. The gesture recognizer is not added. @YES is the default.
 */
extern NSString *const ARManagerShouldAllowArtisanGesture;

/**
* Initializes Artisan and manages its lifecycle.
*
* ARManager is a singleton that is automatically initialized when your app starts.  Use ARManager to connect to Artisan and automatically download all experiments, configuration, and published changes for your app.
*
*/

@interface ARManager : NSObject

/** Start your Artisan instance.
*
* Use this method to start Artisan.  This declaration should occur at the top of the `didFinishLaunchingWithOptions:` method of your main app delegate.
*
* @param appId The Artisan ID for your app (e.g. '506adf5ed6fbbc5222000018'). This ID is available in your Aritsan Tools dashboard.
*
* @param version The Artisan version number for your app (e.g '1.0'). This corresponds with the 'Current Version' value in your Artisan Tools dashboard for this app.
*/
+(void)startWithAppId:(NSString *)appId version:(NSString *)version;


/** Start your Artisan instance.
*
* Use this method to start Artisan.  This declaration should occur at the top of the `didFinishLaunchingWithOptions:` method of your main app delegate.
*
* @param appId The Artisan ID for your app (e.g. '506adf5ed6fbbc5222000018'). This ID is available in your Aritsan Tools dashboard.
*
* @param version The Artisan version number for your app (e.g '1.0'). This corresponds with the 'Current Version' value in your Artisan Tools dashboard for this app.
*
* @param options Dictionary of configuration options. These options will override the Artisan defaults.
*/
+(void)startWithAppId:(NSString *)appId version:(NSString *)version options:(NSDictionary *)options;

@end
