//
//  LeaderBoardPointsViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 20/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardPointsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *sideView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
