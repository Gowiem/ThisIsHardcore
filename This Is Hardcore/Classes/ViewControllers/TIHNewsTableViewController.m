//
//  TIHNewsTableViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//


#import "TIHNewsTableViewController.h"
#import "TIHNewsCell.h"
#import "TIHWebViewController.h"
#import "GoogleAnalytics.h"

@interface TIHNewsTableViewController ()
@end

@implementation TIHNewsTableViewController

@synthesize pullToRefreshView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    tag = @"official";
    unifeedEntity = @"news_feed";
    [self loadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [GoogleAnalytics trackPageView:@"News"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *newsItems = [_itemDictionary objectForKey:tag];
    static NSString *CellIdentifier = @"NewsCell";
    static NSString *MoreCellIdentifier = @"LoadMoreNewsCell";
    if(indexPath.row == [newsItems count]) {

        TIHNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
        
        if (cell == nil) {
            cell = [[TIHNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
        }

        return cell;
    }
    else {       
        TIHNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[TIHNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell clearSubViews];
        
        NSArray *newsItems = [_itemDictionary objectForKey:tag];
        [cell configureWithBaseObject:[newsItems objectAtIndex:indexPath.row]];
        if ([[cell newsUrl] isEqualToString:@""])
        {
            cell.userInteractionEnabled = NO;
            [cell.customDisclosureView setHidden:YES];
        }
        return cell;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TIHWebViewController* wvc = (TIHWebViewController*)segue.destinationViewController;
    TIHNewsCell* cell = (TIHNewsCell*)sender;
    wvc.urlAddress = [cell newsUrl];
}

@end