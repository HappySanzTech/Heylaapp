//
//  BookingViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 17/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UILabel *minusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *planUmgView;
- (IBAction)plusBtn:(id)sender;
- (IBAction)minusBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *plusOutlet;
@property (weak, nonatomic) IBOutlet UIButton *minusOulet;
@property (weak, nonatomic) IBOutlet UITextField *countText;
@property (weak, nonatomic) IBOutlet UITextField *eventPlan;
- (IBAction)amountBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *amountOutlet;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *timeImageView;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *eventLocation;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *eventDate;
@property (strong, nonatomic) IBOutlet UITextField *eventTime;
@end
