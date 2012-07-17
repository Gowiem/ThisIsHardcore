//
//  TIHNewsCell.h
//  This Is Hardcore
//
//  Created by Odin on 5/31/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIHNewsDataModel.h"

@interface TIHNewsCell : UITableViewCell {
}
@property (nonatomic, retain) NSString *newsUrl;

@property (nonatomic, retain) IBOutlet UIImageView *newsImage;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *bodyLabel;
@property (nonatomic, retain) IBOutlet UILabel *authorLabel;
@property (nonatomic, retain) IBOutlet UIImageView *sourceIcon;
@property (nonatomic, retain) IBOutlet UIView *customDisclosureView;

- (void)configureWithBaseObject:(TIHBaseDataModel *)base ;
- (void)clearSubViews;

@end
