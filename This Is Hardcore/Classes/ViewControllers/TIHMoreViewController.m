//
//  TIHMoreViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/22/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHMoreViewController.h"
#import "TIHMoreDataModel.h"
#import "TIHMoreCell.h"
#import "GoogleAnalytics.h"
#import "TIHWebViewController.h"

@interface TIHMoreViewController ()

@end

@implementation TIHMoreViewController

@synthesize myTable = _myTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    NSIndexPath *tableSelection = [self.myTable indexPathForSelectedRow];
    [self.myTable deselectRowAtIndexPath:tableSelection animated:NO];
    [super viewWillAppear:animated];
    [GoogleAnalytics trackPageView:@"More"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _items = [[NSMutableArray alloc] init];
    
    NSArray *names = [NSArray arrayWithObjects:@"Store", @"Stuff to do in Philly", @"Accomodations", @"About TIHC", @"TIHC Facebook", @"TIHC Twitter", @"About appRenaissance", nil];
    NSArray *images = [NSArray arrayWithObjects:@"TIHC_Store.png", @"TIHC_Stuff.png", @"TIHC_Accom.png", @"TIHC_About.png", @"TIHC_FB.png", @"TIHC_twit.png", @"TIHC_aboutApp.png", nil];
    NSArray *linkUrls = [NSArray arrayWithObjects:@"http://www.thisishardcorefest.com/", @"http://www.thisishardcorefest.com/stuff-to-do-in-philly/", @"http://www.thisishardcorefest.com/accomodations/",
                         @"http://www.thisishardcorefest.com/", @"https://www.facebook.com/thisishardcorefest", @"https://twitter.com/#!/TIHCfest",
                         @"http://assets.apprenaissance.com/mobile-about/", nil];
    
    for(int x = 0; x < [names count]; x++)
    {
        TIHMoreDataModel *m = [[TIHMoreDataModel alloc] init];
        m.name = [names objectAtIndex:x];
        m.imageName = [images objectAtIndex:x];
        m.linkUrl = [linkUrls objectAtIndex:x];
        [_items addObject:m];
    }
    [_myTable reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TIHMoreCell";
    
    TIHMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TIHMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell configureWithObject:[_items objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TIHMoreCell *cell = (TIHMoreCell*)[self tableView:_myTable cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"MoreDetailWebView" sender:cell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TIHWebViewController* wvc = (TIHWebViewController*)segue.destinationViewController;
    TIHMoreCell* cell = (TIHMoreCell*)sender;
    wvc.urlAddress = [[cell dataModel] linkUrl];
}

@end
