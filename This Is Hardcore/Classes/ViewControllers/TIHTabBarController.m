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
    [self addLeftButtonWithImage:[UIImage imageNamed:@"news_off.png"] highlightImage:[UIImage imageNamed:@"news_on.png"]];
    [self addLeftCenterButtonWithImage:[UIImage imageNamed:@"bookmarks_off.png"] highlightImage:[UIImage imageNamed: @"bookmarks_on.png"]];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"schedule_off.png"] highlightImage:[UIImage imageNamed: @"schedule_on.png"]];
    [self addRightCenterButtonWithImage:[UIImage imageNamed:@"photopit_off.png"] highlightImage:[UIImage imageNamed: @"photopit_on.png"]];
    [self addRightButtonWithImage:[UIImage imageNamed:@"more_off.png"] highlightImage:[UIImage imageNamed:@"more_on.png"]];
    self.selectedIndex = 0;
    [self setLeftButtonHighlighted:leftButton];
}

- (void)addLeftButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage
{
    [leftButton removeFromSuperview];
    leftButtonImage = buttonImage;
    leftButtonHighlightedImage = highlightImage;
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.adjustsImageWhenHighlighted = NO;
    leftButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    leftButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [leftButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [leftButton setBackgroundImage:highlightImage forState:UIControlStateSelected];
    
    [leftButton addTarget:self action:@selector(setLeftButtonHighlighted:) forControlEvents:UIControlEventTouchDown];
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if(heightDifference < 0)
    {
        leftButton.center = CGPointMake(self.tabBar.center.x - (buttonImage.size.width * 2), self.tabBar.center.y);
    }
    else
    {
        leftButton.center = CGPointMake(self.tabBar.center.x - (buttonImage.size.width * 2), self.tabBar.center.y - heightDifference/2.0);;
    }
    
    [self.view addSubview:leftButton];
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

- (void)addRightButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage
{
    [rightButton removeFromSuperview];
    rightButtonImage = buttonImage;
    rightButtonHighlightedImage = highlightImage;
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.adjustsImageWhenHighlighted = NO;
    rightButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    rightButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [rightButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [rightButton setBackgroundImage:highlightImage forState:UIControlStateSelected];
    
    [rightButton addTarget:self action:@selector(setRightButtonHighlighted:) forControlEvents:UIControlEventTouchDown];
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if(heightDifference < 0)
    {
        rightButton.center = CGPointMake(self.tabBar.center.x + (buttonImage.size.width * 2), self.tabBar.center.y);
    }
    else
    {
        rightButton.center = CGPointMake(self.tabBar.center.x + (buttonImage.size.width * 2), self.tabBar.center.y - heightDifference/2.0);;
    }
    
    [self.view addSubview:rightButton];
}

- (void)setLeftButtonHighlighted:(id)sender
{
    [self resetButtons];
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    self.selectedIndex = 0;
}

- (void)setLeftCenterButtonHighlighted:(id)sender
{
    [self resetButtons];
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    self.selectedIndex = 1;
}

- (void)setCenterButtonHighlighted:(id)sender
{
    [self resetButtons];
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    self.selectedIndex = 2;
}

- (void)setRightCenterButtonHighlighted:(id)sender
{
    [self resetButtons];
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    self.selectedIndex = 3;
}

- (void)setRightButtonHighlighted:(id)sender
{
    [self resetButtons];
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    self.selectedIndex = 4;
}

- (void)resetButtons
{
    [leftButton setSelected:NO];
    [leftCenterButton setSelected:NO];
    [centerButton setSelected:NO];
    [rightCenterButton setSelected:NO];
    [rightButton setSelected:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
