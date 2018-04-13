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
@property (strong, nonatomic) IBOutlet UIButton *favImageOtlet;
@property (strong, nonatomic) IBOutlet UIButton *eyeImageOtlet;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *favouriteImageView;
@property (strong, nonatomic) IBOutlet UIImageView *EyeImageView;
- (IBAction)favImageBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *adressLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITextView *despTextView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *mobileNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
@property (strong, nonatomic) IBOutlet UILabel *facbookLabel;
@property (strong, nonatomic) IBOutlet UILabel *websiteLabel;
- (IBAction)checkBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *check;
- (IBAction)bookNowBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *bookNow;
@property (strong, nonatomic) IBOutlet UIView *viewOne;
@property (strong, nonatomic) IBOutlet UIView *viewTwo;
@property (strong, nonatomic) IBOutlet UIView *viewThree;
@property (strong, nonatomic) IBOutlet UIView *viewFour;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
- (IBAction)mapViewBtn:(id)sender;
- (IBAction)shareBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *organiserName;
@property (weak, nonatomic) IBOutlet UILabel *poularityCount;
- (IBAction)reviewBtn:(id)sender;
- (IBAction)imageViewBtn:(id)sender;

@end
