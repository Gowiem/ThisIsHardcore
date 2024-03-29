//
//  BaseViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "BaseViewController.h"
#import "TIHAppDelegate.h"

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self updateNavBarDisplay];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Tickets" style:UIBarButtonItemStylePlain target:self action:@selector(handleTicket:)];       
//    anotherButton.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

//-(void) updateNavBarDisplay {
////    NSString *backgroundImageName = @"";
////    if([[[self navigationController] viewControllers] count] == 1) {
////        backgroundImageName = @"TIHC_Header.png";
////    }
////    else {
////        backgroundImageName = @"TIHC_HeaderCenter.png";
////    }
////    
////    UIImage *image = [UIImage imageNamed:backgroundImageName];
////    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"TIHC";
//    self.navigationItem.titleView = label;
//}

- (void)handleTicket:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.ticketmaster.com/ticket/search.do?articles=tmus&query=this+is+hardcore&submit=SEARCH"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
