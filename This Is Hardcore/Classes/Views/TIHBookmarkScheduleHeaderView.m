//
//  TIHBookmarkScheduleHeaderView.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/26/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHBookmarkScheduleHeaderView.h"

@implementation TIHBookmarkScheduleHeaderView

@synthesize sectionLabel;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.sectionLabel.text = title;
    }
    return self;
}

@end
