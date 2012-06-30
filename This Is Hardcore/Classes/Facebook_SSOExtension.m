//
//  Facebook_SSOExtension.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/30/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "Facebook_SSOExtension.h"

@interface Facebook(PrivateSSOExtension)
- (void)authorizeWithFBAppAuth:(BOOL)tryFBAppAuth
                    safariAuth:(BOOL)trySafariAuth;
-(void) setPermissions:(NSArray*) permissions;
@end 

@implementation Facebook(SSOExtension)
-(void) authorize:(NSArray*)permissions useSSO:(BOOL) useSSO
{
    [self setPermissions: permissions];
    [self authorizeWithFBAppAuth:useSSO safariAuth:useSSO];
}
@end
