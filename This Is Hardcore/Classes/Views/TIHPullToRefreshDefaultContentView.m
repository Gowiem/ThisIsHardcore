//
//  TIHPullToRefreshDefaultContentView.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 7/19/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHPullToRefreshDefaultContentView.h"

@implementation TIHPullToRefreshDefaultContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setLastUpdatedAt:(NSDate *)date
   withPullToRefreshView:(SSPullToRefreshView *)view {
    NSLog(@"Set last updated at : %@", date);
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        dateFormatter.dateFormat =  @"MM/dd/yyyy HH:mm a";
        
    });
    self.lastUpdatedAtLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:date]];
}

@end
