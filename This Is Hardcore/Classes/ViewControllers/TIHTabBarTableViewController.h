//
//  TIHTabBarTableViewController.h
//  This Is Hardcore
//
//  Created by Odin on 6/13/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SSPullToRefresh.h"

@interface TIHTabBarTableViewController : BaseViewController<SSPullToRefreshViewDelegate> {
    UITableView *_myTable;
}

@property (strong, nonatomic) IBOutlet UITableView *myTable;

@property (strong, nonatomic) IBOutlet UIButton *officialButton;
@property (strong, nonatomic) IBOutlet UIButton *fanFeedButton;

@property (strong, nonatomic) SSPullToRefreshView *pullToRefreshView;

- (IBAction) doOfficialButtonAction:(id)sender;
- (IBAction) doFanFeedButtonAction:(id)sender;
@end
