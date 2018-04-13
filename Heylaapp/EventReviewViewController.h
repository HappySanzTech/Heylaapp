//
//  EventReviewViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 19/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventReviewViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)plusBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *plus;

@end
