//
//  TIHMoreCell.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/22/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHMoreCell.h"

@implementation TIHMoreCell

@synthesize moreImage, moreLabel, dataModel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithObject:(TIHMoreDataModel *)object {
    self.dataModel = object;

    self.moreLabel.text = [self.dataModel name];
    self.moreImage.image = [UIImage imageNamed:[self.dataModel imageName]];
}

@end
