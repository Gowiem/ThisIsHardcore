//
//  TIHCalendarEventManager.m
//  This Is Hardcore
//
//  Created by Matt Gowie on 4/2/13.
//  Copyright (c) 2013 appRenaissance. All rights reserved.
//

#import "TIHCalendarEventManager.h"

@interface TIHCalendarEventManager () {
    UIAlertView *addedEvent;
    UIAlertView *deniedAccessAlert;
    EKCalendar *calendar;
    NSDateFormatter *dateFormatter;
    BOOL grantedAccess;
}

@end

@implementation TIHCalendarEventManager

+ (id)instance
{
    static dispatch_once_t once;
    static TIHCalendarEventManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        self.eventStore = [[EKEventStore alloc] init];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZ"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        deniedAccessAlert = [[UIAlertView alloc]
                             initWithTitle:@"Denied Access"
                             message:@"You denied access to use the calendar so you won't be able to set reminders for bands. If you would like to change this you can do so by adding calendar access permission for the This is Hardcore app via Privacy in your Settings."
                             delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
        addedEvent = [[UIAlertView alloc]
                      initWithTitle:@"Event Added"
                      message:@"Event was successfully added to calendar"
                      delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil];
    }
    return self;
}

- (void)requestAccessWithCompletionBlock:(void (^) ())completionBlock
{
    // Handle iOS 6 permissions requesting
    if([self.eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Access was granted");
                    grantedAccess = YES;
                    calendar = [self.eventStore defaultCalendarForNewEvents];
                    completionBlock();
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Access was denied");
                    grantedAccess = NO;
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    BOOL hasViewedInitDeniedAccessAlert = [defaults boolForKey:@"hasViewedDeniedAccess"];
                    if(!hasViewedInitDeniedAccessAlert) {
                        [deniedAccessAlert show];
                        [defaults setBool:YES forKey:@"hasViewedDeniedAccess"];
                        [defaults synchronize];
                    }
                });
            }
        }];
    } else {
        // User is on iOS 5; Aint no stinking permissions
        grantedAccess = YES;
        calendar = [self.eventStore defaultCalendarForNewEvents];
        completionBlock();
    }
}

- (void)removeEventFromCalendarForEvent:(TIHEventDataModel *)event withController:(TIHEventDetailViewController *)controller
{
    [self requestAccessWithCompletionBlock: ^void () {
        NSLog(@"Removing event");
        
        EKEvent *eventToRemove = [self findEvent:event];
        NSError *error = nil;
        [self.eventStore removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
        if(error == nil) {
            NSLog(@"Removed event");
            [controller updateReminderDisplayToSet];
        } else {
            NSLog(@"Error with removing event: %@", error);
        }
    }];
}

- (void)addEventToCalendarForEvent:(TIHEventDataModel *)event withController:(TIHEventDetailViewController *)controller
{
    [self requestAccessWithCompletionBlock: ^void () {
        NSLog(@"Adding event");
        
        // Grab the info for the event we are adding
        // Note explicitly adding the offset time interval, because no matter how many ways I tried
        // adding the date, it was always changed to be 4 hours behind.
        NSDate *startDate = [[NSDate alloc] initWithTimeInterval:4*60*60 sinceDate:[event startTime]];
        NSDate *endDate   = [[NSDate alloc] initWithTimeInterval:4*60*60 sinceDate:[event endTime]];
        NSString *message = [event artistName];
        
        // Create the event
        EKEvent *newEvent = [EKEvent eventWithEventStore:self.eventStore];
        newEvent.title = message;
        newEvent.startDate = startDate;
        newEvent.endDate =  endDate;
        newEvent.allDay = NO;
        newEvent.calendar = calendar;
        
        // Add the alarm
        EKAlarm *eventAlarm = [EKAlarm alarmWithRelativeOffset:-900];
        [newEvent addAlarm:eventAlarm];
        
        // Add the event/alarm to the users calendar
        NSError *error = nil;
        [self.eventStore saveEvent:newEvent span:EKSpanThisEvent commit:YES error:&error];
        
        if (error == nil) {
            NSLog(@"Added event to calendar with Alarm");
            [controller updateReminderDisplayToUnset];
        } else {
            NSLog(@"there was an error saving and committing the event");
        }
    }];
}

- (BOOL)isEventReminderSet:(TIHEventDataModel *)event
{
    if(!grantedAccess) {        
        return NO;
    } else {
        return ([self findEvent:event] != nil);
    }
}

- (EKEvent*)findEvent:(TIHEventDataModel*)event
{
    NSDate *startDate = [[NSDate alloc] initWithTimeInterval:14400 sinceDate:[event startTime]];
    NSDate *endDate   = [[NSDate alloc] initWithTimeInterval:14400 sinceDate:[event endTime]];
    
    NSPredicate *predicateForEvents = [self.eventStore
                                       predicateForEventsWithStartDate:startDate
                                       endDate:endDate
                                       calendars:[NSArray arrayWithObject:calendar]];
    
    NSArray *matchingEvents = [self.eventStore eventsMatchingPredicate:predicateForEvents];
    NSLog(@"matchingEvents: %@", matchingEvents);
    
    for (EKEvent *eventToCheck in matchingEvents) {
        if ([eventToCheck.title isEqualToString:[event artistName]]) {
            return eventToCheck;
        }
    }
    return nil;
}

@end
