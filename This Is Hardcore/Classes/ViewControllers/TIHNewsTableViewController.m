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
#import "TIHNewsDataModel.h"
#import "NSString+AppRenaissance.h"
#import "SDURLCache.h"

@interface TIHNewsTableViewController ()
@end

@implementation TIHNewsTableViewController

@synthesize pullToRefreshView;

- (void)viewDidLoad
{
    NSArray *arrays = [[NSArray alloc] initWithObjects:[[NSArray alloc] init], [[NSArray alloc] init], nil];
    NSArray *keys = [[NSArray alloc] initWithObjects:@"official", @"fanfeed", nil];
    _newsDictionary = [[NSMutableDictionary alloc] initWithObjects:arrays forKeys:keys];
    _newsTotalCountDictionary = [[NSMutableDictionary alloc] init];
    [super viewDidLoad];
    tag = @"official";
    [self loadData];
}

-(void)loadData
{
    [self loadDataMore:NO];
}
-(void)loadDataMore:(BOOL)more;
{
    [self showHUDWithMessage:@"Loading"];
    NSMutableArray *newsItems = [[NSMutableArray alloc] initWithArray:[_newsDictionary objectForKey:tag]];
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    if(more)
    {
        _page++;
//        TIHNewsDataModel *m = [newsItems objectAtIndex:NUM_OF_ITEMS_PER_API_REQUEST - 1];
//        [requestParams setObject:[NSString stringWithFormat:@"%i", [m newsId]] forKey:@"since"];
//        NSLog(@"Last Id : %i", [[m newsId] intValue]);
    }
    else
    {
        _page = 1;        
        newsItems = [[NSMutableArray alloc] init];
    }


    [requestParams setObject:@"unifeed-debug" forKey:@"auth-token"];
    [requestParams setObject:[NSString stringWithFormat:@"%d", NUM_OF_ITEMS_PER_API_REQUEST] forKey:@"size"];
    [requestParams setObject:[NSString stringWithFormat:@"%d", _page] forKey:@"page"];
    NSString *urlQuery = [NSString queryStringWithBase:nil parameters:requestParams prefixed:YES];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/news_feed/%@.json%@", UNIFEED_API_URL, tag, urlQuery]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"Requesting url : %@", url);
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for( id row in [JSON valueForKey:@"rows"]){
            [newsItems addObject: [[TIHNewsDataModel alloc] initWithProperties:row]];
        }
        [_newsDictionary setValue:[[NSArray alloc] initWithArray:newsItems] forKey:tag];
        [[super myTable] reloadData];
        [self hideHUD];
        NSNumber *itemCount = [JSON objectForKey:@"total_rows"];
        [_newsTotalCountDictionary setValue:itemCount forKey:tag];
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
    NSArray *newsItems = [_newsDictionary objectForKey:tag];
    return  [newsItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"NewsCell";
    
    TIHNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TIHNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *newsItems = [_newsDictionary objectForKey:tag];
    [cell configureWithObject:[newsItems objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *newsItems = [_newsDictionary objectForKey:tag];
    if(indexPath.row == [newsItems count] - 1) //items is your data source
    {
        int totalCount = [[_newsTotalCountDictionary valueForKey:tag] intValue];
        if(totalCount > _page * NUM_OF_ITEMS_PER_API_REQUEST)
            [self loadDataMore:YES];
    }
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