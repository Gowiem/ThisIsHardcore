//
//  TIHMoreCell.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/22/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHMoreDataModel.h"
#import <UIKit/UIKit.h>

@interface TIHMoreCell : UITableViewCell

@property (nonatomic, retain) TIHMoreDataModel *dataModel;
@property (nonatomic, retain) IBOutlet UIImageView *moreImage;
@property (nonatomic, retain) IBOutlet UILabel *moreLabel;

- (void)configureWithObject:(TIHMoreDataModel *)object;

@end
