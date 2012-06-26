//
//  TIHNewsTableViewController.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHTabBarTableViewController.h"
#import "SSPullToRefresh.h"

@interface TIHNewsTableViewController : TIHTabBarTableViewController {
    NSMutableArray *_newsItems;
    NSString *tag;
}

@property (strong, nonatomic) SSPullToRefreshView *pullToRefreshView;

@end
