//
//  TIHBaseDataModel.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 5/29/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TIHBaseDataModel : NSObject {

    NSDictionary *_properties;
}

@property (strong, nonatomic) NSDictionary *properties;

- (id)initWithProperties:(NSDictionary *)properties;

@end
