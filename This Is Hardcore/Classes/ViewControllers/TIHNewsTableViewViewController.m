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

@interface TIHNewsTableViewViewController ()
@end

@implementation TIHNewsTableViewViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"News", @"News");
        self.tabBarItem.image = [UIImage imageNamed:@"News"];
        _newsItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/posts.json?auth_token=unifeed-debug", UNIFEED_API_URL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for( id row in [JSON valueForKey:@"rows"]){
            [_newsItems addObject: [[TIHNewsDataModel alloc] initWithProperties:row]];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Fail!");
    }];
    
    [operation start];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _newsItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //create a cell
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil]; 
    TIHNewsCell *cell = [nibObjects objectAtIndex:0];

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

@end

//TODO: pull down data from json http://stackoverflow.com/questions/2968642/populate-uitableview-from-json