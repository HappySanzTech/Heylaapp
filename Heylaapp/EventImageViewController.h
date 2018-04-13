//
//  EventImageViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 26/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface EventImageViewController : UIViewController<UIPageViewControllerDataSource>
@property (nonatomic,strong) UIPageViewController *PageViewController;


- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index;

- (IBAction)backBtn:(id)sender;

@end
