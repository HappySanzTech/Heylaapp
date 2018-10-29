//
//  OTPViewController.m
//  Heylaapp
//
//  Created by HappySanz on 27/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "OTPViewController.h"

@interface OTPViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation OTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        
    _confirm.layer.cornerRadius = 8;
    _confirm.clipsToBounds = YES;
    
    _changeNumber.layer.cornerRadius = 8;
    _changeNumber.clipsToBounds = YES;
    
    
    _textfiledOne.delegate = self;
    _textfiledTwo.delegate = self;
    _textfiledThree.delegate = self;;
    _textfieldFour.delegate = self;
    
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"from_otp"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"signOut" forKey:@"status"];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
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

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSUInteger newLength = newString.length;

    if (textField == self.textfiledOne)
    {
        if (newLength == 1) {
            [_textfiledOne setText:newString];
            [_textfiledTwo becomeFirstResponder];
            return NO; // NO because we already updated the text.
        }
    }

    if (textField == self.textfiledTwo)
    {
        if (newLength == 1)
        {
            [_textfiledTwo setText:newString];
            [_textfiledThree becomeFirstResponder];
            return NO;
        }
    }

    if (textField == self.textfiledThree)
    {
        if (newLength == 1)
        {
            [_textfiledThree setText:newString];
            [_textfieldFour becomeFirstResponder];
            return NO;
        }
    }

    if (textField == self.textfieldFour)
    {
        if (newLength == 1)
        {
            [_textfieldFour setText:newString];
            [_textfieldFour resignFirstResponder];
            return NO;
        }
    }

    return YES;
}
-(BOOL)keyboardInputShouldDelete:(UITextField *)textField
{
    if (textField == self.textfiledOne)
    {
        self.textfiledOne.text = @"";
        [_textfiledOne becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfiledTwo)
    {
        self.textfiledOne.text = @"";
        [_textfiledOne becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfiledThree)
    {
        self.textfiledTwo.text = @"";
        [_textfiledTwo becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfieldFour)
    {
        self.textfiledThree.text = @"";
        [_textfiledThree becomeFirstResponder];
        return NO;
    }
    return YES;
}
- (IBAction)resendBtn:(id)sender
{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSString *otp = [NSString stringWithFormat:@"%@%@%@%@",self.textfiledOne.text,self.textfiledTwo.text,self.textfiledThree.text,self.textfieldFour.text];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.mobileNumber forKey:@"mobile_no"];
        [parameters setObject:otp forKey:@"OTP"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString *resendOTP = @"apimain/resendOTP";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,resendOTP, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             
             if ([msg isEqualToString:@"Verification Successfully"] && [status isEqualToString:@"Success"])
             {
                 
                 
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

- (IBAction)confirmBtn:(id)sender
{
    if ([self.textfiledOne.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"cannot be empty"
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
    else if ([self.textfiledTwo.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"cannot be empty"
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
    else if ([self.textfiledThree.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"cannot be empty"
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
    else if ([self.textfieldFour .text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"cannot be empty"
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
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *otp = [NSString stringWithFormat:@"%@%@%@%@",self.textfiledOne.text,self.textfiledTwo.text,self.textfiledThree.text,self.textfieldFour.text];

            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.mobileNumber forKey:@"mobile_no"];
            [parameters setObject:otp forKey:@"OTP"];

            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

            NSString *mobileverify = @"apimain/mobileVerify";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,mobileverify, nil];
            NSString *api = [NSString pathWithComponents:components];
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {

                 NSLog(@"%@",responseObject);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSString *status = [responseObject objectForKey:@"status"];

                 if ([msg isEqualToString:@"Verification Successfully"] && [status isEqualToString:@"Success"])
                 {
                     self->appDel.user_Id = [responseObject objectForKey:@"user_id"];
                     [[NSUserDefaults standardUserDefaults]setObject:self->appDel.user_Id forKey:@"stat_user_id"];
                     NSLog(@"%@",self->appDel.user_Id);

                     NSString *View = [[NSUserDefaults standardUserDefaults]objectForKey:@"view_key"];

                     if ([View isEqualToString:@"fotgot_passord"])
                     {
                         [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"view_key"];
                         [self performSegueWithIdentifier:@"to_confirmPasword" sender:self];

                     }
                     else
                     {
                         [self performSegueWithIdentifier:@"to_profile" sender:self];
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
- (IBAction)changeNumberBtn:(id)sender
{
    [self performSegueWithIdentifier:@"to_changeNumber" sender:self];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
-(void)dismissKeyboard
{
    [_textfiledOne resignFirstResponder];
    [_textfiledTwo resignFirstResponder];
    [_textfiledThree resignFirstResponder];
    [_textfieldFour resignFirstResponder];

}
@end
