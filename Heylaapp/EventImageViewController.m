//
//  EventImageViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 26/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "EventImageViewController.h"

@interface EventImageViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *event_banner;
    NSMutableArray *event_id;
    NSMutableArray *gallery_id;

}
@end

@implementation EventImageViewController

@synthesize PageViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    event_banner = [[NSMutableArray alloc]init];
    event_id = [[NSMutableArray alloc]init];
    gallery_id = [[NSMutableArray alloc]init];

    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.event_id forKey:@"event_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *eventImages = @"apimain/eventImages";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,eventImages, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Event Images"] && [status isEqualToString:@"success"])
         {
             NSArray *Eventgallery = [responseObject objectForKey:@"Eventgallery"];
             
             [self->event_banner removeAllObjects];
             [self->event_id removeAllObjects];
             [self->gallery_id removeAllObjects];
             
             for (int i = 0; i < [Eventgallery count]; i++)
             {
                 NSDictionary *dict = [Eventgallery objectAtIndex:i];
                 NSString *strImage = [dict objectForKey:@"event_banner"];
                 NSString *strevent_id = [dict objectForKey:@"event_id"];
                 NSString *strgallery_id = [dict objectForKey:@"gallery_id"];
                 
                 [self->event_banner addObject:strImage];
                 [self->event_id addObject:strevent_id];
                 [self->gallery_id addObject:strgallery_id];

             }
             
             UIPageControl *pageControl = [UIPageControl appearance];
             pageControl.pageIndicatorTintColor = [UIColor whiteColor];
             pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0];
             pageControl.backgroundColor = [UIColor blackColor];
             
             self.PageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
             self.PageViewController.dataSource = self;
             
             PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
             NSArray *viewControllers = @[startingViewController];
             [self.PageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
             
             // Change the size of page view controller
             self.PageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
             
             [self addChildViewController:self->PageViewController];
             [self.view addSubview:self->PageViewController.view];
             [self.PageViewController didMoveToParentViewController:self];
          
         }
         else
         {
             UIAlertController *alert= [UIAlertController
                                        alertControllerWithTitle:@"Heyla"
                                        message:msg
                                        preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction *ok = [UIAlertAction
                                  actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      
                                  }];
             
             [alert addAction:ok];
             [self presentViewController:alert animated:YES completion:nil];
         }
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound)
    {
        return nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
}

#pragma mark - Other Methods
- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
     if (([event_banner count] == 0) || (index >= [event_banner count]))
    {
        return nil;
    }
        PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
        pageContentViewController.imgFile = event_banner[index];
        pageContentViewController.pageIndex = index;
        
        return pageContentViewController;
}

#pragma mark - No of Pages Methods
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [event_banner count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backBtn:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}
@end
