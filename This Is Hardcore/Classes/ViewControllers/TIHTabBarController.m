//
//  TIHTabBarController.m
//  This Is Hardcore
//
//  Created by Kevin Clough on 7/3/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
// WARNING: Code defecit ahead
// This code could benefit from refactoring!
//

#import "TIHTabBarController.h"

@interface TIHTabBarController ()

@end

@implementation TIHTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"TIHTabBarController Loaded");
    [self addCenterButtonWithImage:[UIImage imageNamed:@"schedule_off.png"] highlightImage:[UIImage imageNamed: @"schedule_on.png"]];
    [self addLeftCenterButtonWithImage:[UIImage imageNamed:@"bookmarks_off.png"] highlightImage:[UIImage imageNamed: @"bookmarks_on.png"]];
    [self addRightCenterButtonWithImage:[UIImage imageNamed:@"photopit_off.png"] highlightImage:[UIImage imageNamed: @"photopit_on.png"]];
}
/* Create a custom UIButton and add it to the center of our tab bar */
- (void)addCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage
{
    [centerButton removeFromSuperview];
    centerButtonImage = buttonImage;
    centerButtonHighlightedImage = highlightImage;
    centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    centerButton.adjustsImageWhenHighlighted = NO;
    centerButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    centerButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [centerButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [centerButton setBackgroundImage:highlightImage forState:UIControlStateSelected];
    
    [centerButton addTarget:self action:@selector(setCenterButtonHighlighted:) forControlEvents:UIControlEventTouchDown];
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if(heightDifference < 0)
    {
        centerButton.center = self.tabBar.center;
    }
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        centerButton.center = center;
    }
    
    [self.view addSubview:centerButton];
}

/* Create a custom UIButton and add it to the left-center of our tab bar */
- (void)addLeftCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage
{
    [leftCenterButton removeFromSuperview];
    leftCenterButtonImage = buttonImage;
    leftCenterButtonHighlightedImage = highlightImage;
    leftCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftCenterButton.adjustsImageWhenHighlighted = NO;
    leftCenterButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    leftCenterButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [leftCenterButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [leftCenterButton setBackgroundImage:highlightImage forState:UIControlStateSelected];
    
    [leftCenterButton addTarget:self action:@selector(setLeftCenterButtonHighlighted:) forControlEvents:UIControlEventTouchDown];
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if(heightDifference < 0)
    {
        leftCenterButton.center = CGPointMake(self.tabBar.center.x - buttonImage.size.width, self.tabBar.center.y);
    }
    else
    {
        leftCenterButton.center = CGPointMake(self.tabBar.center.x - buttonImage.size.width, self.tabBar.center.y - heightDifference/2.0);;
    }
    
    [self.view addSubview:leftCenterButton];
}

- (void)addRightCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage
{
    [rightCenterButton removeFromSuperview];
    rightCenterButtonImage = buttonImage;
    rightCenterButtonHighlightedImage = highlightImage;
    rightCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightCenterButton.adjustsImageWhenHighlighted = NO;
    rightCenterButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    rightCenterButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [rightCenterButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [rightCenterButton setBackgroundImage:highlightImage forState:UIControlStateSelected];
    
    [rightCenterButton addTarget:self action:@selector(setRightCenterButtonHighlighted:) forControlEvents:UIControlEventTouchDown];
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if(heightDifference < 0)
    {
        rightCenterButton.center = CGPointMake(self.tabBar.center.x + buttonImage.size.width, self.tabBar.center.y);
    }
    else
    {
        rightCenterButton.center = CGPointMake(self.tabBar.center.x + buttonImage.size.width, self.tabBar.center.y - heightDifference/2.0);;
    }
    
    [self.view addSubview:rightCenterButton];
}


- (void)setCenterButtonHighlighted:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    [leftCenterButton setSelected:NO];
    [rightCenterButton setSelected:NO];
    self.selectedIndex = 2;
}

- (void)setLeftCenterButtonHighlighted:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    [centerButton setSelected:NO];
    [rightCenterButton setSelected:NO];
    self.selectedIndex = 1;
}

- (void)setRightCenterButtonHighlighted:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    [leftCenterButton setSelected:NO];
    [centerButton setSelected:NO];
    self.selectedIndex = 3;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [leftCenterButton setSelected:NO];
    [centerButton setSelected:NO];
    [rightCenterButton setSelected:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
