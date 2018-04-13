//
//  ViewTwoController.m
//  Heylaapp
//
//  Created by HappySanz on 25/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ViewTwoController.h"

@interface ViewTwoController ()

@end

@implementation ViewTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults]setObject:@"hide" forKey:@"showSplash"];
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    ViewThreeController *viewThreeController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewThreeController"];
    [self presentViewController:viewThreeController animated:NO completion:nil];
    
    UINavigationController *navigationController = [[UINavigationController       alloc]initWithRootViewController:viewThreeController];
    [self.navigationController pushViewController:navigationController animated:YES];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:viewController animated:NO completion:nil];
    
    UINavigationController *navigationController = [[UINavigationController       alloc]initWithRootViewController:viewController];
    [self.navigationController pushViewController:navigationController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)skipBtn:(id)sender
{
    LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginViewController animated:NO completion:nil];
    
    UINavigationController *navigationController = [[UINavigationController       alloc]initWithRootViewController:loginViewController];
    [self.navigationController pushViewController:navigationController animated:YES];
}

- (IBAction)nextBtn:(id)sender
{
    ViewThreeController *viewThreeController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewThreeController"];
    [self presentViewController:viewThreeController animated:NO completion:nil];
    
    UINavigationController *navigationController = [[UINavigationController       alloc]initWithRootViewController:viewThreeController];
    [self.navigationController pushViewController:navigationController animated:YES];
}
@end
