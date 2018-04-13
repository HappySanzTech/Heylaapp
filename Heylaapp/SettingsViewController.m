//
//  SettingsViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 30/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

}

- (void)didReceiveMemoryWarning {
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

- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editProfBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProfileViewController *profile = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self presentViewController:profile animated:YES completion:nil];
}

- (IBAction)changeNumBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChangeNumberViewController *changeNumberViewController = [storyboard instantiateViewControllerWithIdentifier:@"ChangeNumberViewController"];
    [self.navigationController pushViewController:changeNumberViewController animated:YES];
}

- (IBAction)chNgePaswrdBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ForgotPasswordViewController *forgotPasswordViewController = [storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    [self.navigationController pushViewController:forgotPasswordViewController animated:YES];
}

- (IBAction)verifyMailBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProfileViewController *profile = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self presentViewController:profile animated:YES completion:nil];
}
@end
