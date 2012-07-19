//
//  TIHBaseScheduleViewController.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/26/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "BaseViewController.h"
#import "SSPullToRefresh.h"

@interface TIHBaseScheduleViewController : BaseViewController <SSPullToRefreshViewDelegate>
{
    BOOL _firstDataLoad;
}
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) NSMutableArray *scheduleItems;
@property (strong, nonatomic) NSMutableArray *bookmarkedScheduleItems;

@property (strong, nonatomic) SSPullToRefreshView *pullToRefreshView;

-(void) loadData;


@end
