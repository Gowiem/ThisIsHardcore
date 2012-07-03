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
    UIButton *leftButton;
    UIImage *leftButtonImage;
    UIImage *leftButtonHighlightedImage;

    UIButton *leftCenterButton;
    UIImage *leftCenterButtonImage;
    UIImage *leftCenterButtonHighlightedImage;

    UIButton *centerButton;
    UIImage *centerButtonImage;
    UIImage *centerButtonHighlightedImage;
        
    UIButton *rightCenterButton;
    UIImage *rightCenterButtonImage;
    UIImage *rightCenterButtonHighlightedImage;
        
    UIButton *rightButton;
    UIImage *rightButtonImage;
    UIImage *rightButtonHighlightedImage;

}

/* Create a custom UIButton and add it to the center of our tab bar */

- (void)addLeftButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage;

- (void)addLeftCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage;

- (void)addCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage;

- (void)addRightCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage;

- (void)addRightButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage;
@end
