//
//  TIHLocalNotificationManager.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/30/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHEventDataModel.h"
#import <Foundation/Foundation.h>

@interface TIHLocalNotificationManager : NSObject

-(void)registerNotificationByEvent: (TIHEventDataModel*) event;
-(void)cancelNotificationByEventId: (NSNumber*) eventId;

@end
