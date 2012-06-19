//
//  TIHEventCell.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/15/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHEventCell.h"
#import "TIHBookmarkManager.h"
#import "NINetworkImageView.h"

@implementation TIHEventCell

@synthesize artistIconView, artistNameLabel, bookmarkImage, setTimeLabel, dataModel;

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

- (void)configureWithObject:(TIHEventDataModel *)object {
    self.dataModel = object;
    NSString *artistText = [[object artistName] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.artistNameLabel.text = artistText;
    
    self.setTimeLabel.text = [object setTimeDisplay];

    UIImage *image = [UIImage imageNamed:@"TIHC_thumbnailload.png"];
    NINetworkImageView* imageView = [[NINetworkImageView alloc] initWithImage:image];
    [imageView setPathToNetworkImage:[object iconUrl] forDisplaySize:self.artistIconView.frame.size contentMode:UIViewContentModeScaleAspectFit];
    [[self artistIconView] addSubview:imageView];   
    
    NSSet *bookmarks = [[[TIHBookmarkManager alloc] init] getBookmarks];
    if(![bookmarks containsObject:[object eventId]])
    {
        [[self bookmarkImage] setHidden:NO];
    }
    else
    {
        [[ self bookmarkImage] setHidden:YES];
    }
}

@end
