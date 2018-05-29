//
//  NavigationController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 29/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "NavigationController.h"
#import "UIViewController+LGSideMenuController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return self.sideMenuController.isRightViewVisible ? UIStatusBarAnimationSlide : UIStatusBarAnimationFade;
}

@end
