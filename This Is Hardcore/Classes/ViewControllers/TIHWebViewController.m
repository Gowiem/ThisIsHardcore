//
//  TIHWebViewController.m
//  This Is Hardcore
//
//  Created by Odin on 6/5/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHWebViewController.h"
#import "UIViewController+MBProgressHUD.h"
#import "UIColor+HexString.h"
#import "GoogleAnalytics.h"

@interface TIHWebViewController ()

@end

@implementation TIHWebViewController

@synthesize urlAddress;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showHUDWithMessage:@"Loading..."];
    NSLog(@"Loading URL: %@", self.urlAddress);
    NSURL *url = [NSURL URLWithString:self.urlAddress]; 
    [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Loaded: %@",self.urlAddress]];
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
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    [self hideHUD];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error loading webview : %@", error);
    [self hideHUD];
}

- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // Determine if we want the system to handle it.
    NSURL *url = request.URL;
    NSLog(@"url : %@", [url absoluteString]);
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
            return NO;
        }
    }
    return YES;
}
@end