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

@synthesize photoImageView, dateLabel, tags;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)configureWithObject:(TIHPhotoPitDataModel *)object {
    self.dateLabel.text = [object createdAgo];

    CGRect imageRect = CGRectMake(self.photoImageView.frame.origin.x, self.photoImageView.frame.origin.y, self.photoImageView.frame.size.width, self.photoImageView.frame.size.height);
    NINetworkImageView *networkImageView = [[NINetworkImageView alloc] initWithFrame:imageRect];
    [networkImageView setPathToNetworkImage:[object imageUrl]];
    [[self photoImageView] addSubview:networkImageView];    
    self.tags.text = [object tagDisplay];
}

@end
