//
//  TIHScheduleViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/14/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHScheduleViewController.h"
#import "TIHBookmarkScheduleHeaderView.h"
#import "TIHEventDataModel.h"
#import "TIHEventCell.h"
#import "NSDate+Comparison.h"

@implementation TIHScheduleViewController

@synthesize thursButton, friButton, satButton, sunButton, afterButton, dayDateLabel, flairView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super loadData];
    _selectedDay = 0;
    [self setDayDateLabelText];
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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[super myTable] reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_selectedDay == 4)
    {
        NSString *dateDisplayForSection = [[self getAfterFestivalDates] objectAtIndex:section];
        NSArray *events = [self getAfterFestivalEventsByDateDisplay:dateDisplayForSection];
        return [events count];
    }
    else
    {
        return  [[self getScheduleItemsBySelectedDay] count];        
    }
}

- (NSArray *) getScheduleItemsBySelectedDay
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
   
    NSDate *eventStartDate = [self getSelectedDate];
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
    else if (_selectedDay == 4)
    {
        NSDate *lastDayOfFestival = [self getFestivalStartDatePlus:4];
        for (TIHEventDataModel *e in super.scheduleItems) {
            NSComparisonResult r = [lastDayOfFestival compare: e.startTime];
            if(r == NSOrderedAscending || r == NSOrderedSame)
            {
                [results addObject:e];
            }
        }
    }
    return [results sortedArrayUsingSelector:@selector(compare:)];
}

-(NSArray*) getAfterFestivalDates {
    if(_selectedDay == 4)
    {
        NSMutableArray *dates = [[NSMutableArray alloc] init];
        for(TIHEventDataModel *m  in [self getScheduleItemsBySelectedDay])
        {
            NSString *eventStartDateDisplay = [m startDateDisplay];
            if(!([dates containsObject: eventStartDateDisplay]))
            {
                [dates addObject: eventStartDateDisplay];
            }
        }
        return dates;
    }
    else {
        return nil;
    }
}

-(NSArray*)getAfterFestivalEventsByDateDisplay: (NSString*) dateDisplay {
    if(_selectedDay == 4)
    {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for(TIHEventDataModel *item  in [self getScheduleItemsBySelectedDay])
        {
            if([[item startDateDisplay] isEqualToString:dateDisplay])
            {
                [result addObject:item];
            }
        }
        return result;
    }
    else {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(_selectedDay == 4)
    {
        NSArray *afterFestivalEventDates = [self getAfterFestivalDates];
        return [afterFestivalEventDates count];
    }
    else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_selectedDay == 4)
        return 14;
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *afterFestivalEventDates = [self getAfterFestivalDates];
    if([afterFestivalEventDates count] != 0  && _selectedDay == 4)
    {
        NSString *dateDisplayForSection = [afterFestivalEventDates objectAtIndex: section];
        TIHBookmarkScheduleHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"TIHBookmarkScheduleHeaderView" owner:self options:nil] objectAtIndex:0];
        view.sectionLabel.text = dateDisplayForSection;
        return view;
    }
    else {
        UIView *blankView = [[UIView alloc] init];
        [blankView setHidden:YES];
        return blankView;
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
    
    if(_selectedDay != 4)
    {
        NSArray *events = [self getScheduleItemsBySelectedDay];
        [cell configureWithObject:[events objectAtIndex:indexPath.row]];
    }
    else {
        NSString *dateDisplayForSection = [[self getAfterFestivalDates] objectAtIndex:indexPath.section];
        NSArray *events = [self getAfterFestivalEventsByDateDisplay:dateDisplayForSection];
        NSLog(@"Date Display : %@", dateDisplayForSection);
        NSLog(@"Event count : %i", [events count]);
        NSLog(@"Index Path Section : %i", indexPath.section);
        NSLog(@"Index Path Row: %i", indexPath.row);
        [cell configureWithObject:[events objectAtIndex:indexPath.row]];
    }
    
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
- (NSDate*)getFestivalStartDatePlus:(int)daysLater
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setHour:0];
    [comps setDay: 9 + daysLater];
    [comps setMonth:8];
    [comps setYear:2012];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    return [gregorian dateFromComponents:comps];
}
               
- (IBAction) doThursButtonAction:(id)sender
{
    _selectedDay = 0;
    [self setFlairDisplay:YES];
    [self resetButtonsSource:sender];
    [self setDayDateLabelText];
    [self loadData];
}
- (IBAction) doFriButtonAction:(id)sender
{
    _selectedDay = 1;
    [self setFlairDisplay:YES];
    [self resetButtonsSource:sender];
    [self setDayDateLabelText];
    [self loadData];
}
- (IBAction) doSatButtonAction:(id)sender
{
    _selectedDay = 2;
    [self setFlairDisplay:YES];
    [self resetButtonsSource:sender];
    [self setDayDateLabelText];
    [self loadData];
}
- (IBAction) doSunButtonAction:(id)sender
{
    _selectedDay = 3;
    [self setFlairDisplay:YES];
    [self resetButtonsSource:sender];    
    [self setDayDateLabelText];
    [self loadData];
}
- (IBAction) doAfterButtonAction:(id)sender
{
    _selectedDay = 4;
    [self setFlairDisplay:NO];
    [self resetButtonsSource:sender];
    [self setDayDateLabelText];
    [self loadData];
}

-(void) setFlairDisplay:(BOOL)show
{
    if(show)
    {
        [[self flairView] setHidden:NO];
        [[super myTable] setFrame:CGRectMake(0, 59, 320, 308)];
    }
    else {
        [[self flairView] setHidden:YES];
        [[super myTable] setFrame:CGRectMake(0, 38, 320, 329)];
    }
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

@end
