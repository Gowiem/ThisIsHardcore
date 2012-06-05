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

- (void)configureWithObject:(TIHNewsDataModel *)object {
    
    NSString *bodyText = [[object body] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.bodyLabel.text = bodyText;
    
    self.bodyLabel.numberOfLines = 0;
//    self.bodyLabel.frame = CGRectMake(83,30,200,39);
    [self.bodyLabel sizeToFit];
    
    if([object provider] == @"facebook") {
        [self.imageView setImage:[UIImage imageNamed:@"fbicon.png"]] ;
    }
    else {
        [self.imageView setImage:[UIImage imageNamed:@"twittericon.png"]] ;
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"h:mm a - EEEE MMMM d, YYYY"];
    NSString *dateString = [dateFormat stringFromDate:[object createdAt]];
    self.dateLabel.text = dateString ;
    // self.imageView.image = [object myGreatImageToDisplay];
    //NSLog(@" %@ %@ %@", self.frame, self.bodyLabel.frame);
    
    CGSize dateSize = [dateString sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:self.dateLabel.frame.size lineBreakMode:UILineBreakModeClip];
    CGSize bodySize = [bodyText sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:self.bodyLabel.frame.size lineBreakMode: UILineBreakModeWordWrap];
    
    CGFloat height =  dateSize.height + bodySize.height + 20;
    if(height < 80)
    {
        height = 80;
    }
    self.frame = CGRectMake(0,0,320,height);
    self.newsUrl = [object newsUrl];
}

@end
