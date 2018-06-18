//
//  BookingHistoryViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 18/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingHistoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) UIWindow *window;

@end
