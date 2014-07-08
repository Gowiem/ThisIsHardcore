//
//  TIHAppDelegate.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHAppDelegate.h"
#import "ARFacebook.h"
#import "SDURLCache.h"
#import "TIHScheduleViewController.h"
#import "GoogleAnalytics.h"
#import "TIHCalendarEventManager.h"

@implementation TIHAppDelegate

@synthesize window = _window;
//@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Start analytics
    [GoogleAnalytics startTracker];
    
    [[TIHCalendarEventManager instance] requestAccessOnInit];
    
    // Handle launching from a notification
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        NSLog(@"Recieved Notification %@",localNotif);
        UIAlertView *dialog=[[UIAlertView alloc] initWithTitle:[localNotif alertAction] message:[localNotif alertBody] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [dialog show];
    }
    
    SDURLCache *urlCache = [[SDURLCache alloc] initWithMemoryCapacity:1024*1024   // 1MB mem cache
                                                         diskCapacity:1024*1024*5 // 5MB disk cache
                                                             diskPath:[SDURLCache defaultCachePath]];
    [NSURLCache setSharedURLCache:urlCache];

	/* Artisan Manager start-up code; please note, if you have multiple exit points in this method
	 * you will need to copy and paste the ARManager call before each occurrence of return YES */
    //	{ [ARManager startWithAppId:@"51886333369b05380e000033" version:@"1.0" options:nil]; return YES; }
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
    NSLog(@"Recieved Notification %@",notif);
    UIAlertView *dialog=[[UIAlertView alloc] initWithTitle:[notif alertAction] message:[notif alertBody] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
    [dialog show];
}

- (NSDate*)getFestivalStartDatePlus:(int)daysLater
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setHour:0];
    [comps setDay: 8 + daysLater];
    [comps setMonth:8];
    [comps setYear:2013];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    return [gregorian dateFromComponents:comps];
}

// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    ARFacebook *facebook = [ARFacebook sharedARFacebook];
    return [facebook handleOpenURL:url]; 
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    ARFacebook *facebook = [ARFacebook sharedARFacebook];
    return [facebook handleOpenURL:url]; 
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // Stop analytics
    [GoogleAnalytics stopTracker];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
