//
//  TIHPhotoPitCell.m
//  This Is Hardcore
//
//  Created by Odin on 6/13/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHPhotoPitCell.h"
#import "TIHBaseDataModel.h"
#import "NINetworkImageView.h"
#import "UILabel+VerticalAlign.h"

@implementation TIHPhotoPitCell

@synthesize photoImageView, authorImageView, authorNameLabel, dateLabel, tags;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self clearSubViews];
    }
    return self;
}

-(void)clearSubViews
{
    NSArray* subViews = [[self photoImageView] subviews];
    for( UIView *aView in subViews ) {
        [aView removeFromSuperview];
    }
}
    
- (void)configureWithBaseObject:(TIHBaseDataModel *)base {
    TIHPhotoPitDataModel *object = [[TIHPhotoPitDataModel alloc] initWithProperties:base.properties];
    self.dateLabel.text = [object createdAgo];
    self.authorNameLabel.text = [object authorName];
    
    NINetworkImageView *networkImageView = [[NINetworkImageView alloc] initWithImage:[UIImage imageNamed:@"TIHC_PhotoPitLoad.png"]];
    [networkImageView setCenter: CGPointMake(CGRectGetMidX(self.photoImageView.bounds), CGRectGetMidY(self.photoImageView.bounds))];
    [networkImageView setPathToNetworkImage: [object imageUrl] forDisplaySize: self.photoImageView.frame.size];
    [[self photoImageView] addSubview:networkImageView];
       
    NINetworkImageView *authorNetworkImageView = [[NINetworkImageView alloc] initWithImage:[UIImage imageNamed:@"TIHC_thumbnailload.png"]];
    [authorNetworkImageView setFrame:CGRectMake(0, 0, 40, 40)];

    [authorNetworkImageView setPathToNetworkImage: [object authorImageUrl] forDisplaySize: CGSizeMake(40, 40)];
    [[self authorImageView] addSubview:authorNetworkImageView];

    self.tags.text = [object body];
    [self.tags alignTop];
}

@end
