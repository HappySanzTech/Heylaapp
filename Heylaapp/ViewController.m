//
//  ViewController.m
//  Heylaapp
//
//  Created by HappySanz on 23/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[NSUserDefaults standardUserDefaults]setObject:@"hide" forKey:@"showSplash"];
    
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)swipeleft:(UIGestureRecognizer *) sender
{
    ViewTwoController *viewTwoController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewTwoController"];
    [self presentViewController:viewTwoController animated:NO completion:nil];
    
    UINavigationController *navigationController = [[UINavigationController       alloc]initWithRootViewController:viewTwoController];
    [self.navigationController pushViewController:navigationController animated:YES];
}

- (IBAction)skipBtn:(id)sender
{
    LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginViewController animated:NO completion:nil];
    
    UINavigationController *navigationController = [[UINavigationController       alloc]initWithRootViewController:loginViewController];
    [self.navigationController pushViewController:navigationController animated:YES];

}

- (IBAction)nextBtn:(id)sender
{
    ViewTwoController *viewTwoController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewTwoController"];
    [self presentViewController:viewTwoController animated:NO completion:nil];
    
    UINavigationController *navigationController = [[UINavigationController       alloc]initWithRootViewController:viewTwoController];
    [self.navigationController pushViewController:navigationController animated:YES];
}
@end
