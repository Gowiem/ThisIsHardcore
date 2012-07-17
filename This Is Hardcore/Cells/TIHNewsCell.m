//
//  TIHNewsCell.m
//  This Is Hardcore
//
//  Created by Odin on 5/31/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHNewsCell.h"
#import "NINetworkImageView.h"

#define ELEMENT_PADDING 5.0
#define NEWS_IMAGE_WIDTH 40.0

@implementation TIHNewsCell

@synthesize newsImage, bodyLabel, dateLabel, authorLabel, newsUrl, sourceIcon, customDisclosureView;

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
    NSArray* subViews = [[self newsImage] subviews];
    for( UIView *aView in subViews ) {
        [aView removeFromSuperview];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
}

- (void) layoutBodyLabelWithModel:(TIHNewsDataModel *) object
{
    NSString *bodyText = [[object body] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    CGRect bodyLabelFrame = self.bodyLabel.frame;
    bodyLabelFrame.size.width = 222;
    self.bodyLabel.frame = bodyLabelFrame;
    self.bodyLabel.text = bodyText;
    self.bodyLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.bodyLabel.numberOfLines = 0;
    [self.bodyLabel sizeToFit];
}
- (void) layoutAuthorLabelWithModel:(TIHNewsDataModel *) object
{
    CGPoint bodyLabelOrigin = self.bodyLabel.frame.origin;
    CGSize bodyLabelSize = self.bodyLabel.frame.size;

    self.authorLabel.text = [object author];
    CGPoint authorLabelOrigin = CGPointMake(self.authorLabel.frame.origin.x, bodyLabelOrigin.y + bodyLabelSize.height + ELEMENT_PADDING);
    self.authorLabel.frame = CGRectMake(authorLabelOrigin.x, authorLabelOrigin.y, authorLabel.frame.size.width, authorLabel.frame.size.height);
}
- (void) layoutNewsImageWithModel:(TIHNewsDataModel *)object
{
    NINetworkImageView *imageView = [[NINetworkImageView alloc] initWithImage:[UIImage imageNamed:@"TIHC_thumbnailload.png"]];
    [imageView setFrame:CGRectMake(0, 0, NEWS_IMAGE_WIDTH, NEWS_IMAGE_WIDTH)];
    [imageView setPathToNetworkImage:[object profileImageURLString] forDisplaySize:CGSizeMake(NEWS_IMAGE_WIDTH, NEWS_IMAGE_WIDTH) contentMode:UIViewContentModeScaleAspectFit];
    [[self newsImage] addSubview:imageView];
}
- (void) layoutSourceIconWithModel:(TIHNewsDataModel *)object
{
    NSString* imageName = [[object provider] isEqualToString:@"facebook"] ? @"fbicon.png" : @"twittericon.png";
    [self.sourceIcon setImage:[UIImage imageNamed:imageName]];
}
- (void) layoutDateLabelWithModel:(TIHNewsDataModel *)object
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a - EEEE MMMM d, YYYY"];
    NSString *dateString = [dateFormat stringFromDate:[object createdAt]];
    self.dateLabel.text = dateString;
}
- (void) layoutCustomDisclosureView
{
    CGRect oldFrame = self.customDisclosureView.frame;
    self.customDisclosureView.frame = CGRectMake(oldFrame.origin.x,
                                                 (self.frame.size.height - 22.0)/2.0 + oldFrame.size.height/2.0,
                                                 oldFrame.size.width,
                                                 oldFrame.size.height);
}
- (void)configureWithBaseObject:(TIHBaseDataModel *)base {
  
  TIHNewsDataModel *object = [[TIHNewsDataModel alloc] initWithProperties:base.properties];
  
    [self layoutBodyLabelWithModel:object];
    [self layoutAuthorLabelWithModel:object];
    [self layoutNewsImageWithModel:object];
    [self layoutSourceIconWithModel:object];
    [self layoutDateLabelWithModel:object];

    self.newsUrl = [object newsUrl];

    float newCellHeight = self.authorLabel.frame.origin.y + authorLabel.frame.size.height + ELEMENT_PADDING;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newCellHeight);
    [self layoutCustomDisclosureView];
}

@end
