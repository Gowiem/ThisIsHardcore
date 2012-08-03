//
//  TIHPhotoPitViewControllerViewController.m
//  This Is Hardcore
//
//  Created by Odin on 6/13/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "AFJSONRequestOperation.h"
#import "TIHPhotoPitViewController.h"
#import "TIHPhotoPitCell.h"
#import "GoogleAnalytics.h"

@interface TIHPhotoPitViewController ()

@end

@implementation TIHPhotoPitViewController

- (void)viewDidLoad
{
    tag = @"official";
    unifeedEntity = @"instagram";
    [GoogleAnalytics trackPageView:[NSString stringWithFormat:@"%@ - %@",unifeedEntity,tag]];
    [super viewDidLoad];    
    [self loadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [GoogleAnalytics trackPageView:@"PhotoPit"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *photoPitItems = [_itemDictionary objectForKey:tag];
    static NSString *CellIdentifier = @"PhotoPitCell";
    static NSString *MoreCellIdentifier = @"LoadMorePhotoPitCell";
    if(indexPath.row == [photoPitItems count]) {
        TIHPhotoPitCell *cell = [tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
        if (cell == nil) {
            cell = [[TIHPhotoPitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreCellIdentifier];
        }

        return cell;
    }
    else {              
        TIHPhotoPitCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[TIHPhotoPitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell clearSubViews];
        
        [cell configureWithBaseObject:[photoPitItems objectAtIndex:indexPath.row]];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *photoPitItems = [_itemDictionary objectForKey:tag];
    if(indexPath.row == [photoPitItems count]) {
        return 40; //Loading Cell
    }
    else {
        return 385; //PhotoPit Cell
    }
}

- (IBAction) doOfficialButtonAction:(id)sender
{
    [super doOfficialButtonAction:sender];
    tag = @"official";
    [GoogleAnalytics trackPageView:[NSString stringWithFormat:@"%@ - %@",unifeedEntity,tag]];
    [self loadData];
}
- (IBAction) doFanFeedButtonAction: (id)sender
{
    [super doFanFeedButtonAction:sender];
    tag = @"tagged";
    [GoogleAnalytics trackPageView:[NSString stringWithFormat:@"%@ - %@",unifeedEntity,tag]];
    [self loadData];
}
@end
