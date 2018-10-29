//
//  AttendeesViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 31/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendeesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
//- (IBAction)skipButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;
- (IBAction)payNowbtn:(id)sender;
@property(strong,nonatomic) UIWindow *window;
@end
