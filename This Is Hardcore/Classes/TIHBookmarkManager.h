//
//  TIHBookmarkManager.h
//  This Is Hardcore
//
//  Created by Odin on 6/18/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TIHBookmarkManager : NSObject {
    @private
    NSMutableSet *bookmarks;
}

- (void) resetBookmarks;
- (NSSet *) getBookmarks;
- (void) addBookmarkByEventId: (NSNumber *) eventId;
- (void) removeBookmarkByEventId: (NSNumber *) eventId;

@end
