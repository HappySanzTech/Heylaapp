//
//  ChangeNumberViewController.m
//  Heylaapp
//
//  Created by HappySanz on 31/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ChangeNumberViewController.h"

@interface ChangeNumberViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation ChangeNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    _textfieldOne.delegate = self;
    _textfieldTwo.delegate = self;
    _textfieldthree.delegate = self;
    _textfieldFour.delegate = self;
    _textfieldFive.delegate = self;
    _textfieldSix.delegate = self;
    _textfieldSeven.delegate = self;
    _textfieldEight.delegate = self;
    _textfieldNine.delegate = self;
    _textfieldTen.delegate = self;

    _confirm.layer.cornerRadius = 8;
    _confirm.clipsToBounds = YES;

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
        if (newLength == 1) {
            [_textfieldTwo setText:newString];
            [_textfieldthree becomeFirstResponder];
            return NO;
        }
    }
    
    if (textField == self.textfieldthree)
    {
        if (newLength == 1)
        {
            [_textfieldthree setText:newString];
            [_textfieldFour becomeFirstResponder];
            return NO;
        }
    }
    
    if (textField == self.textfieldFour)
    {
        if (newLength == 1)
        {
            [_textfieldFour setText:newString];
            [_textfieldFive becomeFirstResponder];
            return NO;
        }
    }
    
    if (textField == self.textfieldFive)
    {
        if (newLength == 1)
        {
            [_textfieldFive setText:newString];
            [_textfieldSix becomeFirstResponder];
            return NO;
        }
    }
    
    if (textField == self.textfieldSix)
    {
        if (newLength == 1)
        {
            [_textfieldSix setText:newString];
            [_textfieldSeven becomeFirstResponder];
            return NO;
        }
    }
    if (textField == self.textfieldSeven)
    {
        if (newLength == 1)
        {
            [_textfieldSeven setText:newString];
            [_textfieldEight becomeFirstResponder];
            return NO;
        }
    }
    if (textField == self.textfieldEight)
    {
        if (newLength == 1)
        {
            [_textfieldEight setText:newString];
            [_textfieldNine becomeFirstResponder];
            return NO;
        }
    }
    if (textField == self.textfieldNine)
    {
        if (newLength == 1)
        {
            [_textfieldNine setText:newString];
            [_textfieldTen becomeFirstResponder];
            return NO;
        }
    }
    if (textField == self.textfieldTen)
    {
        if (newLength == 1)
        {
            [_textfieldTen setText:newString];
            [_textfieldTen resignFirstResponder];
            return NO;
        }
    }
    return YES;
}-(BOOL)keyboardInputShouldDelete:(UITextField *)textField
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
    if (textField == self.textfieldthree)
    {
        self.textfieldTwo.text = @"";
        [_textfieldTwo becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfieldFour)
    {
        self.textfieldthree.text = @"";
        [_textfieldthree becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfieldFive)
    {
        self.textfieldFour.text = @"";
        [_textfieldFour becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfieldSix)
    {
        self.textfieldFive.text = @"";
        [_textfieldFive becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfieldSeven)
    {
        self.textfieldSix.text = @"";
        [_textfieldSix becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfieldEight)
    {
        self.textfieldSeven.text = @"";
        [_textfieldSeven becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfieldNine)
    {
        self.textfieldEight.text = @"";
        [_textfieldEight becomeFirstResponder];
        return NO;
    }
    if (textField == self.textfieldTen)
    {
        self.textfieldNine.text = @"";
        [_textfieldNine becomeFirstResponder];
        return NO;
    }
    return YES;
}
- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (IBAction)confirmBtn:(id)sender
{
    if ([self.textfieldOne.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"mobile number should be 10 digits"
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
                                   message:@"mobile number should be 10 digits"
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
    else if ([self.textfieldthree.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"mobile number should be 10 digits"
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
    else if ([self.textfieldFour.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"mobile number should be 10 digits"
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
    else if ([self.textfieldFive.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"mobile number should be 10 digits"
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
    else if ([self.textfieldSix.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"mobile number should be 10 digits"
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
    else if ([self.textfieldSeven.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"mobile number should be 10 digits"
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
    else if ([self.textfieldEight.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"mobile number should be 10 digits"
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
    else if ([self.textfieldNine.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"mobile number should be 10 digits"
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
    else if ([self.textfieldTen.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"mobile number should be 10 digits"
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
        NSString *newMobileNumber = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",self.textfieldOne.text,self.textfieldTwo.text,self.textfieldthree.text,self.textfieldFour.text,self.textfieldFive.text,self.textfieldSix.text,self.textfieldSeven.text,self.textfieldEight.text,self.textfieldNine.text,self.textfieldTen.text];
        
        [[NSUserDefaults standardUserDefaults]setObject:newMobileNumber forKey:@"statemobile_no"];

        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.mobileNumber forKey:@"old_mobile_no"];
        [parameters setObject:newMobileNumber forKey:@"new_mobile_no"];

        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString *updateMobile = @"apimain/updatemobile";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,updateMobile, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             self->appDel.mobileNumber = newMobileNumber;

             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             
             if ([msg isEqualToString:@"Mobile Updated Successfully"] && [status isEqualToString:@"Success"])
             {
                 OTPViewController *oTPViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OTPViewController"];
                 [self presentViewController:oTPViewController animated:NO completion:nil];
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
-(void)dismissKeyboard
{
    [_textfieldOne resignFirstResponder];
    [_textfieldTwo resignFirstResponder];
    [_textfieldthree resignFirstResponder];
    [_textfieldFour resignFirstResponder];
    [_textfieldFive resignFirstResponder];
    [_textfieldSix resignFirstResponder];
    [_textfieldSeven resignFirstResponder];
    [_textfieldEight resignFirstResponder];
    [_textfieldNine resignFirstResponder];
    [_textfieldTen resignFirstResponder];

}
@end
