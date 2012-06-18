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

@synthesize artistIconView, artistNameLabel, bookmarkImage, setTimeLabel;

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
    
    NSString *artistText = [[object artistName] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.artistNameLabel.text = artistText;
    
    NSDateFormatter *startDateFormat = [[NSDateFormatter alloc] init];
    [startDateFormat setDateFormat:@"h:mm"];
    NSDateFormatter *endDateFormat = [[NSDateFormatter alloc] init];
    [endDateFormat setDateFormat:@"h:mm a"];
    
    NSString *startDateString = [startDateFormat stringFromDate:[object startTime]];
    NSString *endDateString = [endDateFormat stringFromDate:[object endTime]];

    self.setTimeLabel.text = [NSString stringWithFormat:@"%@ - %@", startDateString, endDateString];

    CGRect imageRect = CGRectMake(self.artistIconView.frame.origin.x, self.artistIconView.frame.origin.y, self.artistIconView.frame.size.width, self.artistIconView.frame.size.height);
    NINetworkImageView *networkImageView = [[NINetworkImageView alloc] initWithFrame:imageRect];
    [networkImageView setPathToNetworkImage:[object iconUrl]];
    [[self artistIconView] addSubview:networkImageView];    
    
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
