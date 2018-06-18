//
//  WhishListViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 20/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhishListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;
@property(strong,nonatomic) UIWindow *window;
@end
