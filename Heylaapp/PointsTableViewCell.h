//
//  PointsTableViewCell.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 03/09/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userRank;
@property (weak, nonatomic) IBOutlet UILabel *userPoints;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
