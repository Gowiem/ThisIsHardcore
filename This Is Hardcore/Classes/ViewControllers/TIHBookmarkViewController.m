//
//  TIHBookmarkViewController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 6/26/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHBookmarkViewController.h"
#import "TIHEventDataModel.h"
#import "TIHEventCell.h"

@implementation TIHBookmarkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super loadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super loadData];
}

-(NSArray*) getBookmarkedDates {
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    for(TIHEventDataModel *m  in [super bookmarkedScheduleItems])
    {
        NSString *eventStartDateDisplay = [m startDateDisplay];
        if(!([dates containsObject: eventStartDateDisplay]))
        {
            [dates addObject: eventStartDateDisplay];
        }
    }
    return dates;
}

-(NSArray*)getBookmarkedEventsByDateDisplay: (NSString*) dateDisplay {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(TIHEventDataModel *item  in [super bookmarkedScheduleItems])
    {
        if([[item startDateDisplay] isEqualToString:dateDisplay])
        {
            [result addObject:item];
        }
    }
    return result;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *bookmarkedDates = [self getBookmarkedDates];
    return [bookmarkedDates count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *bookmarkedDates = [self getBookmarkedDates];
    if([bookmarkedDates count] != 0)
    {
        NSString *dateDisplayForSection = [[self getBookmarkedDates] objectAtIndex: section];
        NSArray *bookMarkedEvents = [self getBookmarkedEventsByDateDisplay:dateDisplayForSection];
        return [bookMarkedEvents count];
    }
    else {
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *bookmarkedDates = [self getBookmarkedDates];
    if([bookmarkedDates count] != 0)
    {
        NSString *dateDisplayForSection = [bookmarkedDates objectAtIndex: section];
        TIHBookmarkScheduleHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"TIHBookmarkScheduleHeaderView" owner:self options:nil] objectAtIndex:0];
        [view setHidden:NO];
        view.sectionLabel.text = dateDisplayForSection;
        return view;
    }
    else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TIHEventCell";
    
    TIHEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TIHEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *dateDisplayForSection = [[self getBookmarkedDates] objectAtIndex:indexPath.section];
    NSArray *events = [self getBookmarkedEventsByDateDisplay:dateDisplayForSection];
    [cell configureWithObject:[events objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *dateDisplayForSection = [[self getBookmarkedDates] objectAtIndex:indexPath.section];
    NSArray *events = [self getBookmarkedEventsByDateDisplay:dateDisplayForSection];
    TIHEventDataModel *modelData = [events objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"segueToEventDetail" sender:modelData];
}

@end
