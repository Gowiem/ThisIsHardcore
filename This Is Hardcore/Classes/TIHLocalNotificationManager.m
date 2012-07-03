//
//  TIHLocalNotificationManager.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/30/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHLocalNotificationManager.h"

@implementation TIHLocalNotificationManager

-(void)registerNotificationByEvent: (TIHEventDataModel*) event
{
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.fireDate = [NSDate date]; // show now, but you can set other date to schedule

    localNotif.alertBody = [event setTimeDisplay];
    localNotif.alertAction = @"View Event"; // action button title
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.repeatInterval = 0;
    // keep some info for later use
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:[event eventId] forKey:@"ID"];
    localNotif.userInfo = infoDict;

    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

-(void)cancelNotificationByEventId: (NSNumber*) eventId
{
    NSString *myIDToCancel = [eventId stringValue];
    UILocalNotification *notificationToCancel=nil;
    for(UILocalNotification *aNotif in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if([[aNotif.userInfo objectForKey:@"ID"] isEqualToString:myIDToCancel]) {
            notificationToCancel=aNotif;
            break;
        }
    }
    [[UIApplication sharedApplication] cancelLocalNotification:notificationToCancel];
}
@end
