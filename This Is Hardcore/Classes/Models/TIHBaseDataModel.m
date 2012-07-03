//
//  TIHBaseDataModel.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import "TIHBaseDataModel.h"

@implementation TIHBaseDataModel

@synthesize properties = _properties;

- (id)initWithProperties:(NSDictionary *)properties
{
    if((self = [super init]))
    {
        _properties = properties;
    }
    return self;
}

@end

