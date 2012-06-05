//
//  TIHWebViewController.h
//  This Is Hardcore
//
//  Created by Odin on 6/5/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface TIHWebViewController : BaseTableViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;
@property (strong, nonatomic) IBOutlet UIButton *stopSlashRefreshButton;

- (IBAction) doBackButtonAction:(id)sender;
- (IBAction) doForwardButtonAction:(id)sender;
- (IBAction) doStopSlashRefreshButtonAction:(id)sender;

@property (strong, nonatomic) NSString *urlAddress;

@end
