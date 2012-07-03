//
//  TIHNotificationManager.h
//  This Is Hardcore
//
//  Created by Odin on 6/18/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIHEventDataModel.h"

@interface TIHNotificationManager : NSObject

- (void)scheduleNotificationWithEvent:(TIHEventDataModel *)event;
- (void)cancelScheduledNotificationWithEventId:(NSNumber *)eventId;

@end
