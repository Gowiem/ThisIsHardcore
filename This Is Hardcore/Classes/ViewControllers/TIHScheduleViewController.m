//
//  TIHScheduleViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/14/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHScheduleViewController.h"
#import "TIHScheduleHeaderView.h"
#import "TIHEventDataModel.h"
#import "TIHEventCell.h"
#import "GoogleAnalytics.h"
#import "NSDate+Comparison.h"

@implementation TIHScheduleViewController

@synthesize thursButton, friButton, satButton, sunButton, dayDateLabel, venueLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super loadData];
    _selectedDay = 0;
    [self setDayDateLabelText];
    [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Schedule - %i",_selectedDay]];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[super myTable] reloadData];
}

-(void)setSelectedDate: (NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *festivalStartDate = [self getFestivalStartDate] ;
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&festivalStartDate
                 interval:NULL forDate:festivalStartDate];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&date
                 interval:NULL forDate:date];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit fromDate:date toDate:festivalStartDate options:0];

    _selectedDay = MIN( [difference day], 4);
    NSLog(@"Selected Day : %i", _selectedDay);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *venueName = [self getVenueNameForSection:section];
    return [[self getEventsByVenue:venueName] count];
}

-(NSString*) getVenueNameForSection:(NSInteger) section
{
    if(section == 0)
    {
        NSArray *festivalVenuesByDay = [self getMainVenueNames];
        return [festivalVenuesByDay objectAtIndex: _selectedDay];
    }
    else {
        return [[self getAfterPartyVenues] objectAtIndex:section - 1];
    }
}

- (NSArray *) getMainVenueNames
{
    return [NSArray arrayWithObjects:@"Electric Factory", @"Electric Factory", @"Electric Factory", @"Electric Factory" ,nil];
}

- (NSArray *) getScheduleItemsBySelectedDay
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
   
    NSDate *eventStartDate = [self getSelectedDate];
    // Time is 4 hours ahead. Adding -4 hours to get the correct time
    eventStartDate = [eventStartDate dateByAddingTimeInterval:-4*60*60];
    NSDate *eventEndDate = [eventStartDate dateByAddingTimeInterval:24*60*60];
    
    if(_selectedDay >= 0 && _selectedDay < 4)
    {
        for (TIHEventDataModel *e in super.scheduleItems) {
            if([NSDate date: e.startTime isBetweenDate:eventStartDate andDate: eventEndDate])
            {
                [results addObject:e];
            }
        }
    }
    
    return [results sortedArrayUsingSelector:@selector(compare:)];
}

-(NSArray*)getSelectedDateVenues {
    NSMutableArray *venues = [[NSMutableArray alloc] init];
    for(TIHEventDataModel *m in [self getScheduleItemsBySelectedDay])
    {
        NSString *venueName = [m venueName];
        if(!([venues containsObject:venueName]))
        {
            if([venueName length] != 0)
                [venues addObject:venueName];
        }
    }
    return venues;
}

-(NSArray*)getAfterPartyVenues {
    NSArray *venues = [self getSelectedDateVenues];
    NSArray *festivalVenues = [NSArray arrayWithObjects:@"Union Transfer", @"Electric Factory" , nil];
    NSMutableArray *afterPartyVenues = [[NSMutableArray alloc] init];
    for(NSString *venue in venues)
    {
        if(!([festivalVenues containsObject:venue]))
        {
            [afterPartyVenues addObject:venue];
        }
    }
    NSArray *sortedAfterPartyVenues = [afterPartyVenues sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    return sortedAfterPartyVenues;
}

-(NSArray*)getEventsByVenue: (NSString*) venueName
{
    NSArray *events = [self getScheduleItemsBySelectedDay];
    NSMutableArray *venueEvents = [[NSMutableArray alloc] init];
    for(TIHEventDataModel *m in events)
    {
        NSString *venue = [m venueName];
        if([venue isEqualToString:venueName]) 
        {
            [venueEvents addObject:m];
        }
    }
    return venueEvents;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self getSelectedDateVenues] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        // Main Event
        TIHScheduleHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"TIHScheduleHeaderView" owner:self options:nil] objectAtIndex:0];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMMM d, YYYY"];  
        view.titleLabel.text = [dateFormat stringFromDate:[self getSelectedDate]];
        
        view.venueLabel.text = [[self getMainVenueNames] objectAtIndex:_selectedDay];
        return view;
    }
    else 
    {
        // After Party
        NSArray *afterPartyVenues = [self getAfterPartyVenues];
        NSString *afterPartyVenueForSection = [afterPartyVenues objectAtIndex:section - 1];
    
        TIHScheduleHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"TIHScheduleHeaderView" owner:self options:nil] objectAtIndex:0];
        view.titleLabel.text = @"After Party";
        view.venueLabel.text = afterPartyVenueForSection;
        return view;
    }
}

- (NSString*)formatTypeToString:(NSComparisonResult)formatType {
    NSString *result = nil;
    switch(formatType) {
        case NSOrderedAscending:
            result = @"NSOrderedAscending";
            break;
        case NSOrderedSame:
            result = @"NSOrderedSame";
            break;
        case NSOrderedDescending:
            result = @"NSOrderedDescending";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TIHEventCell";
    
    TIHEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TIHEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSString *venueName = [self getVenueNameForSection:indexPath.section];
    NSArray *events = [self getEventsByVenue:venueName];

    [cell configureWithObject:[events objectAtIndex:indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

- (NSDate*) getFestivalStartDate
{
    return [self getFestivalStartDatePlus:0];
}
- (NSDate*) getSelectedDate
{
    return [self getFestivalStartDatePlus:_selectedDay];
}

// TODO: This shit needs to be configurable from the server.
- (NSDate*)getFestivalStartDatePlus:(int)daysLater
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setHour:0];
    [comps setDay: 24 + daysLater];
    [comps setMonth:7];
    [comps setYear:2014];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    return [gregorian dateFromComponents:comps];
}
               
- (IBAction) doThursButtonAction:(id)sender
{
    _selectedDay = 0;
    [self updateDisplayForSelectedDayForSender:sender];
}
- (IBAction) doFriButtonAction:(id)sender
{
    _selectedDay = 1;
    [self updateDisplayForSelectedDayForSender:sender];
}
- (IBAction) doSatButtonAction:(id)sender
{
    _selectedDay = 2;
    [self updateDisplayForSelectedDayForSender:sender];
}
- (IBAction) doSunButtonAction:(id)sender
{
    _selectedDay = 3;
    [self updateDisplayForSelectedDayForSender:sender];
}

-(void) updateDisplayForSelectedDayForSender:(id)sender
{
    [[GoogleAnalytics instance] trackPageView:[NSString stringWithFormat:@"Schedule - %i",_selectedDay]];
    [super myTable].contentOffset = CGPointMake(0, 0);
    [self setDayDateLabelText];
    [self updateVenueNameLabel];
    [self resetButtonsSource:sender];
    [[super myTable] reloadData];    
}

-(void) updateVenueNameLabel
{
    self.venueLabel.text = [[self getMainVenueNames] objectAtIndex:_selectedDay];
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
    NSArray *scheduleTabButtons = [[NSArray alloc] initWithObjects:self.thursButton, self.friButton, self.satButton, self.sunButton, nil];
    NSArray *disabledTabButtonImages = [[NSArray alloc] initWithObjects: @"ThursTabG1.png", @"FriTabG2.png", @"SatTabG3.png", @"SunTabG4.png", nil];
    NSArray *enabledTabButtonImages = [[NSArray alloc] initWithObjects: @"ThursTabBlue.png", @"FriTabBlue.png", @"SatTabBlue.png", @"SunTabBlue.png", nil];
    
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
    NSArray *venues = [self getSelectedDateVenues];
    NSArray *events;
    
    // Do we have more than 1 venue
    if ([venues count] > 1)
    {
        // Complex case of more than 1 section
        events = [self getEventsByVenue:[venues objectAtIndex:indexPath.section]];
    }
    else 
    {
        // Simple case of only 1 section
        events = [self getScheduleItemsBySelectedDay];
    }
   
    TIHEventDataModel *modelData = [events objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"segueToEventDetail" sender:modelData];
}

@end
