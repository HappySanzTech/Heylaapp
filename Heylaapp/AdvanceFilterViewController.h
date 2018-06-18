//
//  AdvanceFilterViewController.h
//  Heylaapp
//
//  Created by HappySanz on 28/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvanceFilterViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *sliderSelectedValue;
- (IBAction)sliderButton:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (strong, nonatomic) IBOutlet UIView *viewDate;
@property (strong, nonatomic) IBOutlet UITextField *dateTextFiled;
- (IBAction)searchBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancel;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *today;
- (IBAction)todayBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *tommorow;
- (IBAction)tomorrowBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *eventType;
@property (strong, nonatomic) IBOutlet UITextField *eventCategoery;
@property (strong, nonatomic) IBOutlet UITextField *eventPreference;
@property (strong, nonatomic) IBOutlet UITextField *eventCity;
@property (strong, nonatomic) IBOutlet UITextField *fromDate;
@property (strong, nonatomic) IBOutlet UITextField *toDate;
- (IBAction)cancelBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *search;
@end
