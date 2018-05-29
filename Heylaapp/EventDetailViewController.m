//
//  EventDetailViewController.m
//  Heylaapp
//
//  Created by HappySanz on 27/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()
{
    AppDelegate *appDel;
    NSString *favImageFlag;
    NSString *eyeImageFlag;
    NSString *reviewCount;

}
@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _viewOne.layer.cornerRadius = 8;
    _viewOne.layer.borderWidth = 1.0;
    _viewOne.layer.masksToBounds = true;
    _viewTwo.layer.cornerRadius = 8;
    _viewTwo.layer.borderWidth = 1.0;
    _viewTwo.layer.masksToBounds = true;
    _viewThree.layer.cornerRadius = 8;
    _viewThree.layer.borderWidth = 1.0;
    _viewThree.layer.masksToBounds = true;
    _viewFour.layer.cornerRadius = 8;
    _viewFour.layer.borderWidth = 1.0;
    _viewFour.layer.masksToBounds = true;
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
             self.favouriteImageView.image = [UIImage imageNamed:@"FavselectedHeart"];
             self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
             self->appDel.wishlist_id = [responseObject objectForKey:@"wishlist_id"];
             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
             
             // Configure for text only and offset down
             hud.mode = MBProgressHUDModeText;
             hud.label.text = @"Wishlist added";
             hud.margin = 10.f;
             hud.yOffset = 200.f;
             hud.removeFromSuperViewOnHide = YES;
             
             [hud hideAnimated:YES afterDelay:3];
             self->favImageFlag = @"1";
         }
         else
         {
             self.favouriteImageView.image = [UIImage imageNamed:@"FavHeart.png"];
             self->favImageFlag = @"0";
         }
      }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
    [self.despTextView setContentOffset:CGPointZero animated:NO];
    if ([appDel.booking_status isEqualToString:@"Y"])
    {
        self.bookNow.hidden = NO;
    }
    else
    {
        self.check.frame = CGRectMake(247, 10, 118, 34);
        self.bookNow.hidden = YES;

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
    NSDateFormatter *startdateFormatter = [[NSDateFormatter alloc] init];
    [startdateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startdate  = [startdateFormatter dateFromString:appDel.event_StartDate];
    [startdateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *startDate = [startdateFormatter stringFromDate:startdate];
    
    NSDateFormatter *enddateFormatter = [[NSDateFormatter alloc] init];
    [enddateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *enddate  = [enddateFormatter dateFromString:appDel.event_EndDate];
    [startdateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *endDate = [startdateFormatter stringFromDate:enddate];
    
    if ([appDel.event_type isEqualToString:@"Hotspot"])
    {
        self.dateLabel.hidden = YES;
        self.dateImage.hidden = YES;
        self.dateImageLabel.hidden = YES;
    }
    else
    {
        self.dateLabel.hidden = NO;
        self.dateImage.hidden = NO;
        self.dateImageLabel.hidden = NO;
        self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@",startDate,endDate];
        NSLog(@"%@%@",appDel.event_StartDate,appDel.event_EndDate);

    }
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",appDel.event_StartTime,appDel.event_EndTime];
    NSLog(@"%@%@%@",appDel.event_StartTime,appDel.event_EndTime,self.timeLabel.text);
    self.despTextView.text = appDel.event_description;
    self.mobileNumberLabel.text = [NSString stringWithFormat:@"%@ , %@",appDel.event_PrimaryContactNumber,appDel.event_secondaryContactNumber];;
    self.organiserName.text =  appDel.event_PrimaryContactPerson;
    self.mailLabel.text = appDel.event_Contact_email;
    eyeImageFlag = @"0";
    NSString *popularity = appDel.event_popularity;
    self.poularityCount.text = popularity;
    [self loadUserLocation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewDidLayoutSubviews
{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,730);
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

- (IBAction)favImageBtn:(id)sender
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
                     self.favouriteImageView.image = [UIImage imageNamed:@"FavselectedHeart"];
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
    [self dismissViewControllerAnimated:YES completion:nil];
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
//                     NSString *eventDate = [NSString stringWithFormat:@"%@ %@ %@ / %@",@"From",@":",self->appDel.event_StartDate,self->appDel.event_EndDate];
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
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
