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

@interface HomeViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,MKMapViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>
{
    NSArray *searchResultsArray;
}
@property (weak, nonatomic) IBOutlet UILabel *fullName;
- (IBAction)leaderBoardReviewBtn:(id)sender;
- (IBAction)leaderbookingBtn:(id)sender;
- (IBAction)leaderBoardCheckInBtn:(id)sender;
- (IBAction)leaderBoardeventShareBtn:(id)sender;
- (IBAction)leaderBoardLoginBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *leaderBoardLoginOtlet;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)menuBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *floating;
- (IBAction)floatibgBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *search;
- (IBAction)searchBtn:(id)sender;
@property (nonatomic, strong)NSMutableArray *eventArray;
@property (nonatomic, strong)NSMutableArray *filterdItems;
- (IBAction)advanceFilterBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *advanceFilter;
@property (strong, nonatomic) IBOutlet UIView *leaderBoardView;
@property (strong, nonatomic) IBOutlet UIView *lbViewOne;
@property (strong, nonatomic) IBOutlet UIView *lbViewTwo;
@property (strong, nonatomic) IBOutlet UIView *lbViewThree;
@property (strong, nonatomic) IBOutlet UIView *lbViewFour;
@property (strong, nonatomic) IBOutlet UIView *lbViewFive;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *bookingPoints;
@property (strong, nonatomic) IBOutlet UILabel *bookingCount;
@property (strong, nonatomic) IBOutlet UILabel *reminderPoints;
@property (strong, nonatomic) IBOutlet UILabel *reminderCount;
@property (strong, nonatomic) IBOutlet UILabel *checkInPoints;
@property (strong, nonatomic) IBOutlet UILabel *checkInCount;
@property (strong, nonatomic) IBOutlet UILabel *eventSharePoints;
@property (strong, nonatomic) IBOutlet UILabel *eventShareCount;
@property (strong, nonatomic) IBOutlet UILabel *loginPoints;
@property (strong, nonatomic) IBOutlet UILabel *loginCount;
@property (strong, nonatomic) IBOutlet UILabel *totalPoints;
@end
