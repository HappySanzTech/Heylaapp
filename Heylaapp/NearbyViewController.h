//
//  NearbyViewController.h
//  Heylaapp
//
//  Created by Happy Sanz Tech on 02/02/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NearbyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CLLocationManagerDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *nearbyImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *distanceTxtfield;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nearbyOtlet;
- (IBAction)nearbyBtn:(id)sender;

@end
