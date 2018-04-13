//
//  ForgotPasswordOTPViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 12/02/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordOTPViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfieldOne;
@property (weak, nonatomic) IBOutlet UITextField *textfieldTwo;
@property (weak, nonatomic) IBOutlet UITextField *textfiledThree;
@property (weak, nonatomic) IBOutlet UITextField *textfiledFour;
@property (weak, nonatomic) IBOutlet UIButton *confirmOtlet;
- (IBAction)confirmBtn:(id)sender;
- (IBAction)resendBtn:(id)sender;

@end
