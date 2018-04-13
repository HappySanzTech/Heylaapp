//
//  CCResultViewController.h
//  CCIntegrationKit
//
//  Created by test on 5/16/14.
//  Copyright (c) 2014 Avenues. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *mainView;
- (IBAction)continueBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *continueOtlet;
@property (weak, nonatomic) IBOutlet UILabel *FinalStatus;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *transcationDate;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
//- (IBAction)OKBtn:(id)sender;
//    @property (strong, nonatomic) IBOutlet UILabel *resultLabel;
//    @property (strong, nonatomic) NSString *transStatus;

@property (strong, nonatomic) UIWindow *window;

//@property(strong, nonatomic) UINavigationController *navigationController;

@end
