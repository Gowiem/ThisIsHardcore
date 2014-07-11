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
#import "TIHEventDetailViewController.h"

@interface TIHCalendarEventManager : NSObject

@property (strong, nonatomic) EKEventStore *eventStore;

+ (id)instance;

- (void)requestAccessWithCompletionBlock:(void (^) ())completionBlock;

- (BOOL)isEventReminderSet:(TIHEventDataModel *)event;

- (void)addEventToCalendarForEvent:(TIHEventDataModel *)event withController:(TIHEventDetailViewController *)controller;
- (void)removeEventFromCalendarForEvent:(TIHEventDataModel *)event withController:(TIHEventDetailViewController *)controller;

- (EKEvent*)findEvent:(TIHEventDataModel*)event;

@end
