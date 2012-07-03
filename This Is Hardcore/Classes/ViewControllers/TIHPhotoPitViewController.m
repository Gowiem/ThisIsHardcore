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

@interface TIHPhotoPitViewController ()

@end

@implementation TIHPhotoPitViewController

- (void)viewDidLoad
{
    tag = @"official";
    unifeedEntity = @"instagram";
    [super viewDidLoad];    
    [self loadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PhotoPitCell";
    
    TIHPhotoPitCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TIHPhotoPitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell clearSubViews];
    
    NSArray *photoPitItems = [_itemDictionary objectForKey:tag];
    [cell configureWithBaseObject:[photoPitItems objectAtIndex:indexPath.row]];
    
    return cell;
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
