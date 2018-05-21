//
//  ConfirmPasswordViewController.m
//  Heylaapp
//
//  Created by HappySanz on 17/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ConfirmPasswordViewController.h"

@interface ConfirmPasswordViewController ()
{
    AppDelegate *appDel;
    NSString *eyeFlag;
}
@end

@implementation ConfirmPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    _submit.layer.cornerRadius = 8;
    _submit.clipsToBounds = YES;
    _newpassword.delegate = self;
    eyeFlag = @"0";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
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
- (IBAction)eyeBtn:(id)sender
{
    if ([eyeFlag isEqualToString:@"0"])
    {
        self.imageView.image = [UIImage imageNamed:@"hide.png"];
        eyeFlag = @"1";
        self.newpassword.secureTextEntry = YES;
    }
    else
    {
        self.imageView.image = [UIImage imageNamed:@"unhide.png"];
        eyeFlag = @"0";
        self.newpassword.secureTextEntry = NO;
    }
}
- (IBAction)submitBtn:(id)sender
{ 
    if ([self.newpassword.text isEqualToString:@""])
    {
        [_newpassword showErrorWithText:@"Enter new password"];
    }
    else
    {
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_Id forKey:@"user_id"];
        [parameters setObject:self.newpassword.text forKey:@"password"];

        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString *resetPassword = @"apimain/resetpassword";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,resetPassword, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             
             if ([msg isEqualToString:@"Password Updated"] && [status isEqualToString:@"success"])
             {
                 LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                 [self presentViewController:loginViewController animated:NO completion:nil];
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
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.newpassword)
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}
-(void)dismissKeyboard
{
    [_newpassword resignFirstResponder];
}
@end
