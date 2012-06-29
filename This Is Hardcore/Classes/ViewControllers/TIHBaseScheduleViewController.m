//
//  TIHBaseScheduleViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/26/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHBaseScheduleViewController.h"
#import "TIHApplicationConfiguration.h"
#import "TIHEventDataModel.h"
#import "TIHEventDetailViewController.h"
#import "AFJSONRequestOperation.h"
#import "UIViewController+MBProgressHUD.h"

@interface TIHBaseScheduleViewController ()

@end

@implementation TIHBaseScheduleViewController

@synthesize myTable, scheduleItems, bookmarkedScheduleItems, pullToRefreshView;

-(void) loadData
{
    [super viewDidLoad];
    [self showHUDWithMessage:@"Loading"];
	// Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/events.json?auth_token=unifeed-debug", UNIFEED_API_URL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"Requesting url : %@", url);
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        scheduleItems = [[NSMutableArray alloc] init];
        for( id row in JSON){
            [scheduleItems addObject: [[TIHEventDataModel alloc] initWithProperties:row]];
        }
        
        bookmarkedScheduleItems = [[NSMutableArray alloc] init];
        
        NSArray *soretedScheduledItems = [scheduleItems sortedArrayUsingSelector:@selector(compare:)];
        
        for(TIHEventDataModel *m in soretedScheduledItems) {
            if([m isEventBookmarked]) {
                [bookmarkedScheduleItems addObject:m];
            }
        }
        [myTable reloadData];
        [self hideHUD];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Fail!");
        [self hideHUD];
    }];
    
    [operation start];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.myTable delegate:self];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.pullToRefreshView = nil;
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    [self.pullToRefreshView startLoading];
    [self loadData];
    [self.pullToRefreshView finishLoading];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)model {
    if ([segue.identifier isEqualToString:@"segueToEventDetail"])
    {
        id edvc = segue.destinationViewController;
        [edvc setDataModel:model];
    }
}

@end
