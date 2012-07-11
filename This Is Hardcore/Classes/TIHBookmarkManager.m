//
//  TIHBookmarkManager.m
//  This Is Hardcore
//
//  Created by Odin on 6/18/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHBookmarkManager.h"

@implementation TIHBookmarkManager


- (id)init
{
    if((self = [super init]))
    { 
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [defaults objectForKey:@"bookmarks"];
        if (nil != data)
            bookmarks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if(bookmarks == nil)
            bookmarks = [[NSMutableSet alloc] init];
    }
    return self;
}

- (NSSet *) getBookmarks
{
    return bookmarks;
}

- (void) resetBookmarks
{
    [bookmarks removeAllObjects];
    [self saveToDefaults];
}

- (void) addBookmarkByEventId: (NSNumber *) eventId
{
    [bookmarks addObject:eventId];
    [self saveToDefaults];
}

- (void) removeBookmarkByEventId: (NSNumber *) eventId
{
    [bookmarks removeObject:eventId];
    [self saveToDefaults];
}

-(void) saveToDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:bookmarks];
    [defaults setObject:data forKey:@"bookmarks"];
    [defaults synchronize];    
}

@end
