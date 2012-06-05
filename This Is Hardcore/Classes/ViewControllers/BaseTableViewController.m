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
    
    [self updateNavBarDisplay];
}

-(void) updateNavBarDisplay {
    NSString *backgroundImageName = @"";
    if([[[self navigationController] viewControllers] count] == 1) {
        backgroundImageName = @"TIHC_Header.png";
    }
    else {
        backgroundImageName = @"TIHC_HeaderCenter.png";
    }
    
    UIImage *image = [UIImage imageNamed:backgroundImageName];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    UILabel *label = [[UILabel alloc] init];
    self.navigationItem.titleView = label;
    label.text = @"";
}

@end
