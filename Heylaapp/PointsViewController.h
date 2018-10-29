//
//  PointsViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 03/09/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
