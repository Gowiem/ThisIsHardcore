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
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    NSString *endPointUrl = [[NSString stringWithFormat:@"%@/posts.json?key=\"instagram\"&auth_token=unifeed-debug", UNIFEED_API_URL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:endPointUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
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


@end
