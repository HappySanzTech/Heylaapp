//
//  SelectCityPageViewController.h
//  Heylaapp
//
//  Created by HappySanz on 13/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SelectCityPageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backBtn:(id)sender;


@end
