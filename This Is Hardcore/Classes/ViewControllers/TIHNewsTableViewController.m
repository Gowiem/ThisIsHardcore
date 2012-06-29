//
//  TIHNewsTableViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHApplicationConfiguration.h"
#import "TIHNewsTableViewController.h"
#import "AFJSONRequestOperation.h"
#import "TIHNewsDataModel.h"
#import "TIHNewsCell.h"
#import "TIHWebViewController.h"
#import "UIViewController+MBProgressHUD.h"

@interface TIHNewsTableViewController ()
@end

@implementation TIHNewsTableViewController

@synthesize pullToRefreshView;

- (void)viewDidLoad
{
    _newsItems = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    tag = @"official";
    [self loadData];
}

-(void)loadData
{
    [self showHUDWithMessage:@"Loading"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/news_feed/%@.json?auth_token=unifeed-debug", UNIFEED_API_URL, tag]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"Requesting url : %@", url);
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for( id row in [JSON valueForKey:@"rows"]){
            [_newsItems addObject: [[TIHNewsDataModel alloc] initWithProperties:row]];
        }
        [[super myTable] reloadData];
        [self hideHUD];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Fail!");
        [self hideHUD];
    }];
    
    [operation start];
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    [self.pullToRefreshView startLoading];
    [self loadData];
    [self.pullToRefreshView finishLoading];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_newsItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"NewsCell";
    
    TIHNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TIHNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell configureWithObject:[_newsItems objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
}

- (IBAction) doOfficialButtonAction:(id)sender
{
    [super doOfficialButtonAction:sender];
    tag = @"official";
    [self loadData];
}
- (IBAction) doFanFeedButtonAction: (id)sender
{
    [super doFanFeedButtonAction:sender];
    tag = @"fanfeed";
    [self loadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TIHWebViewController* wvc = (TIHWebViewController*)segue.destinationViewController;
    TIHNewsCell* cell = (TIHNewsCell*)sender;
    wvc.urlAddress = [cell newsUrl];
}

@end