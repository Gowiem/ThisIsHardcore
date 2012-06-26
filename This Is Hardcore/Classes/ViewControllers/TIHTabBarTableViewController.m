//
//  TIHTabBarTableViewController.m
//  This Is Hardcore
//
//  Created by Odin on 6/13/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHTabBarTableViewController.h"

@implementation TIHTabBarTableViewController

@synthesize myTable = _myTable, fanFeedButton, officialButton, pullToRefreshView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.myTable delegate:self];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.pullToRefreshView = nil;
}

- (IBAction) doOfficialButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setBackgroundImage: [UIImage imageNamed:@"TIHCofficialBluetab.png"] forState:UIControlStateNormal];
    
    [self.fanFeedButton setBackgroundImage:[UIImage imageNamed:@"FanFeedG1tab.png"] forState:UIControlStateNormal];
}
- (IBAction) doFanFeedButtonAction: (id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setBackgroundImage: [UIImage imageNamed:@"FanFeedBluetab.png"] forState:UIControlStateNormal];
    [self.officialButton setBackgroundImage:[UIImage imageNamed:@"TIHCofficialG1tab.png"] forState:UIControlStateNormal];
}

@end
