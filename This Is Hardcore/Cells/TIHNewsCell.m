//
//  TIHNewsCell.m
//  This Is Hardcore
//
//  Created by Odin on 5/31/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHNewsCell.h"


@implementation TIHNewsCell

@synthesize newsImage, bodyLabel, dateLabel, newsUrl;


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
}

- (void)configureWithBaseObject:(TIHBaseDataModel *)base {
  
  TIHNewsDataModel *object = [[TIHNewsDataModel alloc] initWithProperties:base.properties];
  NSString *bodyText = [[object body] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  
  CGRect bodyLabelFrame = self.bodyLabel.frame;
  bodyLabelFrame.size.width = 222;
  self.bodyLabel.frame = bodyLabelFrame;
  self.bodyLabel.text = bodyText;
  self.bodyLabel.lineBreakMode = UILineBreakModeWordWrap;
  self.bodyLabel.numberOfLines = 0;
  [self.bodyLabel sizeToFit];  
  
  NSString* imageName = [[object provider] isEqualToString:@"facebook"] ? @"fbicon.png" : @"twittericon.png";
  [self.newsImage setImage:[UIImage imageNamed:imageName]];
  
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"h:mm a - EEEE MMMM d, YYYY"];
  NSString *dateString = [dateFormat stringFromDate:[object createdAt]];
  self.dateLabel.text = dateString ;
  
  CGFloat height = MAX( self.bodyLabel.frame.size.height + self.dateLabel.frame.size.height + 20, 80);
  
  self.frame = CGRectMake(0,0,320,height);
  self.newsUrl = [object newsUrl];
}

@end
