//
//  TIHNewsTableViewViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHApplicationConfiguration.h"
#import "TIHNewsTableViewViewController.h"
#import "AFJSONRequestOperation.h"
#import "TIHNewsDataModel.h"
#import "TIHNewsCell.h"
#import "TIHWebViewController.h"

@interface TIHNewsTableViewViewController ()
@end

@implementation TIHNewsTableViewViewController

@synthesize myTable = _myTable, fanFeedButton, officialButton;

- (void)viewDidLoad
{
    _newsItems = [[NSMutableArray alloc] init];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/posts.json?auth_token=unifeed-debug", UNIFEED_API_URL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for( id row in [JSON valueForKey:@"rows"]){
            [_newsItems addObject: [[TIHNewsDataModel alloc] initWithProperties:row]];
        }
        [self.myTable reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Fail!");
    }];
    
    [operation start];
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

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//TODO: pull down data from json http://stackoverflow.com/questions/2968642/populate-uitableview-from-json

- (IBAction) doOfficialButtonAction:(id)sender
{
    NSLog(@"%@ clicked", sender);
    UIButton *button = (UIButton *)sender;
    [button setBackgroundImage: [UIImage imageNamed:@"TIHCofficialBluetab.png"] forState:UIControlStateNormal];
    
    [self.fanFeedButton setBackgroundImage:[UIImage imageNamed:@"FanFeedG1tab.png"] forState:UIControlStateNormal];
}
- (IBAction) doFanFeedButtonAction: (id)sender
{
    NSLog(@"%@ clicked", sender);    
    UIButton *button = (UIButton *)sender;
    [button setBackgroundImage: [UIImage imageNamed:@"FanFeedBluetab.png"] forState:UIControlStateNormal];
    [self.officialButton setBackgroundImage:[UIImage imageNamed:@"TIHCofficialG1tab.png"] forState:UIControlStateNormal];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TIHWebViewController* wvc = (TIHWebViewController*)segue.destinationViewController;
    TIHNewsCell* cell = (TIHNewsCell*)sender;
    wvc.urlAddress = [cell newsUrl];
}
@end