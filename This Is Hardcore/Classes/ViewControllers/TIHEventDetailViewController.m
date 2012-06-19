//
//  TIHEventDetailViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/14/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHEventDetailViewController.h"
#import "NINetworkImageView.h"
#import <Twitter/Twitter.h>

@interface TIHEventDetailViewController ()

@end

@implementation TIHEventDetailViewController

@synthesize artistDescriptionLabel, artistImageView, textLabelsView, artistNameLabel, venueLabel,bookmarkButton, shareButton, setTimeLabel, actionButtonsView, facebookButton, websiteButton,twitterButton, emailButton, dataModel, scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *artistName  = [dataModel artistName];
    NSString *venueName = [dataModel venueName];
    NSString *setTime = [dataModel setTimeDisplay];
    NSString *artistDescription = [dataModel artistDescription];
    
    self.artistNameLabel.text = artistName;
    self.venueLabel.text = [NSString stringWithFormat:@"@%@", venueName];
    self.setTimeLabel.text = setTime;
    self.artistDescriptionLabel.numberOfLines = 0;
    self.artistDescriptionLabel.text = artistDescription;
    [self.artistDescriptionLabel sizeToFit];
    
    UIImage *image = [UIImage imageNamed:@"TIHC_BandLoad.png"];
    NINetworkImageView* imageView = [[NINetworkImageView alloc] initWithImage:image];
    CGRect imageRect = CGRectMake(9, 5, 302, 201);
    self.artistImageView.frame = imageRect;
    imageView.frame = imageRect;
    [imageView setPathToNetworkImage:[dataModel imageUrl] forDisplaySize:CGSizeMake(302, 201) contentMode:UIViewContentModeScaleAspectFit];
    [[self artistImageView] addSubview:imageView];   
	
    double textLabelsViewOriginY = self.artistImageView.frame.size.height + self.artistImageView.frame.origin.y + 5;
    CGSize artistNameSize = [artistName sizeWithFont:self.artistNameLabel.font  constrainedToSize:self.artistNameLabel.frame.size lineBreakMode: UILineBreakModeTailTruncation];
    CGSize venueNameSize = [venueName sizeWithFont:self.venueLabel.font  constrainedToSize:self.venueLabel.frame.size lineBreakMode: UILineBreakModeTailTruncation];
    CGSize setTimeSize = [setTime sizeWithFont:self.setTimeLabel.font  constrainedToSize:self.setTimeLabel.frame.size lineBreakMode: UILineBreakModeTailTruncation];
    CGSize descriptionSize = [artistDescription sizeWithFont:self.artistDescriptionLabel.font constrainedToSize:self.artistDescriptionLabel.frame.size lineBreakMode:UILineBreakModeWordWrap];
    double textLabelsViewHeight = artistNameSize.height + venueNameSize.height + setTimeSize.height + descriptionSize.height + 10;    

    [[self textLabelsView] setFrame:CGRectMake(textLabelsView.frame.origin.x, textLabelsViewOriginY, textLabelsView.frame.size.width, textLabelsViewHeight)];
    [[self actionButtonsView] setFrame:CGRectMake(9, self.textLabelsView.frame.origin.y + self.textLabelsView.frame.size.height + 5, 302, self.actionButtonsView.frame.size.height)];
    
    double viewHeight = self.actionButtonsView.frame.size.height + self.actionButtonsView.frame.origin.y + 20;
    [[self scrollView] setContentSize:CGSizeMake(320, viewHeight)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) doShareButtonAction:(id)sender
{
    NSLog(@"doShareButtonAction");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Facebook", @"Twitter", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
           //TODO Implement Facebook Share
            break;
        }
        case 1:
        {
            [self shareViaTweet];
            break;
        }
    }
}

- (void)shareViaTweet
{  
    // Create the view controller
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    // Optional: set an image, url and initial text
    [twitter addImage:[UIImage imageNamed:@"iOSDevTips.png"]];
    [twitter addURL:[NSURL URLWithString:[NSString stringWithString:@"http://MobileDeveloperTips.com/"]]];
    [twitter setInitialText:@"Tweet from iOS 5 app using the Twitter framework."];
    
    // Show the controller
    [self presentModalViewController:twitter animated:YES];
    
    // Called when the tweet dialog has been closed
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) 
    {
        NSString *title = @"Tweet Status";
        NSString *msg; 
        
        if (result == TWTweetComposeViewControllerResultCancelled)
            msg = @"Tweet compostion was canceled.";
        else if (result == TWTweetComposeViewControllerResultDone)
            msg = @"Tweet composition completed.";
        
        // Show alert to see how things went...
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
        
        // Dismiss the controller
        [self dismissModalViewControllerAnimated:YES];
    };
}

- (IBAction) doWebsiteButtonAction:(id)sender
{
    
}
- (IBAction) doFacebookButtonAction:(id)sender
{
    
}
- (IBAction) doTwitterButtonAction:(id)sender
{
    
}
- (IBAction) doEmailButtonAction:(id)sender
{
    
}
- (IBAction) doBookmarkButtonAction:(id)sender
{
    
}
@end
