//
//  LoginViewController.h
//  Heylaapp
//
//  Created by HappySanz on 25/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACFloatingTextField.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate,CLLocationManagerDelegate,MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *signIn;
- (IBAction)signInBtn:(id)sender;
- (IBAction)signUpBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UIButton *signUP;
- (IBAction)forgotPasswordBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *forgotPassword;
- (IBAction)facebookBtn:(id)sender;

- (IBAction)viewOneCheckBoxBtn:(id)sender;

- (IBAction)viewTwoSignUpBtn:(id)sender;
- (IBAction)passwordEyeBtn:(id)sender;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *SignUpUserName;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *SignUpMobileNo;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *signUpPassword;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *signInUserName;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *signInPassword;
- (IBAction)signInPaswrdEyeBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *signEyeImageView;
@property (strong, nonatomic) IBOutlet UIImageView *signInImageView;
- (IBAction)googleBtn:(id)sender;
- (IBAction)loginBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *checkBoxBtn;
@property (strong, nonatomic) IBOutlet UIView *signInView;
@property (strong, nonatomic) IBOutlet UIView *signUpView;
@property (strong, nonatomic) IBOutlet UIButton *signUpBtnOtlet;
- (IBAction)guestBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *guest;
@property (strong, nonatomic) IBOutlet UIButton *facebook;
@property (strong, nonatomic) IBOutlet UIButton *google;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewTwo;






@end
