//
//  ForgotPasswordViewController.h
//  Heylaapp
//
//  Created by HappySanz on 17/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"

@interface ForgotPasswordViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *send;
- (IBAction)sendBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *emailTextfiled;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
