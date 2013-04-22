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
}

- (void)addEventToCalendarForArtisanEvent:(TIHEventDataModel *)artistEvent;

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
        calendar = [self.eventStore defaultCalendarForNewEvents];
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZ"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        deniedAccessAlert = [[UIAlertView alloc]
                             initWithTitle:@"Denied Access"
                             message:@"You denied access to add a reminder earlier. If you would like to change this you can do so by adding calendar access permission for the This is Hardcore app via Privacy in your Settings."
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

- (void)requestAccessForCalendarAndAddEvent:(TIHEventDataModel *)artistEvent
{
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        LOG_BOOL(@"requestAccessToCalendar: ", granted);
        if (granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addEventToCalendarForArtisanEvent:artistEvent];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [deniedAccessAlert show];
            });
        }
    }];
}

- (void)removeEventFromCalendarForEvent:(TIHEventDataModel *)event
{
    EKEvent *eventToRemove = [self findEvent:event];
    NSError *error = nil;
    [self.eventStore removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
    if(error == nil) {
        NSLog(@"Removed event");
    } else {
        NSLog(@"Error with removing event: %@", error);
    }
}

- (void)addEventToCalendarForArtisanEvent:(TIHEventDataModel *)artistEvent
{
    NSLog(@"----------------- addEventToCalendarForArtisanEvent");
    
    // Grab the info for the event we are adding
    // Note explicitly adding the offset time interval, because no matter how many things I tried
    // adding the date was always changed to be 4 hours behind.
    NSDate *startDate = [[NSDate alloc] initWithTimeInterval:14400 sinceDate:[artistEvent startTime]];
    NSDate *endDate   = [[NSDate alloc] initWithTimeInterval:14400 sinceDate:[artistEvent endTime]];
    NSString *message = [artistEvent artistName];
    
    // Create the event
    EKEvent *newEvent = [EKEvent eventWithEventStore:self.eventStore];
    newEvent.title = message;
    newEvent.startDate = startDate;
    newEvent.endDate =  endDate;
    newEvent.allDay = NO;
    newEvent.calendar = calendar;

    NSLog(@"event startDate: %@", newEvent.startDate);
    NSLog(@"event endDate  : %@", newEvent.endDate);
    NSLog(@"event timeZone : %@", newEvent.timeZone);
    
    // Add the alarm
    EKAlarm *eventAlarm = [EKAlarm alarmWithRelativeOffset:-900];
    [newEvent addAlarm:eventAlarm];
    
    // Add the event/alarm to the users calendar
    NSError *error = nil;
    [self.eventStore saveEvent:newEvent span:EKSpanThisEvent commit:YES error:&error];
    
    if (error == nil) {
        [addedEvent show];
    } else {
        NSLog(@"there was an error saving and committing the event");
    }

}

- (BOOL)isEventReminderSet:(TIHEventDataModel *)event
{
    return ([self findEvent:event] != nil);
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
