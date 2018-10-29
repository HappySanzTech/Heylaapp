//
//  ProfileViewController.h
//  Heylaapp
//
//  Created by HappySanz on 06/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"

@interface ProfileViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,PECropViewControllerDelegate>
{
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backOutlet;
@property (strong, nonatomic) IBOutlet UITextField *genderTexfiled;
- (IBAction)cityBtn:(id)sender;
- (IBAction)stateBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *profImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backBtn:(id)sender;
- (IBAction)imageBTn:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *dobTextFiled;
@property (strong, nonatomic) IBOutlet UITextField *occupation;
@property (strong, nonatomic) IBOutlet UITextField *addressLine;
@property (strong, nonatomic) IBOutlet UITextField *addressLineThree;
@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet UITextField *state;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *pincode;
@property (strong, nonatomic) IBOutlet UIButton *newsLetter;
- (IBAction)newsLetterBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *save;
- (IBAction)saveBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *fullName;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *addressLineTwo;
@property (strong, nonatomic) IBOutlet UIButton *imageBtnOtlet;
@property (strong, nonatomic) UIWindow *window;

@end
