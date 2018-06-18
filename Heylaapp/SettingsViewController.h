//
//  SettingsViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 30/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;
@end
