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

@interface TIHPhotoPitViewController ()

@end

@implementation TIHPhotoPitViewController

- (void)viewDidLoad
{
    _photoPitItems = [[NSMutableArray alloc] init];
    tag = @"instagram-official";
    
    [super viewDidLoad];    
    [self loadData];
}

- (void)loadData
{
    NSString *endPointUrl = [[NSString stringWithFormat:@"%@/posts.json?key=\"%@\"&auth_token=unifeed-debug", UNIFEED_API_URL, tag] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Fetching URL %@", endPointUrl);
    NSURL *url = [NSURL URLWithString:endPointUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *
          request, NSHTTPURLResponse *response, id JSON) {
        [_photoPitItems removeAllObjects];
        for( id row in [JSON valueForKey:@"rows"]){
            [_photoPitItems addObject: [[TIHPhotoPitDataModel alloc] initWithProperties:row]];
        }
        [[super myTable] reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Fail!");
    }];
    
    [operation start];
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
    NSLog(@"Do Official Button Tapped");
    [super doOfficialButtonAction:sender];
    tag = @"instagram-official";
    [self loadData];
}
- (IBAction) doFanFeedButtonAction: (id)sender
{
    NSLog(@"Do Fan Feed Button Tapped");
    [super doFanFeedButtonAction:sender];
    tag = @"instagram-tag";
    [self loadData];
}

@end
