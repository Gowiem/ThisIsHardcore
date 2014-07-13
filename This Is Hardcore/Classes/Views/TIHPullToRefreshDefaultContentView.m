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
        UIImage *pullImageSolid = [UIImage imageNamed:@"HCBellSolid.png"];
        _pullImageViewSolid = [[UIImageView alloc] initWithImage:pullImageSolid];
        _pullImageViewSolid.frame = CGRectMake(20.0f, 20.0f, 29.0f, 30.0f);
        [self addSubview:_pullImageViewSolid];
        
        UIImage *pullImageCracked = [UIImage imageNamed:@"HCBell.png"];
        _pullImageViewCracked = [[UIImageView alloc] initWithImage:pullImageCracked];
        _pullImageViewCracked.frame = CGRectMake(_pullImageViewSolid.frame.origin.x, _pullImageViewSolid.frame.origin.y, _pullImageViewSolid.frame.size.width, _pullImageViewSolid.frame.size.height);
        [self addSubview:_pullImageViewCracked];
    }
    return self;
}

- (void)setLastUpdatedAt:(NSDate *)date
   withPullToRefreshView:(SSPullToRefreshView *)view {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        dateFormatter.dateFormat =  @"MM/dd/yyyy hh:mm a";
        
    });
    self.lastUpdatedAtLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:date]];
}


- (void)setState:(SSPullToRefreshViewState)state withPullToRefreshView:(SSPullToRefreshView *)view {	
	switch (state) {
		case SSPullToRefreshViewStateReady: {
			self.statusLabel.text = @"Release to refresh...";
			[self.activityIndicatorView stopAnimating];
            _pullImageViewCracked.hidden = NO;
            _pullImageViewSolid.hidden = YES;
			break;
		}
			
		case SSPullToRefreshViewStateNormal: {
			self.statusLabel.text = @"Pull down to refresh...";
			[self.activityIndicatorView stopAnimating];
            _pullImageViewCracked.hidden = YES;
            _pullImageViewSolid.hidden = NO;
			break;
		}
            
		case SSPullToRefreshViewStateLoading:
		case SSPullToRefreshViewStateClosing: {
			self.statusLabel.text = @"Loading...";
			[self.activityIndicatorView startAnimating];
            _pullImageViewCracked.hidden = YES;
            _pullImageViewSolid.hidden = YES;			
            break;
		}
	}
}


@end
