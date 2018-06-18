//
//  ReviewTicketBookingController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 18/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewTicketBookingController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UILabel *totalTickets;
@property (strong, nonatomic) IBOutlet UILabel *internetFee;
@property (strong, nonatomic) IBOutlet UILabel *cgst;
@property (strong, nonatomic) IBOutlet UILabel *sgst;
@property (strong, nonatomic) IBOutlet UILabel *ticketPrice;
@property (strong, nonatomic) IBOutlet UILabel *totalPrice;
- (IBAction)payNowButton:(id)sender;
- (IBAction)backButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
@property (strong, nonatomic) IBOutlet UILabel *eventlocation;
@property (strong, nonatomic) IBOutlet UILabel *eventTime;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *eventdate;

@property (strong, nonatomic) IBOutlet UITextField *accessCode;
@property (strong, nonatomic) IBOutlet UITextField *merchantId;
@property (strong, nonatomic) IBOutlet UITextField *currency;
@property (strong, nonatomic) IBOutlet UITextField *amount;
@property (strong, nonatomic) IBOutlet UITextField *orderId;
@property (strong, nonatomic) IBOutlet UITextField *redirectUrl;
@property (strong, nonatomic) IBOutlet UITextField *cancelUrl;
@property (strong, nonatomic) IBOutlet UITextField *rsaKeyUrl;
@end
