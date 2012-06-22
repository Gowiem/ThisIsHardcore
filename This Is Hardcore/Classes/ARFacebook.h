//
//  ARFacebook.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/21/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "FBConnect.h"

@protocol FacebookAuthorizedDelegate
- (void)didAuthorizeFacebook:(Facebook *)facebook;

@optional
- (void)didDeauthorizeFacebook:(Facebook *)facebook;
@end

@interface ARFacebook : Facebook <FBSessionDelegate>
{
    id <FacebookAuthorizedDelegate> _authDelegate;
}

@property (assign) id <FacebookAuthorizedDelegate> authDelegate;

+ (ARFacebook *)sharedARFacebook;

- (void)authorizeWithStandardPermissions;
@end
