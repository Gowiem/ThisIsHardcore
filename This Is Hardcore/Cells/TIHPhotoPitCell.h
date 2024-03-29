//
//  TIHPhotoPitCell.h
//  This Is Hardcore
//
//  Created by Odin on 6/13/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIHPhotoPitDataModel.h"

@interface TIHPhotoPitCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIView *photoImageView;
@property (nonatomic, retain) IBOutlet UIView *authorImageView;
//@property (nonatomic, retain) IBOutlet UIImageView *dateIcon;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *tags;
@property (nonatomic, retain) IBOutlet UILabel *authorNameLabel;

// Configures the subviews of the cell with the given object.
- (void)configureWithBaseObject:(TIHBaseDataModel *)base ;
- (void)clearSubViews;

@end
