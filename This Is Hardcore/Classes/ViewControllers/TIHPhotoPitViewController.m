//
//  TIHPhotoPitViewControllerViewController.m
//  This Is Hardcore
//
//  Created by Odin on 6/13/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "AFJSONRequestOperation.h"
#import "TIHApplicationConfiguration.h"
#import "TIHPhotoPitViewController.h"
#import "TIHPhotoPitCell.h"
#import "UIViewController+MBProgressHUD.h"

@interface TIHPhotoPitViewController ()

@end

@implementation TIHPhotoPitViewController

- (void)viewDidLoad
{
    _photoPitItems = [[NSMutableArray alloc] init];
    tag = @"official";
    
    [super viewDidLoad];    
    [self loadData];
}

- (void)loadData
{
    [self showHUDWithMessage:@"Loading"];
    NSString *endPointUrl = [NSString stringWithFormat:@"%@/instagram/%@.json?auth_token=unifeed-debug", UNIFEED_API_URL, tag];
    NSURL *url = [NSURL URLWithString:endPointUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"Requesting url : %@", url);
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *
          request, NSHTTPURLResponse *response, id JSON) {
        [_photoPitItems removeAllObjects];
        for( id row in [JSON valueForKey:@"rows"]){
            [_photoPitItems addObject: [[TIHPhotoPitDataModel alloc] initWithProperties:row]];
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
    return  [_photoPitItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PhotoPitCell";
    
    TIHPhotoPitCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TIHPhotoPitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell clearSubViews];
    [cell configureWithObject:[_photoPitItems objectAtIndex:indexPath.row]];
    
    return cell;
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

- (IBAction) doOfficialButtonAction:(id)sender
{
    [super doOfficialButtonAction:sender];
    tag = @"official";
    [self loadData];
}
- (IBAction) doFanFeedButtonAction: (id)sender
{
    [super doFanFeedButtonAction:sender];
    tag = @"tagged";
    [self loadData];
}

@end
