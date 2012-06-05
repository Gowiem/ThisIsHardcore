//
//  TIHNewsTableViewViewController.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "BaseTableViewController.h"

@interface TIHNewsTableViewViewController : BaseTableViewController {
    NSMutableArray *_newsItems;
    UITableView *_myTable;
}
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@property (strong, nonatomic) IBOutlet UIButton *officialButton;
@property (strong, nonatomic) IBOutlet UIButton *fanFeedButton;

- (IBAction) doOfficialButtonAction:(id)sender;
- (IBAction) doFanFeedButtonAction:(id)sender;
@end
