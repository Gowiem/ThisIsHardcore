//
//  TIHPhotoPitCell.m
//  This Is Hardcore
//
//  Created by Odin on 6/13/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHPhotoPitCell.h"
#import "NINetworkImageView.h"

@implementation TIHPhotoPitCell

@synthesize photoImage, dateLabel, tags;

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

- (void)configureWithObject:(TIHPhotoPitDataModel *)object {
    self.dateLabel.text = [object createdAgo];

    CGRect imageRect = CGRectMake(5, 5, self.imageView.frame.size.width - 5, self.imageView.frame.size.height - 5);
    NINetworkImageView *networkImageView = [[NINetworkImageView alloc] initWithFrame:imageRect];
    networkImageView.contentMode = UIViewContentModeScaleAspectFit;
    networkImageView.clipsToBounds = YES;
    [networkImageView setPathToNetworkImage:[object imageUrl]];
    [self.imageView addSubview: networkImageView];
    
    self.tags.text = [object tagDisplay];
}

@end
