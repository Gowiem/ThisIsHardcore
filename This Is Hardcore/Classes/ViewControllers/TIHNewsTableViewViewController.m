//
//  TIHNewsTableViewViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHNewsTableViewViewController.h"

@interface TIHNewsTableViewViewController ()

@end

@implementation TIHNewsTableViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
//
//- (id)initWithStyle:(UITableViewStyle)style {
//    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
//        self.title = NSLocalizedString(@"List Model", @"Controller Title: List Model");
//        
//        // Each of the cell objects below is mapped to the NITextCell class.
//        NSArray* tableContents =
//        [NSArray arrayWithObjects:
//         [NITitleCellObject cellWithTitle:@"Row 1"],
//         [NITitleCellObject cellWithTitle:@"Row 2"],
//         [NISubtitleCellObject cellWithTitle:@"Row 3" subtitle:@"Subtitle"],
//         nil];
//        
//        // We use NICellFactory to create the cell views.
//        _model = [[NITableViewModel alloc] initWithListArray:tableContents
//                                                    delegate:(id)[NICellFactory class]];
//    }
//    return self;
//}

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