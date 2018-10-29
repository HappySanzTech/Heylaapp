//
//  EventDetailViewController.h
//  Heylaapp
//
//  Created by HappySanz on 27/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface EventDetailViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationManager *objLocationManager;
    double latitude_UserLocation, longitude_UserLocation;
}
@property (weak, nonatomic) IBOutlet UIButton *report_Otlet;
- (IBAction)report_Btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *reviewDownView;
@property (weak, nonatomic) IBOutlet UIButton *reviewmoreButnOtlet;
@property (weak, nonatomic) IBOutlet UILabel *reviewTitleLabel;
- (IBAction)writeReviewButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *writeReviewOutlet;
@property (weak, nonatomic) IBOutlet UIButton *bookTicketOutlet;
@property (weak, nonatomic) IBOutlet UIButton *checkInOutlet;
@property (weak, nonatomic) IBOutlet UIView *bseView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
- (IBAction)moreButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *reviewComments;
@property (weak, nonatomic) IBOutlet UILabel *reviewNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starImageFive;
@property (weak, nonatomic) IBOutlet UIImageView *starImageFour;
@property (weak, nonatomic) IBOutlet UIImageView *starImageThree;
@property (weak, nonatomic) IBOutlet UIImageView *starImageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *starImageOne;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *adressLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITextView *despTextView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *mobileNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
- (IBAction)checkBtn:(id)sender;
- (IBAction)bookNowBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
- (IBAction)mapViewBtn:(id)sender;
- (IBAction)shareBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *organiserName;
@property (weak, nonatomic) IBOutlet UILabel *poularityCount;
- (IBAction)reviewBtn:(id)sender;
- (IBAction)imageViewBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *dateImage;
@end
