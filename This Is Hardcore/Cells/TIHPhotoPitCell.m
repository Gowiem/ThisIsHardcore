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

@implementation TIHPhotoPitCell

@synthesize photoImageView, dateLabel, tags;

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
    NINetworkImageView *networkImageView = [[NINetworkImageView alloc] initWithImage:[UIImage imageNamed:@"TIHC_PhotoPitLoad.png"]];
    
    [networkImageView setCenter: CGPointMake(CGRectGetMidX(self.photoImageView.bounds), CGRectGetMidY(self.photoImageView.bounds))];
    [networkImageView setPathToNetworkImage: [object imageUrl] forDisplaySize: self.photoImageView.frame.size];
    [[self photoImageView] addSubview:networkImageView];    
    self.tags.text = [object body];
}

@end
