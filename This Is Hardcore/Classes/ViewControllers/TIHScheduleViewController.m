//
//  TIHScheduleViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/14/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHScheduleViewController.h"
#import "TIHApplicationConfiguration.h"
#import "TIHEventDataModel.h"
#import "TIHEventCell.h"
#import "NSDate+Comparison.h"
#import "AFJSONRequestOperation.h"

@interface TIHScheduleViewController ()

@end

@implementation TIHScheduleViewController

@synthesize myTable = _myTable, thursButton, friButton, satButton, sunButton, afterButton, dayDateLabel;


-(void) loadData
{
    _scheduleItems = [[NSMutableArray alloc] init];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/cms/events.json?auth_token=unifeed-debug", UNIFEED_API_URL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for( id row in JSON){
            [_scheduleItems addObject: [[TIHEventDataModel alloc] initWithProperties:row]];
        }
        [_myTable reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Fail!");
    }];
    
    [operation start];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    _selectedDay = 0;
    [self setDayDateLabelText];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [[self getScheduleItemsBySelectedDay] count];
}

- (NSArray *) getScheduleItemsBySelectedDay
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
   
    NSDate *eventStartDate = [self getSelectedDate];
    NSDate *eventEndDate = [eventStartDate dateByAddingTimeInterval:24*60*60];    
    
    if(_selectedDay >= 0 && _selectedDay < 4)
    {
        for (TIHEventDataModel *e in _scheduleItems) {
            if([NSDate date: e.startTime isBetweenDate:eventStartDate andDate: eventEndDate])
            {
                [results addObject:e];
            }
        }
    }
    return [results sortedArrayUsingSelector:@selector(compare:)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TIHEventCell";
    
    TIHEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TIHEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *events = [self getScheduleItemsBySelectedDay];
    [cell configureWithObject:[events objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSDate*) getSelectedDate
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay: 9 + _selectedDay];
    [comps setMonth:8];
    [comps setYear:2012];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    return [gregorian dateFromComponents:comps];
    
}
               
- (IBAction) doThursButtonAction:(id)sender
{
    _selectedDay = 0;
    [self resetButtonsSource:sender];
    [self setDayDateLabelText];
    [self loadData];
}
- (IBAction) doFriButtonAction:(id)sender
{
    _selectedDay = 1;
    [self resetButtonsSource:sender];
    [self setDayDateLabelText];
    [self loadData];
}
- (IBAction) doSatButtonAction:(id)sender
{
    _selectedDay = 2;
    [self resetButtonsSource:sender];
    [self setDayDateLabelText];
    [self loadData];
}
- (IBAction) doSunButtonAction:(id)sender
{
    _selectedDay = 3;
    [self resetButtonsSource:sender];    
    [self setDayDateLabelText];
    [self loadData];
}
- (IBAction) doAfterButtonAction:(id)sender
{
    _selectedDay = 4;
    [self resetButtonsSource:sender];
    [self setDayDateLabelText];
    [self loadData];
}

-(void) setDayDateLabelText
{
    if(_selectedDay != 4)
    {
        [self.dayDateLabel setHidden:NO];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMMM d, YYYY"];        
        self.dayDateLabel.text =  [dateFormat stringFromDate:[self getSelectedDate]];
    }
    else {
        [self.dayDateLabel setHidden:YES];
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *events = [self getScheduleItemsBySelectedDay];
    TIHEventDataModel *modelData = [events objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"segueToEventDetail" sender:modelData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)model {
    if ([segue.identifier isEqualToString:@"segueToEventDetail"])
    {
        id edvc = segue.destinationViewController;
        [edvc setDataModel:model];
    }
}
@end
