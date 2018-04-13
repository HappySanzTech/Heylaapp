//
//  ConfirmPasswordViewController.h
//  Heylaapp
//
//  Created by HappySanz on 17/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"

@interface ConfirmPasswordViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *eye;
- (IBAction)eyeBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *submit;
- (IBAction)submitBtn:(id)sender;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *newpassword;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
