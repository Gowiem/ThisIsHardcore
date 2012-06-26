//
//  TIHNotificationManager.m
//  This Is Hardcore
//
//  Created by Odin on 6/18/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHNotificationManager.h"

@implementation TIHNotificationManager

- (void)scheduleNotificationWithEvent:(TIHEventDataModel *)event {
    NSDate *itemDate = [event startTime];
    NSString *message = [event artistName];
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;

    localNotif.fireDate = [itemDate dateByAddingTimeInterval:-(300)];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ in %i minutes.", nil),
                            message, 5];
    localNotif.alertAction = NSLocalizedString(@"View Event", nil);
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:message forKey:
                                [event eventId]];
    localNotif.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

@end
