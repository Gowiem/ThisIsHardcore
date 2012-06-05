//
//  TIHWebViewController.m
//  This Is Hardcore
//
//  Created by Odin on 6/5/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHWebViewController.h"

@interface TIHWebViewController ()

@end

@implementation TIHWebViewController

@synthesize backButton, forwardButton, stopSlashRefreshButton, webView, urlAddress;

//TODO Find out why this is never called
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"TIHUIWebViewController Init");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"Loading URL: %@", self.urlAddress);
        NSURL *url = [NSURL URLWithString:self.urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        
        //Load the request in the UIWebView.
        [self.webView loadRequest:requestObj];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) doBackButtonAction:(id)sender
{
    NSLog(@"Back button Action");
}
- (IBAction) doForwardButtonAction:(id)sender
{
    NSLog(@"Forward button Action");
}

//TODO change this functionality from loading the url to performing/stop slash refresh
- (IBAction) doStopSlashRefreshButtonAction:(id)sender
{
    NSLog(@"Stop Slash Refresh button Action");
    NSLog(@"Loading URL: %@", self.urlAddress);
    NSURL *url = [NSURL URLWithString:self.urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
}


@end
