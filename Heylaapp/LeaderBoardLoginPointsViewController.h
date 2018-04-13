//
//  LeaderBoardLoginPointsViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 20/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardLoginPointsViewController : UIViewController
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *dailyPointsView;
@property (weak, nonatomic) IBOutlet UILabel *totalLoginPoints;
@property (weak, nonatomic) IBOutlet UIImageView *dateOneImgView;
@property (weak, nonatomic) IBOutlet UIImageView *dateTwoImgView;
@property (weak, nonatomic) IBOutlet UIImageView *dateThreeImgView;
@property (weak, nonatomic) IBOutlet UIImageView *dateFourImgView;
@property (weak, nonatomic) IBOutlet UIImageView *dateFiveimgView;
@property (weak, nonatomic) IBOutlet UILabel *dateOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateFourLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateFiveLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dateOneStarImg;
@property (weak, nonatomic) IBOutlet UIImageView *dateTwoStarImg;
@property (weak, nonatomic) IBOutlet UIImageView *dateThreeStarImg;
@property (weak, nonatomic) IBOutlet UIImageView *dateFourStarImg;
@property (weak, nonatomic) IBOutlet UIImageView *dateFiveStarImg;

@end
