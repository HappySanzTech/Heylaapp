//
//  SideMenuTableViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 30/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuTableViewController : UIViewController
- (IBAction)profileImageButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
