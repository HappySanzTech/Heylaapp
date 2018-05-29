//
//  MenuViewController.h
//  Heylaapp
//
//  Created by HappySanz on 20/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *shareOutlet;
- (IBAction)signOutBtn:(id)sender;
- (IBAction)settingsBtn:(id)sender;
- (IBAction)notificationBellBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)bookingBtn:(id)sender;
- (IBAction)categoeryBtn:(id)sender;
- (IBAction)changeCityBtn:(id)sender;
- (IBAction)whishListBtn:(id)sender;
- (IBAction)shareBtn:(id)sender;
- (IBAction)aboutUsBtn:(id)sender;
- (IBAction)rateAppBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mainView;
- (IBAction)backBtn:(id)sender;
- (IBAction)profImgBtn:(id)sender;

@end
