//
//  TIHCalendarEventManager.h
//  This Is Hardcore
//
//  Created by Matt Gowie on 4/2/13.
//  Copyright (c) 2013 appRenaissance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface TIHCalendarEventManager : NSObject

@property (strong, nonatomic) EKEventStore *eventStore;

+ (id)instance;
- (void)requestAccessForCalendar;

@end
