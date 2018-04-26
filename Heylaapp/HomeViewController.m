//
//  HomeViewController.m
//  Heylaapp
//
//  Created by HappySanz on 19/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "HomeViewController.h"
#import "HMSegmentedControl.h"
#import "LSFloatingActionMenu.h"

@interface HomeViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *adv_status;
    NSMutableArray *advertisement;
    NSMutableArray *booking_status;
    NSMutableArray *category_id;
    NSMutableArray *city_name;
    NSMutableArray *contact_email;
    NSMutableArray *contact_person;
    NSMutableArray *country_name;
    NSMutableArray *description;
    NSMutableArray *end_date;
    NSMutableArray *event_address;
    NSMutableArray *event_banner;
    NSMutableArray *event_city;
    NSMutableArray *event_colour_scheme;
    NSMutableArray *event_country;
    NSMutableArray *event_id;
    NSMutableArray *event_latitude;
    NSMutableArray *event_longitude;
    NSMutableArray *event_name;
    NSMutableArray *event_status;
    NSMutableArray *event_type;
    NSMutableArray *event_venue;
    NSMutableArray *hotspot_status;
    NSMutableArray *popularity;
    NSMutableArray *primary_contact_no;
    NSMutableArray *secondary_contact_no;
    NSMutableArray *start_date;
    NSMutableArray *start_time;
    NSMutableArray *end_time;
    NSMutableArray *Eventdetails;
    NSMutableArray *date_label;
    NSMutableArray *month_label;
    NSMutableArray *to_date_label;
    NSMutableArray *to_month_label;
    CLLocationManager *objLocationManager;
    double latitude_UserLocation, longitude_UserLocation;
    NSString *mapViewFlag;
    NSString *searchFlag;
    NSString *hotspotFlag;
    UIGestureRecognizer* cancelGesture;
    
    NSDateFormatter *dateFormatter;
    NSDate *date;
    NSString *reqDateString;
    NSArray *testArray;
    NSArray *to_testArray;
    NSString *strdate;
    NSString *strtodate;
    NSString *str;
    NSArray *samp;
    NSString *strMonth;
    NSString *strToMonth;

}
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *exampleView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UISearchController *searchController;


@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:71.0/255.0 green:142/255.0 blue:204/255.0 alpha:1.0]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    adv_status = [[NSMutableArray alloc]init];
    advertisement = [[NSMutableArray alloc]init];
    booking_status = [[NSMutableArray alloc]init];
    category_id = [[NSMutableArray alloc]init];
    city_name = [[NSMutableArray alloc]init];
    contact_email = [[NSMutableArray alloc]init];
    contact_person = [[NSMutableArray alloc]init];
    country_name = [[NSMutableArray alloc]init];
    description = [[NSMutableArray alloc]init];
    end_date = [[NSMutableArray alloc]init];
    event_address = [[NSMutableArray alloc]init];
    event_banner = [[NSMutableArray alloc]init];
    event_city = [[NSMutableArray alloc]init];
    event_colour_scheme = [[NSMutableArray alloc]init];
    event_country = [[NSMutableArray alloc]init];
    event_id = [[NSMutableArray alloc]init];
    event_latitude = [[NSMutableArray alloc]init];
    event_longitude = [[NSMutableArray alloc]init];
    event_name = [[NSMutableArray alloc]init];
    event_status = [[NSMutableArray alloc]init];
    event_type = [[NSMutableArray alloc]init];
    event_venue = [[NSMutableArray alloc]init];
    hotspot_status = [[NSMutableArray alloc]init];
    popularity = [[NSMutableArray alloc]init];
    primary_contact_no = [[NSMutableArray alloc]init];
    secondary_contact_no = [[NSMutableArray alloc]init];
    start_date = [[NSMutableArray alloc]init];
    start_time = [[NSMutableArray alloc]init];
    end_time = [[NSMutableArray alloc]init];
    date_label = [[NSMutableArray alloc]init];
    month_label = [[NSMutableArray alloc]init];
    to_date_label = [[NSMutableArray alloc]init];
    to_month_label = [[NSMutableArray alloc]init];
    mapViewFlag = @"0";
    searchFlag = @"NO";
    hotspotFlag = @"NO";
    [self setupSegmentControl];
    self.searchController.searchBar.hidden = NO;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:Nil];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.barTintColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    
    _eventArray = [[NSMutableArray alloc] init];
    _filterdItems = [[NSMutableArray alloc]init];
    Eventdetails = [[NSMutableArray alloc]init];
    _lbViewOne.layer.cornerRadius = 8;
    _lbViewOne.layer.masksToBounds = true;
    _lbViewTwo.layer.cornerRadius = 8;
    _lbViewTwo.layer.masksToBounds = true;
    _lbViewThree.layer.cornerRadius = 8;
    _lbViewThree.layer.masksToBounds = true;
    _lbViewFour.layer.cornerRadius = 8;
    _lbViewFour.layer.masksToBounds = true;
    _lbViewFive.layer.cornerRadius = 8;
    _lbViewFive.layer.masksToBounds = true;
    self.leaderBoardView.hidden =YES;
    NSArray *city;
    city = [NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"cityName_Array"]];
    NSString *locatedCity = [[NSUserDefaults standardUserDefaults]objectForKey:@"locatedCity"];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    for (int i = 0;i < [city count];i++)
    {
        NSString *str = [city objectAtIndex:i];
        if ([str isEqualToString:locatedCity])
        {
            if (![appDel.selected_City isEqualToString:locatedCity])
            {
                NSString *alertMsg = [NSString stringWithFormat:@"%@ %@ %@",@"New events are available for",locatedCity,@"would you like to change city?"];
                UIAlertController *alert= [UIAlertController
                                           alertControllerWithTitle:@"City change"
                                           message:alertMsg
                                           preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         appDel.selected_City = locatedCity;
                                         NSArray *Cityid_Arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityID_Array"];
                                         NSUInteger city_Id_Index = [city indexOfObject:locatedCity];
                                         appDel.selected_City_Id = Cityid_Arr[city_Id_Index];
                                         [[NSUserDefaults standardUserDefaults]setObject:appDel.selected_City_Id forKey:@"stat_city_id"];
                                         [self generalEventsList];
                                     }];
                
                [alert addAction:ok];
                UIAlertAction *cancel = [UIAlertAction
                                     actionWithTitle:@"Cancel"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [self generalEventsList];
                                     }];
                
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else
            {
                [self generalEventsList];
            }
        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = @"Heyla";
}
- (void)loadUserLocation
{
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height - 50)];
    [self.tableView addSubview:_mapView];
    objLocationManager = [[CLLocationManager alloc] init];
    objLocationManager.delegate = self;
    objLocationManager.distanceFilter = kCLDistanceFilterNone;
    objLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    mapViewFlag = @"YES";
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
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.user_currentLatitude = [NSString stringWithFormat:@"%f",latitude_UserLocation];
    appDel.user_currentLongitude = [NSString stringWithFormat:@"%f",longitude_UserLocation];
    NSLog(@"%@%@",appDel.user_currentLatitude,appDel.user_currentLongitude);
    _mapView.showsUserLocation = YES;
    [objLocationManager stopUpdatingLocation];
    [self loadMapView];
}
- (void) loadMapView
{
    for (int i =0; i < [event_longitude count] && i < [event_latitude count]; i++)
    {
        NSString *lon = [event_longitude objectAtIndex:i];
        NSString *lat = [event_latitude objectAtIndex:i];
        CLLocationCoordinate2D  ctrpoint;
        ctrpoint.latitude = [lat doubleValue];
        ctrpoint.longitude =[lon doubleValue];
        MKCoordinateSpan objCoorSpan = {.latitudeDelta = 0.1, .longitudeDelta = 0.1};
        MKCoordinateRegion objMapRegion = {ctrpoint, objCoorSpan};
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:ctrpoint];
        [_mapView setRegion:objMapRegion];
        [_mapView addAnnotation:annotation];
    }
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Heyla"
                               message:@"Failed to Get Your Location"
                               preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {

                         }];

    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    [objLocationManager stopUpdatingLocation];
}
-(void)generalEventsList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_id"];
    appDel.user_Id = user_id;
    NSString *user_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    appDel.user_type = user_type;
    NSString *city_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_city_id"];
    appDel.selected_City_Id = city_id;
    appDel.event_type = @"Favourite";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"General" forKey:@"event_type"];
    [parameters setObject:user_id forKey:@"user_id"];
    [parameters setObject:user_type forKey:@"user_type"];
    [parameters setObject:city_id forKey:@"event_city_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *viewEvents = @"apimain/viewEvents";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,viewEvents, nil];
    NSString *api = [NSString pathWithComponents:components];
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Events"] && [status isEqualToString:@"success"])
         {
             appDel.event_categoery_Ref = @"general";
             Eventdetails = [responseObject objectForKey:@"Eventdetails"];
             _eventArray = [responseObject objectForKey:@"Eventdetails"];
             
             [adv_status removeAllObjects];
             [advertisement removeAllObjects];
             [booking_status removeAllObjects];
             [category_id removeAllObjects];
             [city_name removeAllObjects];
             [contact_email removeAllObjects];
             [contact_person removeAllObjects];
             [country_name removeAllObjects];
             [description removeAllObjects];
             [end_date removeAllObjects];
             [event_address removeAllObjects];
             [event_banner removeAllObjects];
             [event_city removeAllObjects];
             [event_colour_scheme removeAllObjects];
             [event_country removeAllObjects];
             [event_id removeAllObjects];
             [event_latitude removeAllObjects];
             [event_longitude removeAllObjects];
             [event_name removeAllObjects];
             [event_status removeAllObjects];
             [event_type removeAllObjects];
             [event_venue removeAllObjects];
             [hotspot_status removeAllObjects];
             [popularity removeAllObjects];
             [primary_contact_no removeAllObjects];
             [secondary_contact_no removeAllObjects];
             [start_date removeAllObjects];
             [start_time removeAllObjects];
             [end_time removeAllObjects];
             [date_label removeAllObjects];
             [month_label removeAllObjects];
             [to_date_label removeAllObjects];
             [to_month_label removeAllObjects];
             
             for(int i = 0;i < [Eventdetails count];i++)
             {
                 NSDictionary *dict = [Eventdetails objectAtIndex:i];
                 NSString *strAdv_status = [dict objectForKey:@"adv_status"];
                 NSString *strAdvertisement = [dict objectForKey:@"advertisement"];
                 NSString *strBooking_status = [dict objectForKey:@"booking_status"];
                 NSString *strCategory_id = [dict objectForKey:@"category_id"];
                 NSString *strCity_name = [dict objectForKey:@"city_name"];
                 NSString *strContact_email = [dict objectForKey:@"contact_email"];
                 NSString *strContact_person = [dict objectForKey:@"contact_person"];
                 NSString *strCountry_name = [dict objectForKey:@"country_name"];
                 NSString *strDescription = [dict objectForKey:@"description"];
                 NSString *strEnd_date = [dict objectForKey:@"end_date"];
                 NSString *strEvent_address = [dict objectForKey:@"event_address"];
                 NSString *strEvent_banner = [dict objectForKey:@"event_banner"];
                 NSString *strEvent_city = [dict objectForKey:@"event_city"];
                 NSString *strEvent_colour_scheme = [dict objectForKey:@"event_colour_scheme"];
                 NSString *strEvent_country = [dict objectForKey:@"event_country"];
                 NSString *strEvent_id = [dict objectForKey:@"event_id"];
                 NSString *strEvent_latitude = [dict objectForKey:@"event_latitude"];
                 NSString *strEvent_longitude = [dict objectForKey:@"event_longitude"];
                 NSString *strEvent_name = [dict objectForKey:@"event_name"];
                 NSString *strEvent_status = [dict objectForKey:@"event_status"];
                 NSString *strEvent_type = [dict objectForKey:@"event_type"];
                 NSString *strEvent_venue = [dict objectForKey:@"event_venue"];
                 NSString *stHotspot_status = [dict objectForKey:@"hotspot_status"];
                 NSString *strPopularity = [dict objectForKey:@"popularity"];
                 NSString *strPrimary_contact_no = [dict objectForKey:@"primary_contact_no"];
                 NSString *strSecondary_contact_no = [dict objectForKey:@"secondary_contact_no"];
                 NSString *strStart_date = [dict objectForKey:@"start_date"];
                 NSString *strend_date = [dict objectForKey:@"end_date"];
                 NSString *strStart_time = [dict objectForKey:@"start_time"];
                 NSString *strEnd_time = [dict objectForKey:@"end_time"];

                 dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                 date = [[NSDate alloc] init];
                 date = [dateFormatter dateFromString:strStart_date];
                 // converting into our required date format
                 [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy"];
                 reqDateString = [dateFormatter stringFromDate:date];
                 NSLog(@"date is %@", reqDateString);
                 
                 testArray = [reqDateString componentsSeparatedByString:@" "];
                 strdate = [testArray objectAtIndex:1];
                 str = [testArray objectAtIndex:2];
                 samp = [str componentsSeparatedByString:@","];
                 strMonth = [samp objectAtIndex:0];
                 
                 
                 dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                 date = [[NSDate alloc] init];
                 date = [dateFormatter dateFromString:strend_date];
                 // converting into our required date format
                 [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy"];
                 reqDateString = [dateFormatter stringFromDate:date];
                 NSLog(@"date is %@", reqDateString);
                 
                 to_testArray = [reqDateString componentsSeparatedByString:@" "];
                 strtodate = [to_testArray objectAtIndex:1];
                 str = [to_testArray objectAtIndex:2];
                 samp = [str componentsSeparatedByString:@","];
                 strToMonth = [samp objectAtIndex:0];
                 
                 [adv_status addObject:strAdv_status];
                 [advertisement addObject:strAdvertisement];
                 [booking_status addObject:strBooking_status];
                 [category_id addObject:strCategory_id];
                 [city_name addObject:strCity_name];
                 [contact_email addObject:strContact_email];
                 [contact_person addObject:strContact_person];
                 [country_name addObject:strCountry_name];
                 [description addObject:strDescription];
                 [end_date addObject:strEnd_date];
                 [event_address addObject:strEvent_address];
                 [event_banner addObject:strEvent_banner];
                 [event_city addObject:strEvent_city];
                 [event_colour_scheme addObject:strEvent_colour_scheme];
                 [event_country addObject:strEvent_country];
                 [event_id addObject:strEvent_id];
                 [event_latitude addObject:strEvent_latitude];
                 [event_longitude addObject:strEvent_longitude];
                 [event_name addObject:strEvent_name];
                 [event_status addObject:strEvent_status];
                 [event_type addObject:strEvent_type];
                 [event_venue addObject:strEvent_venue];
                 [hotspot_status addObject:stHotspot_status];
                 [popularity addObject:strPopularity];
                 [primary_contact_no addObject:strPrimary_contact_no];
                 [secondary_contact_no addObject:strSecondary_contact_no];
                 [start_date addObject:strStart_date];
                 [start_time addObject:strStart_time];
                 [end_time addObject:strEnd_time];
                 [date_label addObject:strdate];
                 [month_label addObject:strMonth];
                 [to_date_label addObject:strtodate];
                 [to_month_label addObject:strToMonth];

             }
             
             if ([mapViewFlag isEqualToString:@"YES"])
             {
                 [self loadUserLocation];

             }
             else
             {
                 self.tableView.hidden = NO;
                 hotspotFlag = @"NO";
                 [self.tableView reloadData];

             }
         }
         else
         {
             self.tableView.hidden = YES;

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
-(void)generalPopularList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.searchController.searchBar.hidden = NO;
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"Popularity" forKey:@"event_type"];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    [parameters setObject:appDel.user_type forKey:@"user_type"];
    [parameters setObject:appDel.selected_City_Id forKey:@"event_city_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *viewEvents = @"apimain/viewEvents";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,viewEvents, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Events"] && [status isEqualToString:@"success"])
         {
             appDel.event_categoery_Ref = @"popular";
             Eventdetails = [responseObject objectForKey:@"Eventdetails"];
             _eventArray = [responseObject objectForKey:@"Eventdetails"];

             [adv_status removeAllObjects];
             [advertisement removeAllObjects];
             [booking_status removeAllObjects];
             [category_id removeAllObjects];
             [city_name removeAllObjects];
             [contact_email removeAllObjects];
             [contact_person removeAllObjects];
             [country_name removeAllObjects];
             [description removeAllObjects];
             [end_date removeAllObjects];
             [event_address removeAllObjects];
             [event_banner removeAllObjects];
             [event_city removeAllObjects];
             [event_colour_scheme removeAllObjects];
             [event_country removeAllObjects];
             [event_id removeAllObjects];
             [event_latitude removeAllObjects];
             [event_longitude removeAllObjects];
             [event_name removeAllObjects];
             [event_status removeAllObjects];
             [event_type removeAllObjects];
             [event_venue removeAllObjects];
             [hotspot_status removeAllObjects];
             [popularity removeAllObjects];
             [primary_contact_no removeAllObjects];
             [secondary_contact_no removeAllObjects];
             [start_date removeAllObjects];
             [start_time removeAllObjects];
             [end_time removeAllObjects];
             [date_label removeAllObjects];
             [month_label removeAllObjects];
             [to_date_label removeAllObjects];
             [to_month_label removeAllObjects];
             
             for(int i = 0;i < [Eventdetails count];i++)
             {
                 NSDictionary *dict = [Eventdetails objectAtIndex:i];
                 NSString *strAdv_status = [dict objectForKey:@"adv_status"];
                 NSString *strAdvertisement = [dict objectForKey:@"advertisement"];
                 NSString *strBooking_status = [dict objectForKey:@"booking_status"];
                 NSString *strCategory_id = [dict objectForKey:@"category_id"];
                 NSString *strCity_name = [dict objectForKey:@"city_name"];
                 NSString *strContact_email = [dict objectForKey:@"contact_email"];
                 NSString *strContact_person = [dict objectForKey:@"contact_person"];
                 NSString *strCountry_name = [dict objectForKey:@"country_name"];
                 NSString *strDescription = [dict objectForKey:@"description"];
                 NSString *strEnd_date = [dict objectForKey:@"end_date"];
                 NSString *strEvent_address = [dict objectForKey:@"event_address"];
                 NSString *strEvent_banner = [dict objectForKey:@"event_banner"];
                 NSString *strEvent_city = [dict objectForKey:@"event_city"];
                 NSString *strEvent_colour_scheme = [dict objectForKey:@"event_colour_scheme"];
                 NSString *strEvent_country = [dict objectForKey:@"event_country"];
                 NSString *strEvent_id = [dict objectForKey:@"event_id"];
                 NSString *strEvent_latitude = [dict objectForKey:@"event_latitude"];
                 NSString *strEvent_longitude = [dict objectForKey:@"event_longitude"];
                 NSString *strEvent_name = [dict objectForKey:@"event_name"];
                 NSString *strEvent_status = [dict objectForKey:@"event_status"];
                 NSString *strEvent_type = [dict objectForKey:@"event_type"];
                 NSString *strEvent_venue = [dict objectForKey:@"event_venue"];
                 NSString *stHotspot_status = [dict objectForKey:@"hotspot_status"];
                 NSString *strPopularity = [dict objectForKey:@"popularity"];
                 NSString *strPrimary_contact_no = [dict objectForKey:@"primary_contact_no"];
                 NSString *strSecondary_contact_no = [dict objectForKey:@"secondary_contact_no"];
                 NSString *strStart_date = [dict objectForKey:@"start_date"];
                 NSString *strend_date = [dict objectForKey:@"end_date"];
                 NSString *strStart_time = [dict objectForKey:@"start_time"];
                 NSString *strEnd_time = [dict objectForKey:@"end_time"];
                 
                 dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                 date = [[NSDate alloc] init];
                 date = [dateFormatter dateFromString:strStart_date];
                 // converting into our required date format
                 [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy"];
                 reqDateString = [dateFormatter stringFromDate:date];
                 NSLog(@"date is %@", reqDateString);
                 
                 testArray = [reqDateString componentsSeparatedByString:@" "];
                 strdate = [testArray objectAtIndex:1];
                 str = [testArray objectAtIndex:2];
                 samp = [str componentsSeparatedByString:@","];
                 strMonth = [samp objectAtIndex:0];
                 
                 dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                 date = [[NSDate alloc] init];
                 date = [dateFormatter dateFromString:strend_date];
                 // converting into our required date format
                 [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy"];
                 reqDateString = [dateFormatter stringFromDate:date];
                 NSLog(@"date is %@", reqDateString);
                 
                 to_testArray = [reqDateString componentsSeparatedByString:@" "];
                 strtodate = [to_testArray objectAtIndex:1];
                 str = [to_testArray objectAtIndex:2];
                 samp = [str componentsSeparatedByString:@","];
                 strToMonth = [samp objectAtIndex:0];
                 
                 [adv_status addObject:strAdv_status];
                 [advertisement addObject:strAdvertisement];
                 [booking_status addObject:strBooking_status];
                 [category_id addObject:strCategory_id];
                 [city_name addObject:strCity_name];
                 [contact_email addObject:strContact_email];
                 [contact_person addObject:strContact_person];
                 [country_name addObject:strCountry_name];
                 [description addObject:strDescription];
                 [end_date addObject:strEnd_date];
                 [event_address addObject:strEvent_address];
                 [event_banner addObject:strEvent_banner];
                 [event_city addObject:strEvent_city];
                 [event_colour_scheme addObject:strEvent_colour_scheme];
                 [event_country addObject:strEvent_country];
                 [event_id addObject:strEvent_id];
                 [event_latitude addObject:strEvent_latitude];
                 [event_longitude addObject:strEvent_longitude];
                 [event_name addObject:strEvent_name];
                 [event_status addObject:strEvent_status];
                 [event_type addObject:strEvent_type];
                 [event_venue addObject:strEvent_venue];
                 [hotspot_status addObject:stHotspot_status];
                 [popularity addObject:strPopularity];
                 [primary_contact_no addObject:strPrimary_contact_no];
                 [secondary_contact_no addObject:strSecondary_contact_no];
                 [start_date addObject:strStart_date];
                 [start_time addObject:strStart_time];
                 [end_time addObject:strEnd_time];
                 [date_label addObject:strdate];
                 [month_label addObject:strMonth];
                 [to_date_label addObject:strtodate];
                 [to_month_label addObject:strToMonth];

             }
             
             if ([mapViewFlag isEqualToString:@"YES"])
             {
                 [self loadUserLocation];
                 
             }
             else
             {
                 self.tableView.hidden = NO;
                 hotspotFlag = @"NO";
                 [self.tableView reloadData];
             }
             
         }
         else
         {
             self.tableView.hidden = YES;

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
-(void)generalHotspotList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.searchController.searchBar.hidden = NO;
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"Hotspot" forKey:@"event_type"];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    [parameters setObject:appDel.user_type forKey:@"user_type"];
    [parameters setObject:appDel.selected_City_Id forKey:@"event_city_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *viewEvents = @"apimain/viewEvents";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,viewEvents, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Events"] && [status isEqualToString:@"success"])
         {
             appDel.event_categoery_Ref = @"hotspot";
             Eventdetails = [responseObject objectForKey:@"Eventdetails"];
             _eventArray = [responseObject objectForKey:@"Eventdetails"];

             [adv_status removeAllObjects];
             [advertisement removeAllObjects];
             [booking_status removeAllObjects];
             [category_id removeAllObjects];
             [city_name removeAllObjects];
             [contact_email removeAllObjects];
             [contact_person removeAllObjects];
             [country_name removeAllObjects];
             [description removeAllObjects];
             [end_date removeAllObjects];
             [event_address removeAllObjects];
             [event_banner removeAllObjects];
             [event_city removeAllObjects];
             [event_colour_scheme removeAllObjects];
             [event_country removeAllObjects];
             [event_id removeAllObjects];
             [event_latitude removeAllObjects];
             [event_longitude removeAllObjects];
             [event_name removeAllObjects];
             [event_status removeAllObjects];
             [event_type removeAllObjects];
             [event_venue removeAllObjects];
             [hotspot_status removeAllObjects];
             [popularity removeAllObjects];
             [primary_contact_no removeAllObjects];
             [secondary_contact_no removeAllObjects];
             [start_date removeAllObjects];
             [start_time removeAllObjects];
             [end_time removeAllObjects];
             [date_label removeAllObjects];
             [month_label removeAllObjects];
             [to_date_label removeAllObjects];
             [to_month_label removeAllObjects];
             
             for(int i = 0;i < [Eventdetails count];i++)
             {
                 NSDictionary *dict = [Eventdetails objectAtIndex:i];
                 NSString *strAdv_status = [dict objectForKey:@"adv_status"];
                 NSString *strAdvertisement = [dict objectForKey:@"advertisement"];
                 NSString *strBooking_status = [dict objectForKey:@"booking_status"];
                 NSString *strCategory_id = [dict objectForKey:@"category_id"];
                 NSString *strCity_name = [dict objectForKey:@"city_name"];
                 NSString *strContact_email = [dict objectForKey:@"contact_email"];
                 NSString *strContact_person = [dict objectForKey:@"contact_person"];
                 NSString *strCountry_name = [dict objectForKey:@"country_name"];
                 NSString *strDescription = [dict objectForKey:@"description"];
                 NSString *strEnd_date = [dict objectForKey:@"end_date"];
                 NSString *strEvent_address = [dict objectForKey:@"event_address"];
                 NSString *strEvent_banner = [dict objectForKey:@"event_banner"];
                 NSString *strEvent_city = [dict objectForKey:@"event_city"];
                 NSString *strEvent_colour_scheme = [dict objectForKey:@"event_colour_scheme"];
                 NSString *strEvent_country = [dict objectForKey:@"event_country"];
                 NSString *strEvent_id = [dict objectForKey:@"event_id"];
                 NSString *strEvent_latitude = [dict objectForKey:@"event_latitude"];
                 NSString *strEvent_longitude = [dict objectForKey:@"event_longitude"];
                 NSString *strEvent_name = [dict objectForKey:@"event_name"];
                 NSString *strEvent_status = [dict objectForKey:@"event_status"];
                 NSString *strEvent_type = [dict objectForKey:@"event_type"];
                 NSString *strEvent_venue = [dict objectForKey:@"event_venue"];
                 NSString *stHotspot_status = [dict objectForKey:@"hotspot_status"];
                 NSString *strPopularity = [dict objectForKey:@"popularity"];
                 NSString *strPrimary_contact_no = [dict objectForKey:@"primary_contact_no"];
                 NSString *strSecondary_contact_no = [dict objectForKey:@"secondary_contact_no"];
                 NSString *strStart_date = [dict objectForKey:@"start_date"];
                 NSString *strend_date = [dict objectForKey:@"end_date"];
                 NSString *strStart_time = [dict objectForKey:@"start_time"];
                 NSString *strEnd_time = [dict objectForKey:@"end_time"];
                 
                 dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                 date = [[NSDate alloc] init];
                 date = [dateFormatter dateFromString:strStart_date];
                 // converting into our required date format
                 [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy"];
                 reqDateString = [dateFormatter stringFromDate:date];
                 NSLog(@"date is %@", reqDateString);
                 
                 testArray = [reqDateString componentsSeparatedByString:@" "];
                 strdate = [testArray objectAtIndex:1];
                 str = [testArray objectAtIndex:2];
                 samp = [str componentsSeparatedByString:@","];
                 strMonth = [samp objectAtIndex:0];
                 
                 dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                 date = [[NSDate alloc] init];
                 date = [dateFormatter dateFromString:strend_date];
                 // converting into our required date format
                 [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy"];
                 reqDateString = [dateFormatter stringFromDate:date];
                 NSLog(@"date is %@", reqDateString);
                 
                 to_testArray = [reqDateString componentsSeparatedByString:@" "];
                 strtodate = [to_testArray objectAtIndex:1];
                 str = [to_testArray objectAtIndex:2];
                 samp = [str componentsSeparatedByString:@","];
                 strToMonth = [samp objectAtIndex:0];
                 
                 [adv_status addObject:strAdv_status];
                 [advertisement addObject:strAdvertisement];
                 [booking_status addObject:strBooking_status];
                 [category_id addObject:strCategory_id];
                 [city_name addObject:strCity_name];
                 [contact_email addObject:strContact_email];
                 [contact_person addObject:strContact_person];
                 [country_name addObject:strCountry_name];
                 [description addObject:strDescription];
                 [end_date addObject:strEnd_date];
                 [event_address addObject:strEvent_address];
                 [event_banner addObject:strEvent_banner];
                 [event_city addObject:strEvent_city];
                 [event_colour_scheme addObject:strEvent_colour_scheme];
                 [event_country addObject:strEvent_country];
                 [event_id addObject:strEvent_id];
                 [event_latitude addObject:strEvent_latitude];
                 [event_longitude addObject:strEvent_longitude];
                 [event_name addObject:strEvent_name];
                 [event_status addObject:strEvent_status];
                 [event_type addObject:strEvent_type];
                 [event_venue addObject:strEvent_venue];
                 [hotspot_status addObject:stHotspot_status];
                 [popularity addObject:strPopularity];
                 [primary_contact_no addObject:strPrimary_contact_no];
                 [secondary_contact_no addObject:strSecondary_contact_no];
                 [start_date addObject:strStart_date];
                 [start_time addObject:strStart_time];
                 [end_time addObject:strEnd_time];
                 [date_label addObject:strdate];
                 [month_label addObject:strMonth];
                 [to_date_label addObject:strtodate];
                 [to_month_label addObject:strToMonth];
             }
             
             if ([mapViewFlag isEqualToString:@"YES"])
             {
                 [self loadUserLocation];
             }
             else
             {
                 self.tableView.hidden = NO;
                 hotspotFlag = @"YES";
                 [self.tableView reloadData];
                 
             }
         }
         else
         {
             self.tableView.hidden = YES;

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
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation))
        {
            _segmentedControl.frame = CGRectMake(0,650,self.view.bounds.size.width, 55);
            _segmentedControl.selectionIndicatorHeight = 2.0f;
            _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
            _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
            _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
            _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
            [self.view addSubview:_segmentedControl];
            [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        }
        else
        {
            _segmentedControl.frame = CGRectMake(0,905,self.view.bounds.size.width, 55);
            _segmentedControl.selectionIndicatorHeight = 2.0f;
            _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
            _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
            _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
            _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
            [self.view addSubview:_segmentedControl];
            [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([searchFlag isEqualToString:@"YES"])
    {
        return [_filterdItems count];
    }
    else
    {
        return [Eventdetails count];
    }
}
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HomeViewTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if([hotspotFlag isEqualToString:@"YES"])
    {
        if(self.searchController.active)
        {
            cell.eventName.text = [event_name objectAtIndex:indexPath.row];
            NSString *imageUrl = [event_banner objectAtIndex:indexPath.row];
            __weak HomeViewTableCell *weakCell = cell;
            UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
            [cell.eventImageView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
             {
                 weakCell.eventImageView.image = image;
                 
             } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                 
                 NSLog(@"%@",error);
                 
             }];
            
            cell.eventLocation.text = [event_venue objectAtIndex:indexPath.row];
            cell.eventStatus.text = [event_type objectAtIndex:indexPath.row];
            NSString *strStartTime = [start_time objectAtIndex:indexPath.row];
            NSString *strendTime = [end_time objectAtIndex:indexPath.row];
            cell.eventTime.text = [NSString stringWithFormat:@"%@ - %@",strStartTime,strendTime];
            cell.dateView.hidden = YES;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
        else
        {
            cell.eventName.text = [event_name objectAtIndex:indexPath.row];
            cell.dateView.hidden = YES;
            cell.dateLabel.text = [date_label objectAtIndex:indexPath.row];
            cell.monthLabel.text = [month_label objectAtIndex:indexPath.row];
            cell.toDateLabel.text = [to_date_label objectAtIndex:indexPath.row];
            cell.toMonthLabel.text = [to_month_label objectAtIndex:indexPath.row];
            NSString *imageUrl = [event_banner objectAtIndex:indexPath.row];
            __weak HomeViewTableCell *weakCell = cell;
            UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
            [cell.eventImageView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
             {
                 weakCell.eventImageView.image = image;
                 
             }
              failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error)
             {
                 NSLog(@"%@",error);
             }];
            
            cell.eventLocation.text = [event_venue objectAtIndex:indexPath.row];
            cell.eventStatus.text = [event_type objectAtIndex:indexPath.row];
            NSString *strStartTime = [start_time objectAtIndex:indexPath.row];
            NSString *strendTime = [end_time objectAtIndex:indexPath.row];
            cell.eventTime.text = [NSString stringWithFormat:@"%@ - %@",strStartTime,strendTime];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
    }
    else
    {
        if(self.searchController.active)
        {
            cell.eventName.text = [event_name objectAtIndex:indexPath.row];
            NSString *imageUrl = [event_banner objectAtIndex:indexPath.row];
            __weak HomeViewTableCell *weakCell = cell;
            UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
            [cell.eventImageView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
             {
                 weakCell.eventImageView.image = image;
                 
             } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error)
             {
                 
                 NSLog(@"%@",error);
                 
             }];
            
            cell.eventLocation.text = [event_venue objectAtIndex:indexPath.row];
            cell.eventStatus.text = [event_type objectAtIndex:indexPath.row];
            NSString *strStartTime = [start_time objectAtIndex:indexPath.row];
            NSString *strendTime = [end_time objectAtIndex:indexPath.row];
            cell.eventTime.text = [NSString stringWithFormat:@"%@ - %@",strStartTime,strendTime];
            cell.dateView.hidden = NO;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
        else
        {
            cell.eventName.text = [event_name objectAtIndex:indexPath.row];
            cell.dateView.hidden = NO;
            cell.dateLabel.text = [date_label objectAtIndex:indexPath.row];
            cell.monthLabel.text = [month_label objectAtIndex:indexPath.row];
            cell.toDateLabel.text = [to_date_label objectAtIndex:indexPath.row];
            cell.toMonthLabel.text = [to_month_label objectAtIndex:indexPath.row];
            NSString *imageUrl = [event_banner objectAtIndex:indexPath.row];
            __weak HomeViewTableCell *weakCell = cell;
            UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
            [cell.eventImageView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
             {
                 weakCell.eventImageView.image = image;
                 
             } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                 
                 NSLog(@"%@",error);
                 
             }];
            
            cell.eventLocation.text = [event_venue objectAtIndex:indexPath.row];
            cell.eventStatus.text = [event_type objectAtIndex:indexPath.row];
            NSString *strStartTime = [start_time objectAtIndex:indexPath.row];
            NSString *strendTime = [end_time objectAtIndex:indexPath.row];
            cell.eventTime.text = [NSString stringWithFormat:@"%@ - %@",strStartTime,strendTime];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
    }
    cell.paidView.layer.cornerRadius = 3.0;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.event_Name = [event_name objectAtIndex:indexPath.row];
    appDel.event_StartTime = [start_time objectAtIndex:indexPath.row];
    appDel.event_StartDate = [start_date objectAtIndex:indexPath.row];
    appDel.event_Address = [event_address objectAtIndex:indexPath.row];
    
    NSUInteger intend_time = [start_time indexOfObject:appDel.event_StartTime];
    appDel.event_EndTime = end_time[intend_time];

    NSUInteger intevent_endDate = [start_date indexOfObject:appDel.event_StartDate];
    appDel.event_EndDate = end_date[intevent_endDate];
    
    NSUInteger intevent_desp = [event_name indexOfObject:appDel.event_Name];
    appDel.event_description = description[intevent_desp];
    
    NSUInteger intlongitude = [event_name indexOfObject:appDel.event_Name];
    appDel.event_EventLongitude = event_longitude[intlongitude];
    
    NSUInteger intlatitude = [event_name indexOfObject:appDel.event_Name];
    appDel.event_EventLatitude = event_latitude[intlatitude];
    
    NSUInteger intprimaryContact = [event_name indexOfObject:appDel.event_Name];
    appDel.event_PrimaryContactNumber = primary_contact_no[intprimaryContact];
    
    NSUInteger intsecondaryContact = [event_name indexOfObject:appDel.event_Name];
    appDel.event_secondaryContactNumber = secondary_contact_no[intsecondaryContact];
    
    NSUInteger intcontact_email = [event_name indexOfObject:appDel.event_Name];
    appDel.event_Contact_email = contact_email[intcontact_email];
    
    NSUInteger intContactPerson = [event_name indexOfObject:appDel.event_Name];
    appDel.event_PrimaryContactPerson = contact_person[intContactPerson];

    NSUInteger intImageUrl = [event_name indexOfObject:appDel.event_Name];
    appDel.event_picture = event_banner[intImageUrl];
    
    NSUInteger popularity_Id = [event_name indexOfObject:appDel.event_Name];
    appDel.event_popularity = popularity[popularity_Id];
    NSLog(@"%@",appDel.event_popularity);
    
    NSUInteger event_idInt = [event_name indexOfObject:appDel.event_Name];
    appDel.event_id = event_id[event_idInt];
    
    NSUInteger intbooking_status = [event_name indexOfObject:appDel.event_Name];
    appDel.booking_status = booking_status[intbooking_status];
    
    [self performSegueWithIdentifier:@"home_eventdetail" sender:self];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 450;
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 667)
    {
        return 280;
    }
    else
    {
        return 225;
    }
}
-(void)setupSegmentControl
{
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionImages:@[[UIImage imageNamed:@"Fav"],[UIImage imageNamed:@"Popular"],[UIImage imageNamed:@"Hotspot"],[UIImage imageNamed:@"Leaderboard"]]
    sectionSelectedImages:@[[UIImage imageNamed:@"Favselected"],[UIImage imageNamed:@"Popularselected"],
                                                                            [UIImage imageNamed:@"Hotspotselected"],[UIImage imageNamed:@"Leaderboardselected"]]];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if(UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation))
        {
            NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Hotspot_nav"];
            if ([str isEqualToString:@"YES"])
            {
                _segmentedControl.frame = CGRectMake(0,650,self.view.bounds.size.width, 55);
                _segmentedControl.selectionIndicatorHeight = 2.0f;
                _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
                _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
                _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
                _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
                [self.view addSubview:_segmentedControl];
                [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            }
            else
            {
                _segmentedControl.frame = CGRectMake(0,650,self.view.bounds.size.width, 55);
                _segmentedControl.selectionIndicatorHeight = 2.0f;
                _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
                _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
                _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
                _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
                [self.view addSubview:_segmentedControl];
                [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            }
            
        }
        else
        {
            NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Hotspot_nav"];
            if ([str isEqualToString:@"YES"])
            {
                _segmentedControl.frame = CGRectMake(0,705,self.view.bounds.size.width, 55);
                _segmentedControl.selectionIndicatorHeight = 2.0f;
                _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
                _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
                _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
                _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
                [self.view addSubview:_segmentedControl];
                [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            }
            else
            {
                _segmentedControl.frame = CGRectMake(0,705,self.view.bounds.size.width, 55);
                _segmentedControl.selectionIndicatorHeight = 2.0f;
                _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
                _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
                _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
                _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
                [self.view addSubview:_segmentedControl];
                [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 667)
    {
        NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Hotspot_nav"];
        if ([str isEqualToString:@"YES"])
        {
            _segmentedControl.frame = CGRectMake(0,528,self.view.bounds.size.width, 55);
            _segmentedControl.selectionIndicatorHeight = 2.0f;
            _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
            _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
            _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
            _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
            [self.view addSubview:_segmentedControl];
            [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        }
        else
        {
        _segmentedControl.frame = CGRectMake(0,548,self.view.bounds.size.width, 55);
        _segmentedControl.selectionIndicatorHeight = 2.0f;
        _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
        _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
        [self.view addSubview:_segmentedControl];
        [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            
        }
    }
    else if ([[UIScreen mainScreen] bounds].size.height == 736)
    {
        NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Hotspot_nav"];
        if ([str isEqualToString:@"YES"])
        {
            _segmentedControl.frame = CGRectMake(0,595,self.view.bounds.size.width, 60);
            _segmentedControl.selectionIndicatorHeight = 2.0f;
            _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
            _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
            _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
            _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
            [self.view addSubview:_segmentedControl];
            [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];

        }
        else
        {
        _segmentedControl.frame = CGRectMake(0,615,self.view.bounds.size.width, 60);
        _segmentedControl.selectionIndicatorHeight = 2.0f;
        _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
        _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
        [self.view addSubview:_segmentedControl];
        [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            
        }
        
    }
    else
    {
        NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"Hotspot_nav"];
        if ([str isEqualToString:@"YES"])
        {
            _segmentedControl.frame = CGRectMake(0,430,self.view.bounds.size.width,55);
            _segmentedControl.selectionIndicatorHeight = 2.0f;
            _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
            _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
            _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
            _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
            [self.view addSubview:_segmentedControl];
            [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        }
        else
        {
            _segmentedControl.frame = CGRectMake(0,450,self.view.bounds.size.width,55);
            _segmentedControl.selectionIndicatorHeight = 2.0f;
            _segmentedControl.backgroundColor = [UIColor colorWithRed:62/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
            _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
            _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleBox;
            _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
            [self.view addSubview:_segmentedControl];
            [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        }
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

-(void)segmentAction:(UISegmentedControl *)sender
{
    if (_segmentedControl.selectedSegmentIndex == 0)
    {
        self.search.tintColor = [UIColor whiteColor];
        self.advanceFilter.tintColor = [UIColor whiteColor];
        self.leaderBoardView.hidden =YES;
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDel.event_type = @"Favourite";
        [self generalEventsList];
    }
    else if (_segmentedControl.selectedSegmentIndex == 1)
    {
        self.search.tintColor = [UIColor whiteColor];
        self.advanceFilter.tintColor = [UIColor whiteColor];
        self.leaderBoardView.hidden =YES;
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDel.event_type = @"Popular";
        [self generalPopularList];
    }
    else if (_segmentedControl.selectedSegmentIndex == 2)
    {
        self.search.tintColor = [UIColor whiteColor];
        self.advanceFilter.tintColor = [UIColor whiteColor];
        self.leaderBoardView.hidden =YES;
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDel.event_type = @"Hotspot";
        [self generalHotspotList];
    }
    else if (_segmentedControl.selectedSegmentIndex == 3)
    {
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if ([appDel.user_type isEqualToString:@"2"])
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Heyla"
                                       message:@"Login to Access"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
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
            self.search.tintColor = [UIColor colorWithRed:68/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
            self.advanceFilter.tintColor = [UIColor colorWithRed:68/255.0f green:142/255.0f blue:204/255.0f alpha:1.0];
            [self loadLeaderBoardPoints];
            self.leaderBoardView.hidden =NO;
        }
    }
}
-(void)loadLeaderBoardPoints
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.userName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"statUser_Name"];;
    self.fullName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fullName"];
    self.imageView.layer.cornerRadius = 60;
    self.imageView.clipsToBounds = YES;
    if ([appDel.login_type isEqualToString:@"FB"])
    {
        NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:@"picture_Url"];
        UIImage *image = [UIImage imageWithData:data];
        self.imageView.image = image;
        UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, [UIScreen mainScreen].scale);
        
        // Add a clip before drawing anything, in the shape of an rounded rect
        [[UIBezierPath bezierPathWithRoundedRect:self.imageView.bounds
                                    cornerRadius:50.0] addClip];
        // Draw your image
        [image drawInRect:self.imageView.bounds];
        
        // Get the image, here setting the UIImageView image
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
    }
    else
    {
        __weak HomeViewController *menu = self;
        UIImage *placeholderImage = [UIImage imageNamed:@"profile.png"];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"picture_Url"]]];
        [self.imageView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
         {
             menu.imageView.image = image;
             
             // Begin a new image that will be the new image with the rounded corners
             // (here with the size of an UIImageView)
             UIGraphicsBeginImageContextWithOptions(menu.imageView.bounds.size, NO, [UIScreen mainScreen].scale);
             
             // Add a clip before drawing anything, in the shape of an rounded rect
             [[UIBezierPath bezierPathWithRoundedRect:menu.imageView.bounds
                                         cornerRadius:60.0] addClip];
             // Draw your image
             [image drawInRect:menu.imageView.bounds];
             
             // Get the image, here setting the UIImageView image
             menu.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
             
             // Lets forget about that we were drawing
             UIGraphicsEndImageContext();
         } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
             
             NSLog(@"%@",error);
             
         }];
    }
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *leaderBoard = @"apimain/leaderboard";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,leaderBoard, nil];
    NSString *api = [NSString pathWithComponents:components];
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
 
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Leaderboard"] && [status isEqualToString:@"success"])
         {
             NSString *strtotalPoints ;
             NSString *login_count;
             NSString *login_points;
             NSString *sharing_count;
             NSString *sharing_points;
             NSString *checkin_count;
             NSString *checkin_points;
             NSString *review_count;
             NSString *review_points;
             NSString *booking_count;
             NSString *booking_points;
             NSString *strid;
             
             NSArray *Leaderboard = [responseObject objectForKey:@"Leaderboard"];
             for (int i = 0; i < [Leaderboard count]; i++)
             {
                 appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                 NSDictionary *dict = [Leaderboard objectAtIndex:i];
                 strtotalPoints = [dict objectForKey:@"total_points"];
                 login_count = [dict objectForKey:@"login_count"];
                 login_points = [dict objectForKey:@"login_points"];
                 sharing_count = [dict objectForKey:@"sharing_count"];
                 sharing_points = [dict objectForKey:@"sharing_points"];
                 checkin_count = [dict objectForKey:@"checkin_count"];
                 checkin_points = [dict objectForKey:@"checkin_points"];
                 review_count = [dict objectForKey:@"review_count"];
                 review_points = [dict objectForKey:@"review_points"];
                 booking_count = [dict objectForKey:@"booking_count"];
                 booking_points = [dict objectForKey:@"booking_points"];
                 strid = [dict objectForKey:@"id"];
                 appDel.user_Id = [dict objectForKey:@"user_id"];
             }
             self.totalPoints.text = [NSString stringWithFormat:@"%@ ( %@ )",@"Total Points",strtotalPoints];
             self.loginCount.text = [NSString stringWithFormat:@"%@ %@ %@ %@" ,@"Login",@"(",login_count,@")"];
             self.loginPoints.text = login_points;
             self.eventShareCount.text =[NSString stringWithFormat:@"%@ %@ %@ %@" ,@"Event share",@"(",sharing_count,@")"];
             self.eventSharePoints.text = sharing_points;
             self.checkInCount.text =[NSString stringWithFormat:@"%@ %@ %@ %@" ,@"Check-In",@"(",checkin_count,@")"];
             self.checkInPoints.text = checkin_points;
             self.reminderCount.text =[NSString stringWithFormat:@"%@ %@ %@ %@" ,@"Review",@"(",review_count,@")"];
             self.reminderPoints.text = review_points;
             self.bookingCount.text =[NSString stringWithFormat:@"%@ %@ %@ %@" ,@"Booking",@"(",booking_count,@")"];
             self.bookingPoints.text = booking_points;
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)menuBtn:(id)sender
{
    MenuViewController *menuviewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self presentViewController:menuviewController animated:NO completion:nil];
}
- (IBAction)floatibgBtn:(id)sender
{
    [self showMenuFromButton:sender withDirection:LSFloatingActionMenuDirectionUp];
}
- (void)showMenuFromButton:(UIButton *)button withDirection:(LSFloatingActionMenuDirection)direction
{
    button.hidden = YES;
    self.tipsLabel.text = @"";
    
    NSArray *menuIcons = @[@"Plusicon",@"Listview",@"Nearby", @"Mapview"];
    NSMutableArray *menus = [NSMutableArray array];
    
    CGSize itemSize = button.frame.size;
    for (NSString *icon in menuIcons)
    {
        LSFloatingActionMenuItem *item = [[LSFloatingActionMenuItem alloc] initWithImage:[UIImage imageNamed:icon] highlightedImage:[UIImage imageNamed:[icon stringByAppendingString:@"_highlighted"]]];
        item.itemSize = itemSize;
        [menus addObject:item];
    }
    
    self.actionMenu = [[LSFloatingActionMenu alloc] initWithFrame:self.view.bounds direction:direction menuItems:menus menuHandler:^(LSFloatingActionMenuItem *item, NSUInteger index)
    {
        if (index == 1)
        {
            self.tipsLabel.text = [NSString stringWithFormat:@"Click at index %d", (int)index];
            self.searchController.searchBar.hidden = YES;
            UIStoryboard *storyboard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HomeViewController *homeviewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            [self.navigationController pushViewController:homeviewController animated:YES];
            mapViewFlag = @"NO";

        }
        else if (index == 2)
        {
            self.tipsLabel.text = [NSString stringWithFormat:@"Click at index %d", (int)index];
            [self performSegueWithIdentifier:@"to_nearby" sender:self];
        }
        else if (index == 3)
        {
            self.navigationItem.rightBarButtonItems = nil;
            self.searchController.searchBar.hidden = YES;
            self.tipsLabel.text = [NSString stringWithFormat:@"Click at index %d", (int)index];
            if ([appDel.event_categoery_Ref isEqualToString:@"general"])
            {
                [_mapView setMapType:MKMapTypeStandard];
                mapViewFlag = @"YES";
                [self loadUserLocation];
            }
            else if ([appDel.event_categoery_Ref isEqualToString:@"popular"])
            {
                [_mapView setMapType:MKMapTypeStandard];
                mapViewFlag = @"YES";
                [self loadUserLocation];
            }
            else if ([appDel.event_categoery_Ref isEqualToString:@"hotspot"])
            {
                [_mapView setMapType:MKMapTypeStandard];
                mapViewFlag = @"YES";
                [self loadUserLocation];
            }
        }
    }
     closeHandler:^{
        [self.actionMenu removeFromSuperview];
        self.actionMenu = nil;
        button.hidden = NO;
    }];
    
    self.actionMenu.itemSpacing = 12;
    self.actionMenu.startPoint = button.center;
    if (button == self.floating)
    {
        self.actionMenu.rotateStartMenu = YES;
    }
    [self.view addSubview:self.actionMenu];
    [self.actionMenu open];
}
- (IBAction)searchBtn:(id)sender;
{
    [self.navigationController presentViewController:self.searchController animated:YES completion:nil];
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResults = [self.eventArray mutableCopy];
    if (![searchText isEqualToString:@""])
    {
        searchFlag = @"YES";
        NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        // break up the search terms (separated by spaces)
        NSArray *searchItems = nil;
        if (strippedString.length > 0)
        {
            searchItems = [strippedString componentsSeparatedByString:@" "];
        }
        NSMutableArray *andMatchPredicates = [NSMutableArray array];
        for (NSString *searchString in searchItems)
        {
            NSMutableArray *searchItemsPredicate = [NSMutableArray array];
            NSExpression *lhs = [NSExpression expressionForKeyPath:@"event_name"];
            NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
            NSPredicate *finalPredicate = [NSComparisonPredicate
                                           predicateWithLeftExpression:lhs
                                           rightExpression:rhs
                                           modifier:NSDirectPredicateModifier
                                           type:NSContainsPredicateOperatorType
                                           options:NSCaseInsensitivePredicateOption];
            [searchItemsPredicate addObject:finalPredicate];
            
            lhs = [NSExpression expressionForKeyPath:@"event_venue"];
            rhs = [NSExpression expressionForConstantValue:searchString];
            finalPredicate = [NSComparisonPredicate
                              predicateWithLeftExpression:lhs
                              rightExpression:rhs
                              modifier:NSDirectPredicateModifier
                              type:NSContainsPredicateOperatorType
                              options:NSCaseInsensitivePredicateOption];
            [searchItemsPredicate addObject:finalPredicate];
            
            NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
            [andMatchPredicates addObject:orMatchPredicates];
        }
        
        // match up the fields of the Product object
        NSCompoundPredicate *finalCompoundPredicate =
        [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
        searchResults = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
        _filterdItems = searchResults;
        [self searchResultValue];
    }
    else
    {
        Eventdetails = searchResults;
        searchFlag = @"NO";
        [self reloadData];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.tableView reloadData];
}
-(void)reloadData
{
    [adv_status removeAllObjects];
    [advertisement removeAllObjects];
    [booking_status removeAllObjects];
    [category_id removeAllObjects];
    [city_name removeAllObjects];
    [contact_email removeAllObjects];
    [contact_person removeAllObjects];
    [country_name removeAllObjects];
    [description removeAllObjects];
    [end_date removeAllObjects];
    [event_address removeAllObjects];
    [event_banner removeAllObjects];
    [event_city removeAllObjects];
    [event_colour_scheme removeAllObjects];
    [event_country removeAllObjects];
    [event_id removeAllObjects];
    [event_latitude removeAllObjects];
    [event_longitude removeAllObjects];
    [event_name removeAllObjects];
    [event_status removeAllObjects];
    [event_type removeAllObjects];
    [event_venue removeAllObjects];
    [hotspot_status removeAllObjects];
    [popularity removeAllObjects];
    [primary_contact_no removeAllObjects];
    [secondary_contact_no removeAllObjects];
    [start_date removeAllObjects];
    [start_time removeAllObjects];
    [end_time removeAllObjects];
    
    for(int i = 0;i < [Eventdetails count];i++)
    {
        NSDictionary *dict = [Eventdetails objectAtIndex:i];
        NSString *strAdv_status = [dict objectForKey:@"adv_status"];
        NSString *strAdvertisement = [dict objectForKey:@"advertisement"];
        NSString *strBooking_status = [dict objectForKey:@"booking_status"];
        NSString *strCategory_id = [dict objectForKey:@"category_id"];
        NSString *strCity_name = [dict objectForKey:@"city_name"];
        NSString *strContact_email = [dict objectForKey:@"contact_email"];
        NSString *strContact_person = [dict objectForKey:@"contact_person"];
        NSString *strCountry_name = [dict objectForKey:@"country_name"];
        NSString *strDescription = [dict objectForKey:@"description"];
        NSString *strEnd_date = [dict objectForKey:@"end_date"];
        NSString *strEvent_address = [dict objectForKey:@"event_address"];
        NSString *strEvent_banner = [dict objectForKey:@"event_banner"];
        NSString *strEvent_city = [dict objectForKey:@"event_city"];
        NSString *strEvent_colour_scheme = [dict objectForKey:@"event_colour_scheme"];
        NSString *strEvent_country = [dict objectForKey:@"event_country"];
        NSString *strEvent_id = [dict objectForKey:@"event_id"];
        NSString *strEvent_latitude = [dict objectForKey:@"event_latitude"];
        NSString *strEvent_longitude = [dict objectForKey:@"event_longitude"];
        NSString *strEvent_name = [dict objectForKey:@"event_name"];
        NSString *strEvent_status = [dict objectForKey:@"event_status"];
        NSString *strEvent_type = [dict objectForKey:@"event_type"];
        NSString *strEvent_venue = [dict objectForKey:@"event_venue"];
        NSString *stHotspot_status = [dict objectForKey:@"hotspot_status"];
        NSString *strPopularity = [dict objectForKey:@"popularity"];
        NSString *strPrimary_contact_no = [dict objectForKey:@"primary_contact_no"];
        NSString *strSecondary_contact_no = [dict objectForKey:@"secondary_contact_no"];
        NSString *strStart_date = [dict objectForKey:@"start_date"];
        NSString *strStart_time = [dict objectForKey:@"start_time"];
        NSString *strEnd_time = [dict objectForKey:@"end_time"];
        
        [adv_status addObject:strAdv_status];
        [advertisement addObject:strAdvertisement];
        [booking_status addObject:strBooking_status];
        [category_id addObject:strCategory_id];
        [city_name addObject:strCity_name];
        [contact_email addObject:strContact_email];
        [contact_person addObject:strContact_person];
        [country_name addObject:strCountry_name];
        [description addObject:strDescription];
        [end_date addObject:strEnd_date];
        [event_address addObject:strEvent_address];
        [event_banner addObject:strEvent_banner];
        [event_city addObject:strEvent_city];
        [event_colour_scheme addObject:strEvent_colour_scheme];
        [event_country addObject:strEvent_country];
        [event_id addObject:strEvent_id];
        [event_latitude addObject:strEvent_latitude];
        [event_longitude addObject:strEvent_longitude];
        [event_name addObject:strEvent_name];
        [event_status addObject:strEvent_status];
        [event_type addObject:strEvent_type];
        [event_venue addObject:strEvent_venue];
        [hotspot_status addObject:stHotspot_status];
        [popularity addObject:strPopularity];
        [primary_contact_no addObject:strPrimary_contact_no];
        [secondary_contact_no addObject:strSecondary_contact_no];
        [start_date addObject:strStart_date];
        [start_time addObject:strStart_time];
        [end_time addObject:strEnd_time];
    }
    [self.tableView reloadData];
}
-(void)searchResultValue
{
    [adv_status removeAllObjects];
    [advertisement removeAllObjects];
    [booking_status removeAllObjects];
    [category_id removeAllObjects];
    [city_name removeAllObjects];
    [contact_email removeAllObjects];
    [contact_person removeAllObjects];
    [country_name removeAllObjects];
    [description removeAllObjects];
    [end_date removeAllObjects];
    [event_address removeAllObjects];
    [event_banner removeAllObjects];
    [event_city removeAllObjects];
    [event_colour_scheme removeAllObjects];
    [event_country removeAllObjects];
    [event_id removeAllObjects];
    [event_latitude removeAllObjects];
    [event_longitude removeAllObjects];
    [event_name removeAllObjects];
    [event_status removeAllObjects];
    [event_type removeAllObjects];
    [event_venue removeAllObjects];
    [hotspot_status removeAllObjects];
    [popularity removeAllObjects];
    [primary_contact_no removeAllObjects];
    [secondary_contact_no removeAllObjects];
    [start_date removeAllObjects];
    [start_time removeAllObjects];
    [end_time removeAllObjects];
    
    for(int i = 0;i < [_filterdItems count];i++)
    {
        NSDictionary *dict = [_filterdItems objectAtIndex:i];
        NSString *strAdv_status = [dict objectForKey:@"adv_status"];
        NSString *strAdvertisement = [dict objectForKey:@"advertisement"];
        NSString *strBooking_status = [dict objectForKey:@"booking_status"];
        NSString *strCategory_id = [dict objectForKey:@"category_id"];
        NSString *strCity_name = [dict objectForKey:@"city_name"];
        NSString *strContact_email = [dict objectForKey:@"contact_email"];
        NSString *strContact_person = [dict objectForKey:@"contact_person"];
        NSString *strCountry_name = [dict objectForKey:@"country_name"];
        NSString *strDescription = [dict objectForKey:@"description"];
        NSString *strEnd_date = [dict objectForKey:@"end_date"];
        NSString *strEvent_address = [dict objectForKey:@"event_address"];
        NSString *strEvent_banner = [dict objectForKey:@"event_banner"];
        NSString *strEvent_city = [dict objectForKey:@"event_city"];
        NSString *strEvent_colour_scheme = [dict objectForKey:@"event_colour_scheme"];
        NSString *strEvent_country = [dict objectForKey:@"event_country"];
        NSString *strEvent_id = [dict objectForKey:@"event_id"];
        NSString *strEvent_latitude = [dict objectForKey:@"event_latitude"];
        NSString *strEvent_longitude = [dict objectForKey:@"event_longitude"];
        NSString *strEvent_name = [dict objectForKey:@"event_name"];
        NSString *strEvent_status = [dict objectForKey:@"event_status"];
        NSString *strEvent_type = [dict objectForKey:@"event_type"];
        NSString *strEvent_venue = [dict objectForKey:@"event_venue"];
        NSString *stHotspot_status = [dict objectForKey:@"hotspot_status"];
        NSString *strPopularity = [dict objectForKey:@"popularity"];
        NSString *strPrimary_contact_no = [dict objectForKey:@"primary_contact_no"];
        NSString *strSecondary_contact_no = [dict objectForKey:@"secondary_contact_no"];
        NSString *strStart_date = [dict objectForKey:@"start_date"];
        NSString *strStart_time = [dict objectForKey:@"start_time"];
        NSString *strEnd_time = [dict objectForKey:@"end_time"];
        
        [adv_status addObject:strAdv_status];
        [advertisement addObject:strAdvertisement];
        [booking_status addObject:strBooking_status];
        [category_id addObject:strCategory_id];
        [city_name addObject:strCity_name];
        [contact_email addObject:strContact_email];
        [contact_person addObject:strContact_person];
        [country_name addObject:strCountry_name];
        [description addObject:strDescription];
        [end_date addObject:strEnd_date];
        [event_address addObject:strEvent_address];
        [event_banner addObject:strEvent_banner];
        [event_city addObject:strEvent_city];
        [event_colour_scheme addObject:strEvent_colour_scheme];
        [event_country addObject:strEvent_country];
        [event_id addObject:strEvent_id];
        [event_latitude addObject:strEvent_latitude];
        [event_longitude addObject:strEvent_longitude];
        [event_name addObject:strEvent_name];
        [event_status addObject:strEvent_status];
        [event_type addObject:strEvent_type];
        [event_venue addObject:strEvent_venue];
        [hotspot_status addObject:stHotspot_status];
        [popularity addObject:strPopularity];
        [primary_contact_no addObject:strPrimary_contact_no];
        [secondary_contact_no addObject:strSecondary_contact_no];
        [start_date addObject:strStart_date];
        [start_time addObject:strStart_time];
        [end_time addObject:strEnd_time];
    }
    [self.tableView reloadData];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
- (IBAction)advanceFilterBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AdvanceFilterViewController *advancefilterViewController = (AdvanceFilterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdvanceFilterViewController"];
    [self.navigationController pushViewController:advancefilterViewController animated:YES];
}
- (IBAction)leaderBoardReviewBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"Review" forKey:@"LeaderBoardType"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    LeaderBoardPointsViewController *leaderBoardPointsViewController = (LeaderBoardPointsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LeaderBoardPointsViewController"];
    [self.navigationController pushViewController:leaderBoardPointsViewController animated:YES];
}
- (IBAction)leaderbookingBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"Booking" forKey:@"LeaderBoardType"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    LeaderBoardPointsViewController *leaderBoardPointsViewController = (LeaderBoardPointsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LeaderBoardPointsViewController"];
    [self.navigationController pushViewController:leaderBoardPointsViewController animated:YES];
}
- (IBAction)leaderBoardCheckInBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"CheckIn" forKey:@"LeaderBoardType"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    LeaderBoardPointsViewController *leaderBoardPointsViewController = (LeaderBoardPointsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LeaderBoardPointsViewController"];
    [self.navigationController pushViewController:leaderBoardPointsViewController animated:YES];
}
- (IBAction)leaderBoardeventShareBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"Share" forKey:@"LeaderBoardType"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    LeaderBoardPointsViewController *leaderBoardPointsViewController = (LeaderBoardPointsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LeaderBoardPointsViewController"];
    [self.navigationController pushViewController:leaderBoardPointsViewController animated:YES];
}
- (IBAction)leaderBoardLoginBtn:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"LeaderBoardType"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    LeaderBoardLoginPointsViewController *leaderBoardLoginPointsViewController = (LeaderBoardLoginPointsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LeaderBoardLoginPointsViewController"];
    [self presentViewController:leaderBoardLoginPointsViewController animated:YES completion:Nil];
}
@end
