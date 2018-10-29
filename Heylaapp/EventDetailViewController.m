//
//  EventDetailViewController.m
//  Heylaapp
//
//  Created by HappySanz on 27/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "EventDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface EventDetailViewController ()
{
    AppDelegate *appDel;
    NSString *favImageFlag;
    NSString *eyeImageFlag;
    NSString *reviewCount;
    UIBarButtonItem *wishlistButton;
    
    NSDateFormatter *dateFormatter;
    NSDate *date;
    NSString *reqStartDateString;
    NSString *reqEndDateString;
}
@end

@implementation EventDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    wishlistButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favWhishlist"] style:UIBarButtonItemStylePlain target:self action:@selector(Add:)];
    wishlistButton.width = 20.0;
    self.navigationItem.rightBarButtonItem = wishlistButton;
    
    wishlistButton.tintColor = [UIColor whiteColor];
    self.mainView.layer.cornerRadius = 8.0;
    self.mainView.clipsToBounds = YES;
    self.writeReviewOutlet.layer.cornerRadius = 5.0;
    self.writeReviewOutlet.clipsToBounds = YES;
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self.despTextView setContentOffset:CGPointZero animated:NO];
    NSLog(@"%@",appDel.booking_status);
    if ([appDel.booking_status isEqualToString:@"Y"])
    {
        self.bseView.hidden = NO;
        self.bookTicketOutlet.hidden = NO;
    }
    else
    {
        self.bseView.hidden = YES;
        self.bookTicketOutlet.hidden = YES;
        self.checkInOutlet.frame = CGRectMake(self.checkInOutlet.frame.origin.x,self.checkInOutlet.frame.origin.y,375,self.checkInOutlet.frame.size.height);

    }
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
    __weak typeof(self) weakSelf = self;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:appDel.event_picture]];
    [self.imageView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
     {
         weakSelf.imageView.image = image;
         
     } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
         
         NSLog(@"%@",error);
         
     }];
    self.eventNameLabel.text = appDel.event_Name;
    self.adressLabel.text = appDel.event_Address;
    if ([appDel.event_type isEqualToString:@"Hotspot"])
    {
        self.dateLabel.hidden = YES;
        self.dateImage.hidden = YES;
    }
    else
    {
        self.dateLabel.hidden = NO;
        self.dateImage.hidden = NO;
        
        self->dateFormatter = [[NSDateFormatter alloc] init];
        [self->dateFormatter setDateFormat:@"MMMM dd yyyy"];
        self->date = [[NSDate alloc] init];
        self->date = [self->dateFormatter dateFromString:appDel.event_StartDate];
        // converting into our required date format
        [self->dateFormatter setDateFormat:@"dd-MM-yyyy"];
        self->reqStartDateString = [self->dateFormatter stringFromDate:self->date];
        NSLog(@"date is %@", self->reqStartDateString);
        
        self->dateFormatter = [[NSDateFormatter alloc] init];
        [self->dateFormatter setDateFormat:@"MMMM dd yyyy"];
        self->date = [[NSDate alloc] init];
        self->date = [self->dateFormatter dateFromString:appDel.event_EndDate];
        // converting into our required date format
        [self->dateFormatter setDateFormat:@"dd-MM-yyyy"];
        self->reqEndDateString = [self->dateFormatter stringFromDate:self->date];
        NSLog(@"date is %@",self->reqEndDateString);
        
        self.dateLabel.text = [NSString stringWithFormat:@"%@ to %@",reqStartDateString,reqEndDateString];
        NSLog(@"%@%@",reqStartDateString,reqEndDateString);

    }
    self.timeLabel.text = [NSString stringWithFormat:@"%@ to %@",appDel.event_StartTime,appDel.event_EndTime];
    NSLog(@"%@%@%@",appDel.event_StartTime,appDel.event_EndTime,self.timeLabel.text);
    self.despTextView.text = appDel.event_description;
    self.mobileNumberLabel.text = [NSString stringWithFormat:@"%@ %@,%@",@"Mobile Number :",appDel.event_PrimaryContactNumber,appDel.event_secondaryContactNumber];;
    self.organiserName.text =  appDel.event_PrimaryContactPerson;
    self.mailLabel.text = [NSString stringWithFormat:@"%@ %@",@"Email :",appDel.event_Contact_email];
    eyeImageFlag = @"0";
    NSString *popularity = appDel.event_popularity;
    self.poularityCount.text = [NSString stringWithFormat:@"%@ %@",popularity,@"Views"] ;
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([appDel.reviewUsername isEqualToString:@""] && [appDel.reviewComments isEqualToString:@""])
    {
        self.reviewNameLabel.hidden = YES;
        self.reviewComments.hidden = YES;
        self.reviewmoreButnOtlet.hidden = YES;
        self.reviewTitleLabel.hidden = YES;
        self.reviewDownView.hidden = YES;
        self.writeReviewOutlet.hidden = YES;
    
        self.starImageOne.hidden = YES;
        self.starImageTwo.hidden = YES;
        self.starImageThree.hidden = YES;
        self.starImageFour.hidden = YES;
        self.starImageFive.hidden = YES;
        
        CGRect dateFrame = _reviewDownView.frame;
        dateFrame.origin.y = _reviewTitleLabel.frame.origin.y + 30;
        [_reviewDownView setFrame:dateFrame];
    }
    else
    {
        self.starImageOne.hidden = NO;
        self.starImageTwo.hidden = NO;
        self.starImageThree.hidden = NO;
        self.starImageFour.hidden = NO;
        self.starImageFive.hidden = NO;

        self.reviewNameLabel.hidden = NO;
        self.reviewComments.hidden = NO;
        self.reviewmoreButnOtlet.hidden = NO;
        self.reviewNameLabel.text = appDel.reviewUsername;
        self.reviewComments.text = appDel.reviewComments;

    }
    
    if ([appDel.reviewComments isEqualToString:@""] && [appDel.event_rating isEqualToString:@""])
    {
        self.starImageOne.image = [UIImage imageNamed:@"star icon"];
        self.starImageTwo.image = [UIImage imageNamed:@"star icon"];
        self.starImageThree.image = [UIImage imageNamed:@"star icon"];
        self.starImageFour.image = [UIImage imageNamed:@"star icon"];
        self.starImageFive.image = [UIImage imageNamed:@"star icon"];
    
        self.starImageOne.hidden = YES;
        self.starImageTwo.hidden = YES;
        self.starImageThree.hidden = YES;
        self.starImageFour.hidden = YES;
        self.starImageFive.hidden = YES;
        
    }
    else
    {
        if ([appDel.event_rating isEqualToString:@"1"])
        {
            self.starImageOne.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageTwo.image = [UIImage imageNamed:@"star icon"];
            self.starImageThree.image = [UIImage imageNamed:@"star icon"];
            self.starImageFour.image = [UIImage imageNamed:@"star icon"];
            self.starImageFive.image = [UIImage imageNamed:@"star icon"];
        }
        if ([appDel.event_rating isEqualToString:@"2"])
        {
            self.starImageOne.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageTwo.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageThree.image = [UIImage imageNamed:@"star icon"];
            self.starImageFour.image = [UIImage imageNamed:@"star icon"];
            self.starImageFive.image = [UIImage imageNamed:@"star icon"];
        }
        if ([appDel.event_rating isEqualToString:@"3"])
        {
            self.starImageOne.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageTwo.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageThree.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageFour.image = [UIImage imageNamed:@"star icon"];
            self.starImageFive.image = [UIImage imageNamed:@"star icon"];
        }
        if ([appDel.event_rating isEqualToString:@"4"])
        {
            self.starImageOne.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageTwo.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageThree.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageFour.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageFive.image = [UIImage imageNamed:@"star icon"];
        }
        if ([appDel.event_rating isEqualToString:@"5"])
        {
            self.starImageOne.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageTwo.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageThree.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageFour.image = [UIImage imageNamed:@"star icon_selected"];
            self.starImageFive.image = [UIImage imageNamed:@"star icon_selected"];
        }
    }
    self.mapView.layer.cornerRadius = 6.0;
    [self loadUserLocation];
}
-(void)viewWillAppear:(BOOL)animated
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    [parameters setObject:appDel.event_id forKey:@"event_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *wishListStatus = @"apimain/wishListStatus";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,wishListStatus, nil];
    NSString *api = [NSString pathWithComponents:components];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         NSLog(@"%@",msg);
         
         if ([status isEqualToString:@"success"])
         {
             UIImage *image = [UIImage imageNamed:@"favselectedED"];
             [self->wishlistButton setBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
             self->wishlistButton.tintColor = [UIColor redColor];
             self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
             self->appDel.wishlist_id = [responseObject objectForKey:@"wishlist_id"];
             self->favImageFlag = @"1";
         }
         else
         {
             UIImage *image = [UIImage imageNamed:@"favWhishlist"];
             [self->wishlistButton setBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
             self->wishlistButton.tintColor = [UIColor whiteColor];
             self->favImageFlag = @"0";
         }
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewDidLayoutSubviews
{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,1081);
    [self.despTextView setContentOffset:CGPointZero animated:NO];
}
- (void)loadUserLocation
{
    objLocationManager = [[CLLocationManager alloc] init];
    objLocationManager.delegate = self;
    objLocationManager.distanceFilter = kCLDistanceFilterNone;
    objLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    if ([objLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [objLocationManager requestWhenInUseAuthorization];
    }
    [objLocationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0)
{
    CLLocation *newLocation = [locations objectAtIndex:0];
    latitude_UserLocation = newLocation.coordinate.latitude;
    longitude_UserLocation = newLocation.coordinate.longitude;
    _mapView.showsUserLocation = YES;
    [objLocationManager stopUpdatingLocation];
    [self loadMapView];
}
- (void)loadMapView
{
        CLLocationCoordinate2D  ctrpoint;
        ctrpoint.latitude = [appDel.event_EventLatitude doubleValue];
        ctrpoint.longitude =[appDel.event_EventLongitude doubleValue];
        
        MKCoordinateSpan objCoorSpan = {.latitudeDelta = 0.1, .longitudeDelta = 0.1};
        MKCoordinateRegion objMapRegion = {ctrpoint, objCoorSpan};
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:ctrpoint];
        
    [_mapView setRegion:objMapRegion];
    [_mapView addAnnotation:annotation];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)checkBtn:(id)sender
{
    CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:latitude_UserLocation longitude:longitude_UserLocation];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:[appDel.event_EventLatitude doubleValue] longitude:[appDel.event_EventLongitude doubleValue]];
    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation];
    
    if ([appDel.user_type isEqualToString:@"2"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Login to Access"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                 [self presentViewController:loginViewController animated:NO completion:nil];
                             }];
        
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        if (distance <= 100)
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSDate *today = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"YYYY-MM-dd"];
            NSString *dateString = [dateFormat stringFromDate:today];
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:@"3" forKey:@"rule_id"];
            [parameters setObject:appDel.user_Id forKey:@"user_id"];
            [parameters setObject:appDel.event_id forKey:@"event_id"];
            [parameters setObject:dateString forKey:@"date"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            NSString *useractivity = @"apimain/useractivity";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,useractivity, nil];
            NSString *api = [NSString pathWithComponents:components];
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 
                 NSLog(@"%@",responseObject);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSString *status = [responseObject objectForKey:@"status"];
                 
                 if ([msg isEqualToString:@"User Activity Updated"] && [status isEqualToString:@"success"])
                 {
                     
                     UIAlertController *alert= [UIAlertController
                                                alertControllerWithTitle:@"Heyla"
                                                message:msg
                                                preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* ok = [UIAlertAction
                                          actionWithTitle:@"OK"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                          }];
                     
                     [alert addAction:ok];
                     [self presentViewController:alert animated:YES completion:nil];
                     
                 }
                 else
                 {
                     UIAlertController *alert= [UIAlertController
                                                alertControllerWithTitle:@"Heyla"
                                                message:msg
                                                preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* ok = [UIAlertAction
                                          actionWithTitle:@"OK"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              
                                          }];
                     [alert addAction:ok];
                     [self presentViewController:alert animated:YES completion:nil];
                 }
             }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 NSLog(@"error: %@", error);
             }];
        }
        else
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Heyla"
                                       message:@"Move closer to the location"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }

}
- (IBAction)bookNowBtn:(id)sender
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([appDel.user_type isEqualToString:@"2"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Login to Access"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                 [self presentViewController:loginViewController animated:NO completion:nil];
                             }];
        
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"bookingView" sender:self];
    }
}
- (IBAction)backBtn:(id)sender
{
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"advnce_filter"];
    if ([str isEqualToString:@"YES"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(CLLocationCoordinate2D)getLocation
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    return coordinate;
}
- (IBAction)mapViewBtn:(id)sender
{
    
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    CLLocationCoordinate2D start = {[latitude doubleValue],[longitude doubleValue]};
    CLLocationCoordinate2D destination = {[appDel.event_EventLatitude doubleValue],[appDel.event_EventLongitude doubleValue]};
    
    NSString *googleMapsURLString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%1.6f,%1.6f&daddr=%1.6f,%1.6f",start.latitude, start.longitude, destination.latitude, destination.longitude];
    
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:[NSURL URLWithString:googleMapsURLString] options:@{} completionHandler:nil];
}

- (IBAction)shareBtn:(id)sender
{
    if ([appDel.user_type isEqualToString:@"2"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Login to Access"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                 [self presentViewController:loginViewController animated:NO completion:nil];
                             }];
        
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    
    }
    else
    {
        NSDate *currentDate = [[NSDate alloc] init];
        NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *localDateString = [dateFormatter stringFromDate:currentDate];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:@"2" forKey:@"rule_id"];
        [parameters setObject:appDel.user_Id forKey:@"user_id"];
        [parameters setObject:appDel.event_id forKey:@"event_id"];
        [parameters setObject:localDateString forKey:@"date"];

        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString *userActivity = @"apimain/userActivity";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,userActivity, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             
             if ([msg isEqualToString:@"User Activity Updated"] && [status isEqualToString:@"success"])
             {
                 if ([self->appDel.event_type isEqualToString:@"Hotspot"])
                 {
                     NSString *strURL=[NSString stringWithFormat:@"http://heylaapp.com/"];
                     NSURL *urlReq = [NSURL URLWithString:strURL];
                     NSString *eventName = self->appDel.event_Name;
                     NSString *eventDescription = self->appDel.event_description;
                     NSString *eventLocation = self->appDel.event_Address;
                     NSString *eventtime = [NSString stringWithFormat:@"%@ %@ %@ / %@",@"To",@":",self->appDel.event_StartTime,self->appDel.event_EndTime];
//                   NSString *eventDate = [NSString stringWithFormat:@"%@ %@ %@ / %@",@"From",@":",self->appDel.event_StartDate,self->appDel.event_EndDate];
                     NSArray *items = @[eventName,eventtime,eventDescription,eventLocation,urlReq];
                     UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
                     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                     [self presentActivityController:controller];
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                 }
                 else
                 {
                     NSString *strURL=[NSString stringWithFormat:@"http://heylaapp.com/"];
                     NSURL *urlReq = [NSURL URLWithString:strURL];
                     NSString *eventName = self->appDel.event_Name;
                     NSString *eventDescription = self->appDel.event_description;
                     NSString *eventLocation = self->appDel.event_Address;
                     NSString *eventtime = [NSString stringWithFormat:@"%@ %@ %@ / %@",@"To",@":",self->appDel.event_StartTime,self->appDel.event_EndTime];
                     NSString *eventDate = [NSString stringWithFormat:@"%@ %@ %@ / %@",@"From",@":",self->appDel.event_StartDate,self->appDel.event_EndDate];
                     NSArray *items = @[eventName,eventDate,eventtime,eventDescription,eventLocation,urlReq];
                     UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
                     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                     [self presentActivityController:controller];
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                 }
             }
             else
             {
                     UIAlertController *alert= [UIAlertController
                                                alertControllerWithTitle:@"Heyla"
                                                message:msg
                                                preferredStyle:UIAlertControllerStyleAlert];
                 
                     UIAlertAction *ok = [UIAlertAction
                                          actionWithTitle:@"OK"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              
                                          }];
                 
                     [alert addAction:ok];
                     [self presentViewController:alert animated:YES completion:nil];
             }
         }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
                     NSLog(@"error: %@", error);
         }];
        
    }
}
- (void)presentActivityController:(UIActivityViewController *)controller
{
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    controller.popoverPresentationController.sourceView = self.view;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    // access the completion handler
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed)
        {
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
        }
        else
        {
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        }
        if (error)
        {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
}
- (IBAction)reviewBtn:(id)sender
{
    if ([appDel.user_type isEqualToString:@"2"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Login to Access"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                 [self presentViewController:loginViewController animated:NO completion:nil];
                             }];
        
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"to_eventReview" sender:self];

    }
}
- (IBAction)imageViewBtn:(id)sender
{
    [self performSegueWithIdentifier:@"to_EventImage" sender:self];
}

- (IBAction)writeReviewButton:(id)sender
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([appDel.user_type isEqualToString:@"2"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Login to Access"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                 [self presentViewController:loginViewController animated:NO completion:nil];
                             }];
        
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"addreview"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
        AddingReviewViewController *myNewVC = (AddingReviewViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AddingReviewViewController"];
        [self.navigationController pushViewController:myNewVC animated:YES];
    }
}

-(IBAction)Add:(id)sender
{
    if ([appDel.user_type isEqualToString:@"2"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Login to Access"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                 [self presentViewController:loginViewController animated:NO completion:nil];
                             }];
        
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        if ([favImageFlag isEqualToString:@"0"])
        {
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.user_Id forKey:@"user_id"];
            [parameters setObject:@"1" forKey:@"wishlist_master_id"];
            [parameters setObject:appDel.event_id forKey:@"event_id"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            NSString *addWishListMaster = @"apimain/addWishList";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,addWishListMaster, nil];
            NSString *api = [NSString pathWithComponents:components];
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 
                 NSLog(@"%@",responseObject);
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSString *status = [responseObject objectForKey:@"status"];
                 
                 if ([msg isEqualToString:@"Wishlist Added"] && [status isEqualToString:@"success"])
                 {
                     UIImage *image = [UIImage imageNamed:@"favselectedED"];
                     [self->wishlistButton setBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
                     self->wishlistButton.tintColor = [UIColor redColor];
                     
                     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                     
                     // Configure for text only and offset down
                     hud.mode = MBProgressHUDModeText;
                     hud.label.text = @"Wishlist added";
                     hud.margin = 10.f;
                     hud.yOffset = 200.f;
                     hud.removeFromSuperViewOnHide = YES;
                     [hud hideAnimated:YES afterDelay:2];
                     
                 }
                 else
                 {
                     UIAlertController *alert= [UIAlertController
                                                alertControllerWithTitle:@"Heyla"
                                                message:msg
                                                preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* ok = [UIAlertAction
                                          actionWithTitle:@"OK"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              
                                          }];
                     [alert addAction:ok];
                     [self presentViewController:alert animated:YES completion:nil];
                 }
             }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 NSLog(@"error: %@", error);
             }];
        }
        else
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Heyla"
                                       message:@"Whishlist already added"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}
- (IBAction)moreButton:(id)sender
{
    [self performSegueWithIdentifier:@"to_reviewList" sender:self];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
- (IBAction)report_Btn:(id)sender
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.reviewList_id forKey:@"review_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *report_abuse = @"apimain/report_abuse";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,report_abuse, nil];
    NSString *api = [NSString pathWithComponents:components];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         NSLog(@"%@",msg);
         
         if ([status isEqualToString:@"success"])
         {
             UIAlertController *alert= [UIAlertController
                                        alertControllerWithTitle:@"Heyla"
                                        message:msg
                                        preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* ok = [UIAlertAction
                                  actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      
                                  }];
             [alert addAction:ok];
             [self presentViewController:alert animated:YES completion:nil];
         }
         else
         {
            
         }
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}
@end
