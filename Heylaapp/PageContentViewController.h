//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by abc on 18/02/15.
//  Copyright (c) 2015 com.TheAppGuruz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController<UIScrollViewDelegate>

@property  NSUInteger pageIndex;
@property  NSString *imgFile;
@property (weak, nonatomic) IBOutlet UIImageView *ivScreenImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
