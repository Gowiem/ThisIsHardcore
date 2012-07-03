//
//  TIHScheduleViewController.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/14/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "BaseViewController.h"
#import "TIHBaseScheduleViewController.h"

@interface TIHScheduleViewController : TIHBaseScheduleViewController{
    int _selectedDay;
}

@property (strong, nonatomic) IBOutlet UILabel *dayDateLabel;

@property (strong, nonatomic) IBOutlet UIButton *thursButton;
@property (strong, nonatomic) IBOutlet UIButton *friButton;
@property (strong, nonatomic) IBOutlet UIButton *satButton;
@property (strong, nonatomic) IBOutlet UIButton *sunButton;
@property (strong, nonatomic) IBOutlet UIButton *afterButton;
@property (strong, nonatomic) IBOutlet UIView *flairView;

- (IBAction) doThursButtonAction:(id)sender;
- (IBAction) doFriButtonAction:(id)sender;
- (IBAction) doSatButtonAction:(id)sender;
- (IBAction) doSunButtonAction:(id)sender;
- (IBAction) doAfterButtonAction:(id)sender;

-(void)setSelectedDate: (NSDate*)date;

@end
