//
//  TIHTabBarTableViewController.m
//  This Is Hardcore
//
//  Created by Odin on 6/13/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHTabBarTableViewController.h"
#import "TIHApplicationConfiguration.h"
#import "TIHBaseDataModel.h"
#import "NSString+AppRenaissance.h"
#import "UIViewController+MBProgressHUD.h"

@implementation TIHTabBarTableViewController

@synthesize myTable = _myTable, fanFeedButton, officialButton, pullToRefreshView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.myTable delegate:self];
    _itemDictionary = [[NSMutableDictionary alloc] init];
    _itemTotalCountDictionary = [[NSMutableDictionary alloc] init];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.pullToRefreshView = nil;
}

- (IBAction) doOfficialButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setBackgroundImage: [UIImage imageNamed:@"TIHCofficialBluetab.png"] forState:UIControlStateNormal];
    
    [self.fanFeedButton setBackgroundImage:[UIImage imageNamed:@"FanFeedG1tab.png"] forState:UIControlStateNormal];
}
- (IBAction) doFanFeedButtonAction: (id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setBackgroundImage: [UIImage imageNamed:@"FanFeedBluetab.png"] forState:UIControlStateNormal];
    [self.officialButton setBackgroundImage:[UIImage imageNamed:@"TIHCofficialG1tab.png"] forState:UIControlStateNormal];
}

-(void)loadData
{
    [self loadDataMore:NO];
}
-(void)loadDataMore:(BOOL)more;
{
    [self showHUDWithMessage:@"Loading"];
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[_itemDictionary objectForKey:tag]];
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    if(more)
    {
        _page++;

    }
    else
    {
        _page = 1;        
        items = [[NSMutableArray alloc] init];
    }
    
    [requestParams setObject:@"unifeed-debug" forKey:@"auth-token"];
    [requestParams setObject:[NSString stringWithFormat:@"%d", NUM_OF_ITEMS_PER_API_REQUEST] forKey:@"size"];
    [requestParams setObject:[NSString stringWithFormat:@"%d", _page] forKey:@"page"];
    NSString *urlQuery = [NSString queryStringWithBase:nil parameters:requestParams prefixed:YES];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@.json%@", UNIFEED_API_URL, unifeedEntity, tag, urlQuery]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"Requesting url : %@", url);
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for( id row in [JSON valueForKey:@"rows"]){
            [items addObject: [[TIHBaseDataModel alloc] initWithProperties:row]];
        }
        [_itemDictionary setValue:[[NSArray alloc] initWithArray:items] forKey:tag];
        [_myTable reloadData];
        [self hideHUD];
        NSNumber *itemCount = [JSON objectForKey:@"total_rows"];
        [_itemTotalCountDictionary setValue:itemCount forKey:tag];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Fail!");
        [self hideHUD];
    }];
    
    [operation start];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *items = [_itemDictionary objectForKey:tag];
    return  [items count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *newsItems = [_itemDictionary objectForKey:tag];
    if(indexPath.row == [newsItems count] - 1) //items is your data source
    {
        int totalCount = [[_itemTotalCountDictionary valueForKey:tag] intValue];
        if(totalCount > _page * NUM_OF_ITEMS_PER_API_REQUEST)
            [self loadDataMore:YES];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    [self.pullToRefreshView startLoading];
    [self loadData];
    [self.pullToRefreshView finishLoading];
}

@end
