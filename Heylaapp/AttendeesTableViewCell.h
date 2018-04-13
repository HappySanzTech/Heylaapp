//
//  AttendeesTableViewCell.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 31/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendeesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *mobNum;

@end
