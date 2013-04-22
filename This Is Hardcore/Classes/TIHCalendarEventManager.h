//
//  TIHCalendarEventManager.h
//  This Is Hardcore
//
//  Created by Matt Gowie on 4/2/13.
//  Copyright (c) 2013 appRenaissance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "TIHEventDataModel.h"

@interface TIHCalendarEventManager : NSObject

@property (strong, nonatomic) EKEventStore *eventStore;

+ (id)instance;

- (void)requestAccessOnInit;

- (BOOL)isEventReminderSet:(TIHEventDataModel *)event;

- (BOOL)addEventToCalendarForEvent:(TIHEventDataModel *)event;
- (BOOL)removeEventFromCalendarForEvent:(TIHEventDataModel *)event;

- (EKEvent*)findEvent:(TIHEventDataModel*)event;

@end
