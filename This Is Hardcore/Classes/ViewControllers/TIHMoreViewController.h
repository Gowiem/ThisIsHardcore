//
//  TIHMoreViewController.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/22/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "BaseViewController.h"

@interface TIHMoreViewController : BaseViewController {
    NSMutableArray *_items;
    UITableView *_myTable;
}

@property (strong, nonatomic) IBOutlet UITableView *myTable;

@end
