//
//  TIHScheduleViewController.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/14/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "BaseTableViewController.h"

@interface TIHScheduleViewController : BaseTableViewController{
    UITableView *_myTable;
    NSMutableArray *_scheduleItems;
    int _selectedDay;
}


@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) IBOutlet UILabel *dayDateLabel;

@property (strong, nonatomic) IBOutlet UIButton *thursButton;
@property (strong, nonatomic) IBOutlet UIButton *friButton;
@property (strong, nonatomic) IBOutlet UIButton *satButton;
@property (strong, nonatomic) IBOutlet UIButton *sunButton;
@property (strong, nonatomic) IBOutlet UIButton *afterButton;

- (IBAction) doThursButtonAction:(id)sender;
- (IBAction) doFriButtonAction:(id)sender;
- (IBAction) doSatButtonAction:(id)sender;
- (IBAction) doSunButtonAction:(id)sender;
- (IBAction) doAfterButtonAction:(id)sender;

@end
