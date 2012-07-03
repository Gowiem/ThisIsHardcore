//
//  TIHTabBarController.h
//  This Is Hardcore
//
//  Created by Kevin Clough on 7/3/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TIHTabBarController : UITabBarController
{
    UIButton *centerButton;
    UIImage *centerButtonImage;
    UIImage *centerButtonHighlightedImage;
    
    UIButton *leftCenterButton;
    UIImage *leftCenterButtonImage;
    UIImage *leftCenterButtonHighlightedImage;
    
    UIButton *rightCenterButton;
    UIImage *rightCenterButtonImage;
    UIImage *rightCenterButtonHighlightedImage;

}

/* Create a custom UIButton and add it to the center of our tab bar */
- (void)addCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage;

- (void)addLeftCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage;

- (void)addRightCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage;

@end
