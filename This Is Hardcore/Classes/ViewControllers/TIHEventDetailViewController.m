//
//  TIHEventDetailViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/14/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHEventDetailViewController.h"
#import "TIHBookmarkManager.h"
#import "TIHDirectionManager.h"
#import "TIHNotificationManager.h"
#import "TIHWebViewController.h"
#import "NINetworkImageView.h"
#import "UIViewController+MBProgressHUD.h"
#import "UIAlertView+ShowMessage.h"
#import "GoogleAnalytics.h"
#import <Twitter/Twitter.h>
#import "TIHCalendarEventManager.h"

@interface TIHEventDetailViewController ()

@end

@implementation TIHEventDetailViewController

@synthesize artistDescriptionLabel, artistImageView, textLabelsView, artistNameLabel, venueLabel, directionsButton, bookmarkButton, shareButton, setTimeLabel, actionButtonsView, facebookButton, websiteButton,twitterButton, reminderButton, dataModel, scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *artistName  = [dataModel artistName];
    NSString *venueName = [dataModel venueName];
    NSString *setTime = [dataModel setTimeDisplay];
    NSString *artistDescription = [dataModel artistDescription];
    
    [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Event Detail - %@",artistName]];
    
    self.artistNameLabel.text = artistName;
    self.venueLabel.text = [NSString stringWithFormat:@"@%@", venueName];
    NSString *venueDirectionsUrl = [TIHDirectionManager getDirectionsUrlForVenue:venueName];
    if([venueDirectionsUrl length] == 0)
    {
        [directionsButton setHidden:YES];
    }
    self.setTimeLabel.text = setTime;
    self.artistDescriptionLabel.numberOfLines = 0;
    self.artistDescriptionLabel.text = artistDescription;
    [self.artistDescriptionLabel sizeToFit];
    
    UIImage *image = [UIImage imageNamed:@"TIHC_BandLoad.png"];
    NINetworkImageView* imageView = [[NINetworkImageView alloc] initWithImage:image];
    CGRect imageRect = CGRectMake(4.5, 5, 302, 201);
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
    [[self actionButtonsView] setFrame:CGRectMake(9, self.textLabelsView.frame.origin.y + self.textLabelsView.frame.size.height + 10, 302, self.actionButtonsView.frame.size.height)];
    
    double viewHeight = self.actionButtonsView.frame.size.height + self.actionButtonsView.frame.origin.y + 20;
    [[self scrollView] setContentSize:CGSizeMake(320, viewHeight)];

    [self.websiteButton setEnabled:[[dataModel artistWebsite] length] != 0];
    [self.facebookButton setEnabled:[[dataModel artistFBUrl] length] != 0];
    [self.twitterButton setEnabled:[[dataModel artistTwitterUrl] length] != 0];
    
    if (![self.websiteButton isEnabled]) {
        [self.websiteButton setImage:[UIImage imageNamed:@"artistsiteinactive.png"] forState:UIControlStateDisabled];
    } else {
        [self.websiteButton setImage:[UIImage imageNamed:@"artistsiteactive.png"] forState:UIControlStateNormal];
    }
    
    [self updateBookmarkDisplay];
    [self updateReminderDisplay];
}

#pragma mark - Update Bookmark Display

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

#pragma mark - Update Reminder Display

- (void)updateReminderDisplayToSet
{
    UIImage *reminderImage = [UIImage imageNamed:@"setreminder.png"];
    [self.reminderButton setImage:reminderImage forState:UIControlStateNormal];
}

- (void)updateReminderDisplayToUnset
{
    UIImage *reminderImage = [UIImage imageNamed:@"unsetreminder.png"];
    [self.reminderButton setImage:reminderImage forState:UIControlStateNormal];
}

- (void) updateReminderDisplay
{
    if([[dataModel startTime] compare:[NSDate date]] == NSOrderedDescending && ![[dataModel startTime] isEqualToDate:[dataModel endTime]])
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

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Share Button Actions

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
            //[self showHUDWithMessage:@"Sharing via facebook..."];
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
    if (IS_IOS6_AND_UP) {
        [[GoogleAnalytics instance]trackPageView:[NSString stringWithFormat:@"Event Detail iOS6 Twitter Share - %@",[dataModel artistName]]];
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            SLComposeViewController *twitterCompose = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            NSString *postDescription =
            [NSString stringWithFormat:@"%@ is playing %@ at %@. #THICFest 2013", [dataModel artistName], [dataModel venueName], [dataModel setTimeDisplay]];
            
            //set the initial text message
            [twitterCompose setInitialText:postDescription];
            
            //present the composer to the user
            [self presentViewController:twitterCompose animated:YES completion:nil];   
        } else {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Twitter Error"
                                      message:@"You may not have set up twitter service on your device or you may not be connected to the internet.\n If you are connected, go to the Settings application to add your Twitter account to this device."
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles: nil];
            [alertView show];
        }
    } else {
        [[GoogleAnalytics instance]trackPageView:[NSString stringWithFormat:@"Event Detail iOS5 Twitter Share - %@",[dataModel artistName]]];
        
        // Create the view controller
        TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
        
        // Optional: set an image, url and initial text
        if ([dataModel imageUrl] && !([[dataModel imageUrl] isEqualToString:@"/images/original/missing.png"])) {
            [twitter addURL:[NSURL URLWithString:[dataModel imageUrl]]];
        }
        
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
}

- (void)shareWithFacebook
{
    // If the Phone is running iOS 6 and up then use the Social Framework
    if(IS_IOS6_AND_UP) {
        [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Event Detail iOS6 Facebook Share - %@",[dataModel artistName]]];
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *fbComposer = [SLComposeViewController
                                                   composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            NSString *postDescription =
            [NSString stringWithFormat:@"This is Hardcore 2013! %@ is playing %@ at %@.", [dataModel artistName], [dataModel venueName], [dataModel setTimeDisplay]];
            
            //set the initial text message
            [fbComposer setInitialText:postDescription];
            
            NSURL *imageURL = [NSURL URLWithString:[dataModel imageUrl]];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage *eventImage = [UIImage imageWithData:imageData];
            
            //add image to post
            if ([fbComposer addImage:eventImage]) {
                NSLog(@"image added to the post");
            }
            
            //present the composer to the user
            [self presentViewController:fbComposer animated:YES completion:nil];
            
        }else {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Facebook Error"
                                      message:@"You may not have set up facebook service on your device or you may not be connected to the internet.\n If you are connected, go to the Settings application to add your Facebook account to this device."
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles: nil];
            [alertView show];
        }
    } else {
        [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Event Detail iOS5 Facebook Share - %@",[dataModel artistName]]];
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
}

#pragma mark - Website && Facebook && Twitter Button Actions

- (IBAction) doWebsiteButtonAction:(id)sender
{
     [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Event Detail Artist Website - %@",[dataModel artistName]]];
    [self performSegueWithIdentifier:@"EventDetailWebView" sender:[dataModel artistWebsite]];
}
- (IBAction) doFacebookButtonAction:(id)sender
{
    [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Event Detail Artist Facebook - %@",[dataModel artistName]]];
    [self performSegueWithIdentifier:@"EventDetailWebView" sender:[dataModel artistFBUrl]];
}
- (IBAction) doTwitterButtonAction:(id)sender
{
    [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Event Detail Artist Twitter - %@",[dataModel artistName]]];
    [self performSegueWithIdentifier:@"EventDetailWebView" sender:[dataModel artistTwitterUrl]];
}
-(void) shareViaEmail
{
     [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Event Detail Email Share - %@",[dataModel artistName]]];
    
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    mailController.mailComposeDelegate = self;
    [mailController setSubject:[NSString stringWithFormat:@"This Is Hardcore! %@ %@ %@", [dataModel artistName], [dataModel setTimeDisplay], [dataModel venueName]]];
    [self presentModalViewController:mailController animated:YES];
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Bookmark && Reminder Actions

- (IBAction) doBookmarkButtonAction:(id)sender
{
     [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Event Detail Bookmark - %@",[dataModel artistName]]];
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
    [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Event Detail Reminder - %@",[dataModel artistName]]];
    if([dataModel isEventReminderSet])
    {
        [[TIHCalendarEventManager instance] removeEventFromCalendarForEvent:dataModel withController:self];
    }
    else {
        [[TIHCalendarEventManager instance] addEventToCalendarForEvent:dataModel withController:self];
    }
}

#pragma mark -

-(void) openUrlFromString: (NSString *)s
{
    NSURL *url = [ [ NSURL alloc ] initWithString: s ];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - Facebook Authorization

- (void)didAuthorizeFacebook:(Facebook *)facebook
{
    [self shareWithFacebook];
}
- (void)didNotAuthorizeFacebook:(Facebook *)facebook
{
    [self hideHUD];
    [UIAlertView showAlertWithMessage:@"You must log in to Facebook and install the TIHC App to share."];
}

#pragma mark -

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

- (IBAction) doDirectionsButtonAction:(id)sender
{
    NSString *venueDirectionsUrl = [TIHDirectionManager getDirectionsUrlForVenue:[dataModel venueName]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: venueDirectionsUrl]];
}

@end