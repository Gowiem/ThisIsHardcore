//
//  TIHNewsCell.h
//  This Is Hardcore
//
//  Created by Odin on 5/31/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIHNewsDataModel.h"

@interface TIHNewsCell : UITableViewCell {
}

@property (nonatomic, retain) IBOutlet UIImageView *newsImage;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *bodyLabel;

// Configures the subviews of the cell with the given object.
- (void)configureWithObject:(TIHNewsDataModel *)object;

@end