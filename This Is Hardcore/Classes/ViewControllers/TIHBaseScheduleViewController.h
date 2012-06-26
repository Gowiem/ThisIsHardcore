//
//  TIHBaseScheduleViewController.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/26/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "BaseTableViewController.h"

@interface TIHBaseScheduleViewController : BaseTableViewController 

@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) NSMutableArray *scheduleItems;
@property (strong, nonatomic) NSMutableArray *bookmarkedScheduleItems;

-(void) loadData;

@end
