//
//  ForgotPasswordOTPViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 12/02/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ForgotPasswordOTPViewController.h"

@interface ForgotPasswordOTPViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation ForgotPasswordOTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _confirmOtlet.layer.cornerRadius = 8;
    _confirmOtlet.clipsToBounds = YES;
    
    [[NSUserDefaults standardUserDefaults]setObject:@"signOut" forKey:@"status"];
    
    _textfieldOne.delegate = self;
    _textfieldTwo.delegate = self;
    _textfiledThree.delegate = self;;
    _textfiledFour.delegate = self;
    
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
    
    if (textField == self.textfieldOne)
    {
        if (newLength == 1) {
            [_textfieldOne setText:newString];
            [_textfieldTwo becomeFirstResponder];
            return NO; // NO because we already updated the text.
        }
    }
    
    if (textField == self.textfieldTwo)
    {
        if (newLength == 1)
        {
            [_textfieldTwo setText:newString];
            [_textfiledThree becomeFirstResponder];
            return NO;
        }
    }
    
    if (textField == self.textfiledThree)
    {
        if (newLength == 1)
        {
            [_textfiledThree setText:newString];
            [_textfiledFour becomeFirstResponder];
            return NO;
        }
    }
    
    if (textField == self.textfiledFour)
    {
        if (newLength == 1)
        {
            [_textfiledFour setText:newString];
            [_textfiledFour resignFirstResponder];
            return NO;
        }
    }
    
    return YES;
}
-(BOOL)keyboardInputShouldDelete:(UITextField *)textField
{
    if (textField == self.textfieldOne)
    {
        self.textfieldOne.text = @"";
        [_textfieldOne becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfieldTwo)
    {
        self.textfieldOne.text = @"";
        [_textfieldOne becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfiledThree)
    {
        self.textfieldTwo.text = @"";
        [_textfieldTwo becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfiledFour)
    {
        self.textfiledThree.text = @"";
        [_textfiledThree becomeFirstResponder];
        return NO;
    }
    return YES;
}
- (IBAction)confirmBtn:(id)sender
{
    if ([self.textfieldOne.text isEqualToString:@""])
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
    else if ([self.textfieldTwo.text isEqualToString:@""])
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
    else if ([self.textfiledFour .text isEqualToString:@""])
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
        NSString *otp = [NSString stringWithFormat:@"%@%@%@%@",self.textfieldOne.text,self.textfieldTwo.text,self.textfiledThree.text,self.textfiledFour.text];
        
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
                 NSLog(@"%@",self->appDel.user_Id);
                 
                 
                     [self performSegueWithIdentifier:@"to_passwordPage" sender:self];
                     
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

- (IBAction)resendBtn:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *otp = [NSString stringWithFormat:@"%@%@%@%@",self.textfieldOne.text,self.textfieldTwo.text,self.textfiledThree.text,self.textfiledFour.text];
    
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
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
-(void)dismissKeyboard
{
    [_textfieldOne resignFirstResponder];
    [_textfieldTwo resignFirstResponder];
    [_textfiledThree resignFirstResponder];
    [_textfiledFour resignFirstResponder];
    
}
@end
