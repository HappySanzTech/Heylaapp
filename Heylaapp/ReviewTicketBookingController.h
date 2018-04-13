//
//  ReviewTicketBookingController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 18/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewTicketBookingController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *planAmount;
@property (strong, nonatomic) IBOutlet UILabel *planName;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) IBOutlet UIButton *plus;
- (IBAction)plusButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *minus;
- (IBAction)minusButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *totalTickets;
@property (strong, nonatomic) IBOutlet UILabel *internetFee;
@property (strong, nonatomic) IBOutlet UILabel *cgst;
@property (strong, nonatomic) IBOutlet UILabel *sgst;
@property (strong, nonatomic) IBOutlet UILabel *ticketPrice;
@property (strong, nonatomic) IBOutlet UILabel *totalPrice;
@property (strong, nonatomic) IBOutlet UILabel *emailId;
@property (strong, nonatomic) IBOutlet UILabel *phoneNum;
- (IBAction)payNowButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *ticketCount;
- (IBAction)backButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
@property (strong, nonatomic) IBOutlet UILabel *eventlocation;
@property (strong, nonatomic) IBOutlet UILabel *eventTime;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UITextField *accessCode;
@property (strong, nonatomic) IBOutlet UITextField *merchantId;
@property (strong, nonatomic) IBOutlet UITextField *currency;
@property (strong, nonatomic) IBOutlet UITextField *amount;
@property (strong, nonatomic) IBOutlet UITextField *orderId;
@property (strong, nonatomic) IBOutlet UITextField *redirectUrl;
@property (strong, nonatomic) IBOutlet UITextField *cancelUrl;
@property (strong, nonatomic) IBOutlet UITextField *rsaKeyUrl;
@end
