//
//  TIHScheduleViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/14/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHScheduleViewController.h"

@interface TIHScheduleViewController ()

@end

@implementation TIHScheduleViewController

@synthesize myTable = _myTable, thursButton, friButton, satButton, sunButton, afterButton;

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
	// Do any additional setup after loading the view.
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


- (IBAction) doThursButtonAction:(id)sender
{
    [self resetButtonsSource:sender];
}
- (IBAction) doFriButtonAction:(id)sender
{
    [self resetButtonsSource:sender];
}
- (IBAction) doSatButtonAction:(id)sender
{
    [self resetButtonsSource:sender];
}
- (IBAction) doSunButtonAction:(id)sender
{
    [self resetButtonsSource:sender];    
}
- (IBAction) doAfterButtonAction:(id)sender
{
    [self resetButtonsSource:sender];
}

-(void) resetButtonsSource:(id)source
{
    NSArray *scheduleTabButtons = [[NSArray alloc] initWithObjects:self.thursButton, self.friButton, self.satButton, self.sunButton, self.afterButton, nil];
    NSArray *disabledTabButtonImages = [[NSArray alloc] initWithObjects: @"ThursTabG1.png", @"FriTabG2.png", @"SatTabG3.png", @"SunTabG4.png", @"AfterTabG4.png", nil];
    NSArray *enabledTabButtonImages = [[NSArray alloc] initWithObjects: @"ThursTabBlue.png", @"FriTabBlue.png", @"SatTabBlue.png", @"SunTabBlue.png", @"AfterTabBlue.png", nil];
    
    for(int x =0; x < [scheduleTabButtons count]; x++)
    {
        UIImage *newImage = Nil;
        UIButton *buttonToUpdate = [scheduleTabButtons objectAtIndex:x];
        if(source == [scheduleTabButtons objectAtIndex:x])
        {
            newImage = [UIImage imageNamed:[enabledTabButtonImages objectAtIndex:x]];
        }
        else {
            newImage = [UIImage imageNamed:[disabledTabButtonImages objectAtIndex:x]];            
        }

        [buttonToUpdate setBackgroundImage:newImage forState:UIControlStateNormal];
    }        
}
@end
