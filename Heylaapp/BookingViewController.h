//
//  BookingViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 17/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *timeImageView;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *eventLocation;
@property (strong, nonatomic) IBOutlet UILabel *eventVenue;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *eventDate;
@property (strong, nonatomic) IBOutlet UITextField *eventTime;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
