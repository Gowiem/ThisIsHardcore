//
//  TIHEventDetailViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/14/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHEventDetailViewController.h"
#import "TIHBookmarkManager.h"
#import "TIHNotificationManager.h"
#import "TIHWebViewController.h"
#import "NINetworkImageView.h"
#import "UIViewController+MBProgressHUD.h"
#import "UIAlertView+ShowMessage.h"
#import <Twitter/Twitter.h>

@interface TIHEventDetailViewController ()

@end

@implementation TIHEventDetailViewController

@synthesize artistDescriptionLabel, artistImageView, textLabelsView, artistNameLabel, venueLabel,bookmarkButton, shareButton, setTimeLabel, actionButtonsView, facebookButton, websiteButton,twitterButton, reminderButton, dataModel, scrollView;

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

    [self.websiteButton setEnabled:[[dataModel artistWebsite] length] != 0];
    [self.facebookButton setEnabled:[[dataModel artistFBUrl] length] != 0];
    [self.twitterButton setEnabled:[[dataModel artistTwitterUrl] length] != 0];
    
    [self updateBookmarkDisplay];
    [self updateReminderDisplay];
}

- (void) updateBookmarkDisplay
{
    UIImage *bookmarkImage;
    if([dataModel isEventBookmarked])
    {
        bookmarkImage = [UIImage imageNamed:@"bookmarkbuttonremove.png"];
    }
    else {
        bookmarkImage = [UIImage imageNamed:@"bookmarkbutton.png"];
    }
    [self.bookmarkButton setImage:bookmarkImage forState:UIControlStateNormal];
}

- (void) updateReminderDisplay
{
    if([[dataModel startTime] compare:[NSDate date]] == NSOrderedDescending)
    {
        UIImage *reminderImage;
        if([dataModel isEventReminderSet])
        {
            reminderImage = [UIImage imageNamed:@"unsetreminder.png"];
        }
        else {
            reminderImage = [UIImage imageNamed:@"setreminder.png"];
        }
        [self.reminderButton setImage:reminderImage forState:UIControlStateNormal];
    }
    else {
        //This is done in the storyboard , wasnt working not sure why - KBC
        [self.reminderButton setImage:[UIImage imageNamed:@"setreminderinactive.png"] forState:UIControlStateDisabled];
        [self.reminderButton setEnabled:NO];
    }
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
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Facebook", @"Twitter", @"Email", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            [self showHUDWithMessage:@"Sharing via facebook..."];
            [self shareWithFacebook];
            break;
        }
        case 1:
        {
            [self shareViaTweet];
            break;
        }
        case 2:
        {
            [self shareViaEmail];
            break;
        }
    }
}

- (void)shareViaTweet
{  
    // Create the view controller
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    
    // Optional: set an image, url and initial text
    [twitter addURL:[NSURL URLWithString:[dataModel imageUrl]]];
    [twitter setInitialText: [NSString stringWithFormat:@"%@ , %@, %@ #TIHCFest ", [dataModel artistName], [dataModel setTimeDisplay], [dataModel venueName]] ];
    
    // Show the controller
    [self presentModalViewController:twitter animated:YES];
    
    // Called when the tweet dialog has been closed
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) 
    {
        NSString *title = @"Share";
        NSString *msg; 
        
        if (result == TWTweetComposeViewControllerResultCancelled)
            msg = @"Tweet was canceled.";
        else if (result == TWTweetComposeViewControllerResultDone)
            msg = @"Tweeted!";
        
        // Show alert to see how things went...
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
        
        // Dismiss the controller
        [self dismissModalViewControllerAnimated:YES];
    };
}

- (IBAction) doWebsiteButtonAction:(id)sender
{
    [self performSegueWithIdentifier:@"EventDetailWebView" sender:[dataModel artistWebsite]];
}
- (IBAction) doFacebookButtonAction:(id)sender
{
    [self performSegueWithIdentifier:@"EventDetailWebView" sender:[dataModel artistFBUrl]];
}
- (IBAction) doTwitterButtonAction:(id)sender
{
    [self performSegueWithIdentifier:@"EventDetailWebView" sender:[dataModel artistTwitterUrl]];
}
-(void) shareViaEmail
{
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    mailController.mailComposeDelegate = self;
    [mailController setSubject:[NSString stringWithFormat:@"This Is Hardcore! %@ %@ %@", [dataModel artistName], [dataModel setTimeDisplay], [dataModel venueName]]];
    [self presentModalViewController:mailController animated:YES];
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction) doBookmarkButtonAction:(id)sender
{
    TIHBookmarkManager *b = [[TIHBookmarkManager alloc] init];
    if([dataModel isEventBookmarked])
    {
        [b removeBookmarkByEventId:[dataModel eventId]];
    }
    else {
        [b addBookmarkByEventId:[dataModel eventId]];
    }
    [self updateBookmarkDisplay];
}

- (IBAction) doRemindButtonAction:(id)sender
{
    if([dataModel isEventReminderSet])
    {
        [TIHNotificationManager cancelNotificationByEventId:[dataModel eventId]];
    }
    else {
        [TIHNotificationManager scheduleNotificationWithEvent:dataModel];

    }
    [self updateReminderDisplay];
}

-(void) openUrlFromString: (NSString *)s
{
    NSURL *url = [ [ NSURL alloc ] initWithString: s ];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)shareWithFacebook
{
    ARFacebook *facebook = [ARFacebook sharedARFacebook];
    facebook.authDelegate = self;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
       && [defaults objectForKey:@"FBExpirationDateKey"]) {
       facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
       facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }

    if(![facebook isSessionValid])
    {
        [facebook authorizeWithStandardPermissions];
        return;
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *message = [NSString stringWithFormat:@"This is Hardcore! %@ is playing %@ at %@. ", [dataModel artistName], [dataModel venueName], [dataModel setTimeDisplay]];
    [params setObject:message forKey:@"message"];
    [params setObject:[dataModel imageUrl] forKey:@"picture"];
    [facebook requestWithGraphPath:@"me/feed" andParams:params andHttpMethod:@"POST" andDelegate:self];
}

- (void)didAuthorizeFacebook:(Facebook *)facebook
{
    [self shareWithFacebook];
}
- (void)didNotAuthorizeFacebook:(Facebook *)facebook
{
    [self hideHUD];
    [UIAlertView showAlertWithMessage:@"You must log in to Facebook and install the TIHC App to share."];
}
- (void)fbSessionInvalidated
{
    [self hideHUD];
    [UIAlertView showAlertWithMessage:@"There was a problem sharing your selection with Facebook."];
}


- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    [self hideHUD];
    [UIAlertView showAlertWithMessage:@"There was a problem sharing your selection with Facebook."];
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    [self hideHUDWithCompletionMessage:@"Shared!"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TIHWebViewController* wvc = (TIHWebViewController*)segue.destinationViewController;
    wvc.urlAddress = (NSString*)sender;
}
@end
