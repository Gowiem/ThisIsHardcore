//
//  Facebook_SSOExtension.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/30/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "Facebook.h"

@interface Facebook(SSOExtension)
-(void) authorize:(NSArray*)permissions useSSO:(BOOL) useSSO;
@end
