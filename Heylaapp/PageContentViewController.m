//
//  PageContentViewController.m
//  PageViewDemo
//
//  Created by abc on 18/02/15.
//  Copyright (c) 2015 com.TheAppGuruz. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

@synthesize ivScreenImage;
@synthesize pageIndex,imgFile;

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak PageContentViewController *weak = self;
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.imgFile]];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [weak.ivScreenImage setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
     {
         weak.ivScreenImage.image = image;
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
     }
        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error)
    {
         
         NSLog(@"%@",error);
         
     }];
    
    self.scrollView.minimumZoomScale=1.0; //The minimum zoom scale (currently .75x the image size)
    self.scrollView.maximumZoomScale=4.0; //Maximum zoom (currently 4x image size)
    self.scrollView.contentSize=CGSizeMake(self.ivScreenImage.frame.size.width, self.ivScreenImage.frame.size.height);
    self.scrollView.delegate=self;
    self.scrollView.clipsToBounds = YES;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.ivScreenImage; //Needs to be the same as the outlet you created in the .h file
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
