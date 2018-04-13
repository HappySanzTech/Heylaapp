//
//  ForgotPasswordViewController.m
//  Heylaapp
//
//  Created by HappySanz on 17/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ACFloatingTextField.h"

@interface ForgotPasswordViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    _send.layer.cornerRadius = 8;
    _send.clipsToBounds = YES;
    
    _emailTextfiled.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
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
- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.bottom = keyboardRect.size.height;
    self.scrollView.contentInset = contentInset;
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
}
- (IBAction)sendBtn:(id)sender
{
    if ([self.emailTextfiled.text isEqualToString:@""])
    {
        [_emailTextfiled showErrorWithText:@"Enter email address"];
    }
    else
    {
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDel.mobileNumber = self.emailTextfiled.text;
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:self.emailTextfiled.text forKey:@"username"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString *forgotPassword = @"apimain/forgotPassword";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,forgotPassword, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             
             if ([msg isEqualToString:@"Forgot Password"] && [status isEqualToString:@"success"])
             {
                 NSString *type = [responseObject objectForKey:@"type"];
                 
                 if ([type isEqualToString:@"Email"])
                 {
                     [[NSUserDefaults standardUserDefaults]setObject:self.emailTextfiled.text forKey:@"statemail_id"];
                     LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                     [self presentViewController:loginViewController animated:NO completion:nil];

                 }
                 else
                 {
                     [[NSUserDefaults standardUserDefaults]setObject:self.emailTextfiled.text forKey:@"statemobile_no"];
                     ForgotPasswordOTPViewController *forgotPasswordOTPViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordOTPViewController"];
                     [self presentViewController:forgotPasswordOTPViewController animated:NO completion:nil];
                 }
                 
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

- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.emailTextfiled)
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}
-(void)dismissKeyboard
{
    [_emailTextfiled resignFirstResponder];

}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
