//
//  BaseTableViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "BaseTableViewController.h"
#import "TIHAppDelegate.h"

@implementation BaseTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 2 )];
    //bar.backgroundColor = TTSTYLEVAR(drinksSectionHeaderFontColor);
    [self.view addSubview:bar];
    
    //self.tableView.backgroundColor = TTSTYLEVAR(absoluteBlack);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self updateNavBarDisplay];
}

-(void) updateNavBarDisplay {
    NSString *backgroundImageName = @"";
    if([[[self navigationController] viewControllers] count] == 1) {
        backgroundImageName = @"titleBar.png";
    }
    else {
        backgroundImageName = @"";
    }
    
    UIImage *image = [UIImage imageNamed:backgroundImageName];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    UILabel *label = [[UILabel alloc] init];
    self.navigationItem.titleView = label;
    label.text = @"";
}

@end
