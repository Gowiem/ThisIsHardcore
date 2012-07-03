//
//  TIHNotificationManager.m
//  This Is Hardcore
//
//  Created by Odin on 6/18/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHNotificationManager.h"

@implementation TIHNotificationManager

+ (void)scheduleNotificationWithEvent:(TIHEventDataModel *)event {
    NSDate *itemDate = [event startTime];
    NSString *message = [event artistName];
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;

    localNotif.fireDate = [itemDate dateByAddingTimeInterval:-(300)];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ in %i minutes.", nil),
                            message, 5];
    localNotif.alertAction = NSLocalizedString(@"Event Reminder", nil);
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    NSMutableDictionary *infoDict = [[ NSMutableDictionary alloc] init];
    [infoDict setValue:[event startTime] forKey:@"EventDate"];
    [infoDict setValue:[NSString stringWithFormat:@"%i", [event eventId]] forKey:@"ID"];
    localNotif.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

+ (void)cancelNotificationByEventId: (NSNumber*) eventId
{
    UILocalNotification *notificationToCancel = [TIHNotificationManager findNotificationByEventId:eventId];
    if(notificationToCancel != nil)
        [[UIApplication sharedApplication] cancelLocalNotification:notificationToCancel];
}

+(BOOL)isEventReminderSet: (NSNumber*) eventId
{
    return [self findNotificationByEventId:eventId] != nil;
}

+(UILocalNotification*)findNotificationByEventId: (NSNumber*)eventId
{
    NSString *eventIdStr = [NSString stringWithFormat:@"%i", eventId];
    UILocalNotification *notifcation=nil;
    for(UILocalNotification *aNotif in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        if([[aNotif.userInfo objectForKey:@"ID"] isEqualToString:eventIdStr]) {
            notifcation = aNotif;
            break;
        }
    }
    return notifcation;
}
@end