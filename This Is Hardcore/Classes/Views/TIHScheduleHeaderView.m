//
//  TIHScheduleHeaderView.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 7/18/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHScheduleHeaderView.h"

@implementation TIHScheduleHeaderView

@synthesize venueLabel;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.venueLabel.text = title;
    }
    return self;
}

@end
