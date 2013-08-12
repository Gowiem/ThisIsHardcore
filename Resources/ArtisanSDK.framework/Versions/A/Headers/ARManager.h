//
//  ARManager.h
//
//  Copyright (c) 2013 Artisan Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * This string constant can be used to set an boolean value @YES or @NO in the options dictionary which is an optional argument to startWithAppId:version:options:. Setting this to @YES will allow no one to perform the gesture on a device. The gesture recognizer is not added. @NO is the default.
 */
extern NSString *const ARManagerNeverEnableArtisanGesture;

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

/** Manually fetch Artisan updates.
 *
 * Use this method to manually fetch Artisan updates for your app. Updates are fetched asynchronously, and this method returns immediately.
 * 
 * @param completionBlock An optional block to be called when the playlist download is complete. The block receives a single argument, a BOOL error parameter. If you don't need a completion block, just pass nil. The block will be called on the main thread.
 *
 * @warning In normal usage, it is *not* necessary to call this method, as it is automatically called by Artisan internally. This should only be used when implementing custom segmenting and targeting.
 */
+ (void)fetchArtisanUpdates:(void (^)(BOOL error))completionBlock;

@end
