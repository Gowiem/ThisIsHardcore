//
//  TIHNotificationManager.m
//  This Is Hardcore
//
//  Created by Odin on 6/18/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHNotificationManager.h"
#import "TIHCalendarEventManager.h"

// This class was used prior to version 1.4
// It is no longer used now that we the app is using the EventKit Reminder API.

@implementation TIHNotificationManager

#pragma mark - Base Methods

+ (void)scheduleNotificationWithEvent:(TIHEventDataModel *)event {
    if (IS_IOS6_AND_UP) {
        //[[TIHCalendarEventManager instance] requestAccessForCalendarAndAddEvent:event];
    } else {
        [self scheduleiOS5NotificationWithEvent:event];
    }
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

#pragma mark - iOS 5 Methods

+ (void)scheduleiOS5NotificationWithEvent:(TIHEventDataModel *)event {
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

@end