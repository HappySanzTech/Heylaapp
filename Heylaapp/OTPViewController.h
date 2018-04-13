//
//  OTPViewController.h
//  Heylaapp
//
//  Created by HappySanz on 27/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeNumberViewController.h"

@interface OTPViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textfiledOne;
@property (strong, nonatomic) IBOutlet UITextField *textfiledTwo;
@property (strong, nonatomic) IBOutlet UITextField *textfiledThree;
@property (strong, nonatomic) IBOutlet UITextField *textfieldFour;
- (IBAction)resendBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *confirm;
- (IBAction)confirmBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *changeNumber;
- (IBAction)changeNumberBtn:(id)sender;
@end
