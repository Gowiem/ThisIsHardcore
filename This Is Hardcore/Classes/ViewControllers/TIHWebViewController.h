//
//  TIHWebViewController.h
//  This Is Hardcore
//
//  Created by Odin on 6/5/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NimbusWebController.h"

@interface TIHWebViewController : NIWebController

@property (strong, nonatomic) NSString *urlAddress;

- (void)updateNavBarDisplay;

@end
