//
//  TIHCalendarEventManager.m
//  This Is Hardcore
//
//  Created by Matt Gowie on 4/2/13.
//  Copyright (c) 2013 appRenaissance. All rights reserved.
//

#import "TIHCalendarEventManager.h"

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
    }
    return self;
}

- (void)requestAccessForCalendar
{
    if (IS_IOS6_AND_UP) {
        [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Authenticated!");
                });
            }
        }];
    } else {
        NSLog(@"Tried to request access to calendar, but is iOS version is below iOS6");
    }
}


@end
