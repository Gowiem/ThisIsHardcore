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

- (BOOL)isEventReminderSet:(TIHEventDataModel *)event;

- (void)requestAccessForCalendarAndAddEvent:(TIHEventDataModel *)event;
- (void)removeEventFromCalendarForEvent:(TIHEventDataModel *)event;

- (EKEvent*)findEvent:(TIHEventDataModel*)event;

@end
