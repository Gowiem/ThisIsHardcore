//
//  TIHWebViewController.m
//  This Is Hardcore
//
//  Created by Odin on 6/5/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHWebViewController.h"
#import "UIColor+HexString.h"

@interface TIHWebViewController ()

@end

@implementation TIHWebViewController

@synthesize urlAddress;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Loading URL: %@", self.urlAddress);
    NSURL *url = [NSURL URLWithString:self.urlAddress];  
    [super openURL:url];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setToolbarTintColor:[UIColor colorWithHexString: @"0a74b5"]];
    [self updateNavBarDisplay];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Tickets" style:UIBarButtonItemStylePlain target:self action:@selector(handleTicket:)];          
    self.navigationItem.rightBarButtonItem = anotherButton;    
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

- (void)handleTicket:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.ticketmaster.com/ticket/search.do?articles=tmus&query=this+is+hardcore&submit=SEARCH"]];
}
@end