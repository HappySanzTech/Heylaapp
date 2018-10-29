//
//  HomeViewController.h
//  Heylaapp
//
//  Created by HappySanz on 19/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AdvanceFilterViewController.h"

@interface HomeViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,MKMapViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate,UIScrollViewDelegate>
{
    NSArray *searchResultsArray;
}
@property (weak, nonatomic) IBOutlet UIView *lb_bookingView;
@property (weak, nonatomic) IBOutlet UIView *lb_reviewView;
@property (weak, nonatomic) IBOutlet UIView *lb_checkinView;
@property (weak, nonatomic) IBOutlet UIView *lb_total_points;
@property (weak, nonatomic) IBOutlet UIView *lb_fstView;
@property (weak, nonatomic) IBOutlet UIView *segBaseView;
- (IBAction)pointsButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *pointsOutlet;
@property (weak, nonatomic) IBOutlet UIView *mainView_tv;
- (IBAction)leaderBoardProfileBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bookingView;
@property (weak, nonatomic) IBOutlet UIView *reviewView;
@property (weak, nonatomic) IBOutlet UIView *checkInView;
@property (weak, nonatomic) IBOutlet UIView *eventShareView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
- (IBAction)daySegmentButton:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *daySegment;
- (IBAction)profileButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
- (IBAction)leaderBoardReviewBtn:(id)sender;
- (IBAction)leaderbookingBtn:(id)sender;
- (IBAction)leaderBoardCheckInBtn:(id)sender;
- (IBAction)leaderBoardeventShareBtn:(id)sender;
- (IBAction)leaderBoardLoginBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *leaderBoardLoginOtlet;
@property (weak, nonatomic) IBOutlet UIImageView *LeaderBoardimageView;
@property (strong, nonatomic) IBOutlet UIButton *floating;
- (IBAction)floatibgBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *search;
- (IBAction)searchBtn:(id)sender;
@property (nonatomic, strong)NSMutableArray *eventArray;
@property (nonatomic, strong)NSMutableArray *filterdItems;
- (IBAction)advanceFilterBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *advanceFilter;
@property (strong, nonatomic) IBOutlet UIView *leaderBoardView;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *bookingCount;
@property (strong, nonatomic) IBOutlet UILabel *reminderCount;
@property (strong, nonatomic) IBOutlet UILabel *checkInCount;
@property (strong, nonatomic) IBOutlet UILabel *eventShareCount;
@property (strong, nonatomic) IBOutlet UILabel *loginCount;
@property (strong, nonatomic) IBOutlet UILabel *totalPoints;
@property (strong, nonatomic) UIWindow *window;

-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;
@end
