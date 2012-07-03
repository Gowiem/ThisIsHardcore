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
    NSMutableDictionary *_newsDictionary;
    NSMutableDictionary *_newsTotalCountDictionary;
//    NSMutableArray *_newsItems;
    NSString *tag;
    NSInteger _page;
    NSInteger _count;
}

@property (strong, nonatomic) SSPullToRefreshView *pullToRefreshView;

@end
