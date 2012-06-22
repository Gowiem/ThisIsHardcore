//
//  TIHEventDetailViewController.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/14/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "BaseTableViewController.h"
#import "TIHEventDataModel.h"
#import "ARFacebook.h"
#import <MessageUI/MessageUI.h>

@interface TIHEventDetailViewController : BaseTableViewController<UIActionSheetDelegate, MFMailComposeViewControllerDelegate, FacebookAuthorizedDelegate, FBRequestDelegate> 

@property (nonatomic, retain) TIHEventDataModel *dataModel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *artistImageView;
@property (strong, nonatomic) IBOutlet UIView *textLabelsView;
@property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *venueLabel;
@property (strong, nonatomic) IBOutlet UILabel *setTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIView *actionButtonsView;
@property (strong, nonatomic) IBOutlet UIButton *websiteButton;
@property (strong, nonatomic) IBOutlet UIButton *facebookButton;
@property (strong, nonatomic) IBOutlet UIButton *twitterButton;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;
@property (strong, nonatomic) IBOutlet UIButton *bookmarkButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;

- (IBAction) doWebsiteButtonAction:(id)sender;
- (IBAction) doFacebookButtonAction:(id)sender;
- (IBAction) doTwitterButtonAction:(id)sender;
- (IBAction) doEmailButtonAction:(id)sender;
- (IBAction) doBookmarkButtonAction:(id)sender;
- (IBAction) doShareButtonAction:(id)sender;

@end
