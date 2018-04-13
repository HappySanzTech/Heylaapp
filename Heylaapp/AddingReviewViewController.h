//
//  AddingReviewViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 19/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddingReviewViewController : UIViewController<UITextFieldDelegate>
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *firstStar;
- (IBAction)firstStarBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *secondStar;
- (IBAction)secondStarBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *thiredStar;
- (IBAction)thiredStarBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *fourthStar;
- (IBAction)fourthStarBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *fivethStar;
- (IBAction)fivethStarBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *commentTxtfiled;
@property (weak, nonatomic) IBOutlet UIButton *submit;
- (IBAction)submitBtn:(id)sender;

@end
