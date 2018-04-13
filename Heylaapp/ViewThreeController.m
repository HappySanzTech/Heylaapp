//
//  ViewThreeController.m
//  Heylaapp
//
//  Created by HappySanz on 25/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ViewThreeController.h"

@interface ViewThreeController ()

@end

@implementation ViewThreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults]setObject:@"hide" forKey:@"showSplash"];

    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    ViewTwoController *viewTwoController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewTwoController"];
    [self presentViewController:viewTwoController animated:NO completion:nil];
    
    UINavigationController *navigationController = [[UINavigationController       alloc]initWithRootViewController:viewTwoController];
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

- (IBAction)diveInBtn:(id)sender
{
    LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginViewController animated:NO completion:nil];
    
    UINavigationController *navigationController = [[UINavigationController       alloc]initWithRootViewController:loginViewController];
    [self.navigationController pushViewController:navigationController animated:YES];
}
@end
