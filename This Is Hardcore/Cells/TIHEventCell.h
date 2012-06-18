//
//  TIHEventCell.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/15/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIHEventDataModel.h"

@interface TIHEventCell : UITableViewCell

@property (nonatomic, retain) TIHEventDataModel *dataModel;
@property (nonatomic, retain) IBOutlet UIView *artistIconView;
@property (nonatomic, retain) IBOutlet UILabel *artistNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *setTimeLabel;
@property (nonatomic, retain) IBOutlet UIImageView *bookmarkImage;

- (void)configureWithObject:(TIHEventDataModel *)object;

@end
