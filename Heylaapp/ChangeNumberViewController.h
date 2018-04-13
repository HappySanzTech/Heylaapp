//
//  ChangeNumberViewController.h
//  Heylaapp
//
//  Created by HappySanz on 31/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeNumberViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textfieldOne;
@property (strong, nonatomic) IBOutlet UITextField *textfieldTwo;
@property (strong, nonatomic) IBOutlet UITextField *textfieldthree;
@property (strong, nonatomic) IBOutlet UITextField *textfieldFour;
@property (strong, nonatomic) IBOutlet UITextField *textfieldFive;
@property (strong, nonatomic) IBOutlet UITextField *textfieldSix;
@property (strong, nonatomic) IBOutlet UITextField *textfieldSeven;
@property (strong, nonatomic) IBOutlet UITextField *textfieldEight;
@property (strong, nonatomic) IBOutlet UITextField *textfieldNine;
@property (strong, nonatomic) IBOutlet UITextField *textfieldTen;
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *confirm;
- (IBAction)confirmBtn:(id)sender;

@end
