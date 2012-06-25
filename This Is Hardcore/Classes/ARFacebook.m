/*  ARFacebook.m
 *  appRenaissance
 *
 *  Created by Kevin Clough on 6/21/12.
 *  Copyright 2012 appRenaissance, LLC. All rights reserved.
 *
 */

#import "ARFacebook.h"
#import "TIHApplicationConfiguration.h"

@implementation ARFacebook

@synthesize authDelegate;

- (id)init
{
    self = [super initWithAppId:FB_API_KEY andDelegate:self];
    if(self)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"])
        {
            self.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
            self.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        }
    }
    return self;
}

- (void)authorizeWithStandardPermissions
{
    [self authorize:[NSArray arrayWithObjects:@"email", @"publish_stream", @"read_stream", @"offline_access", nil]];
}

- (void)fbDidLogin
{
    /* save access token and exp date to a cookie */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[self accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[self expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    [authDelegate didAuthorizeFacebook:self];
}

- (void)fbDidNotLogin:(BOOL)cancelled
{}

- (void)fbDidLogout
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    [authDelegate didDeauthorizeFacebook:self];
}

+ (ARFacebook *)sharedARFacebook
{
    static ARFacebook *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ARFacebook alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

@end
