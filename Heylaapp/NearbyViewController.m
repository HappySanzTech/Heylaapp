//
//  NearbyViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 02/02/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "NearbyViewController.h"
#import "LSFloatingActionMenu.h"

@interface NearbyViewController ()
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
    CLLocationManager *objLocationManager;
    UIPickerView *listpickerView;
    UIToolbar *listToolBar;
    NSArray *ditanceArr;
    NSString *selectedDistance;
    double latitude_UserLocation, longitude_UserLocation;
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
    NSString *mapViewFlag;

}
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;
@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation NearbyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    _distanceTxtfield.layer.borderColor = [UIColor blackColor].CGColor;
    _distanceTxtfield.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    _distanceTxtfield.layer.borderWidth = 1.0f;
    [_distanceTxtfield.layer setCornerRadius:05.0f];
    ditanceArr =[NSArray arrayWithObjects:@"Select Your Distance",@"5 Kms",@"10 Kms",@"15 Kms",@"35 Kms", nil];
    listpickerView = [[UIPickerView alloc] init];
    listpickerView.delegate = self;
    listpickerView.dataSource = self;
    [self.distanceTxtfield setInputView:listpickerView];
    listToolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [listToolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SelectedDistance)];
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButton)];
    UIBarButtonItem *spacePicker=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [listToolBar setItems:[NSArray arrayWithObjects:cancel,spacePicker,done, nil]];
    [self.distanceTxtfield setInputAccessoryView:listToolBar];
    mapViewFlag = @"0";
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
    [listpickerView reloadAllComponents];
    [self loadUserLocation];
    self.nearbyImageView.hidden = NO;
    self.tableView.hidden = YES;

}
- (void)loadUserLocation
{
    if([mapViewFlag isEqualToString:@"YES"])
    {
        _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
        [self.tableView addSubview:_mapView];
        objLocationManager = [[CLLocationManager alloc] init];
        objLocationManager.delegate = self;
        objLocationManager.distanceFilter = kCLDistanceFilterNone;
        objLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        if ([objLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [objLocationManager requestWhenInUseAuthorization];
        }
    }
    else
    {
        objLocationManager = [[CLLocationManager alloc] init];
        objLocationManager.delegate = self;
        objLocationManager.distanceFilter = kCLDistanceFilterNone;
        objLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        if ([objLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [objLocationManager requestWhenInUseAuthorization];
        }
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
    [objLocationManager stopUpdatingLocation];
    if ([mapViewFlag isEqualToString:@"YES"])
    {
        [self loadMapView];

    }
    if ([mapViewFlag isEqualToString:@"NO"])
    {
        [self loadvalues];

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
- (void)loadMapView
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
#pragma mark - UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == listpickerView)
    {
        return 1;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.distanceTxtfield isFirstResponder])
        {
            return [ditanceArr count];
        }
    }
    return 0;
    
}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.distanceTxtfield isFirstResponder])
        {
            return ditanceArr[row];
        }
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.distanceTxtfield isFirstResponder])
        {
            selectedDistance = ditanceArr[row];
        }
    }
}
-(void)SelectedDistance
{
    if ([self.distanceTxtfield isFirstResponder])
    {
        if (appDel.user_currentLatitude.length == 0)
        {
             [self loadUserLocation];
            [self.distanceTxtfield resignFirstResponder];

        }
        else if (appDel.user_currentLongitude.length == 0)
        {
            [self loadUserLocation];
            [self.distanceTxtfield resignFirstResponder];

        }
        else
        {
            [self loadvalues];
            self.distanceTxtfield.text = selectedDistance;
            [self.distanceTxtfield resignFirstResponder];
            mapViewFlag = @"NO";
        }
        
    }
}
-(void)CancelButton
{
    if ([self.distanceTxtfield isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.distanceTxtfield resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
            
}
-(void)loadvalues
{
    if ([self.distanceTxtfield.text isEqualToString:@"Select Your Distance"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please select your distance"
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
    else if(appDel.user_currentLatitude.length == 0)
    {
        [listpickerView removeFromSuperview];
        [self.distanceTxtfield resignFirstResponder];
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please go to the settings and Turn On your location service"
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
    else if(appDel.user_currentLongitude.length == 0)
    {
        [listpickerView removeFromSuperview];
        [self.distanceTxtfield resignFirstResponder];
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please go to the settings and Turn On your location service"
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
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.event_type forKey:@"event_type"];
        [parameters setObject:appDel.user_Id forKey:@"user_id"];
        [parameters setObject:appDel.user_type forKey:@"user_type"];
        [parameters setObject:appDel.user_currentLatitude forKey:@"latitude"];
        [parameters setObject:appDel.user_currentLongitude forKey:@"longitude"];
        [parameters setObject:selectedDistance forKey:@"nearby_distance"];
        [parameters setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"stat_city_id"] forKey:@"city_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString *viewEvents = @"apimain/nearBy";
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
                 self->Eventdetails = [responseObject objectForKey:@"Eventdetails"];
                 [self->adv_status removeAllObjects];
                 [self->advertisement removeAllObjects];
                 [self->booking_status removeAllObjects];
                 [self->category_id removeAllObjects];
                 [self->city_name removeAllObjects];
                 [self->contact_email removeAllObjects];
                 [self->contact_person removeAllObjects];
                 [self->country_name removeAllObjects];
                 [self->description removeAllObjects];
                 [self->end_date removeAllObjects];
                 [self->event_address removeAllObjects];
                 [self->event_banner removeAllObjects];
                 [self->event_city removeAllObjects];
                 [self->event_colour_scheme removeAllObjects];
                 [self->event_country removeAllObjects];
                 [self->event_id removeAllObjects];
                 [self->event_latitude removeAllObjects];
                 [self->event_longitude removeAllObjects];
                 [self->event_name removeAllObjects];
                 [self->event_status removeAllObjects];
                 [self->event_type removeAllObjects];
                 [self->event_venue removeAllObjects];
                 [self->hotspot_status removeAllObjects];
                 [self->popularity removeAllObjects];
                 [self->primary_contact_no removeAllObjects];
                 [self->secondary_contact_no removeAllObjects];
                 [self->start_date removeAllObjects];
                 [self->start_time removeAllObjects];
                 [self->end_time removeAllObjects];
                 
                 for(int i = 0;i < [self->Eventdetails count];i++)
                 {
                     NSDictionary *dict = [self->Eventdetails objectAtIndex:i];
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
                     
                     self->dateFormatter = [[NSDateFormatter alloc] init];
                     [self->dateFormatter setDateFormat:@"yyyy-MM-dd"];
                     self->date = [[NSDate alloc] init];
                     self->date = [self->dateFormatter dateFromString:strStart_date];
                     // converting into our required date format
                     [self->dateFormatter setDateFormat:@"dd MMM yyyy"];
                     self->reqDateString = [self->dateFormatter stringFromDate:self->date];
                     NSLog(@"date is %@",self->reqDateString);
                     
                     self->dateFormatter = [[NSDateFormatter alloc] init];
                     [self->dateFormatter setDateFormat:@"yyyy-MM-dd"];
                     self->date = [[NSDate alloc] init];
                     self->date = [self->dateFormatter dateFromString:strend_date];
                     // converting into our required date format
                     [self->dateFormatter setDateFormat:@"MMMM dd yyyy"];
                     self->reqDateString = [self->dateFormatter stringFromDate:self->date];
                     NSLog(@"date is %@",self->reqDateString);
                     
                     
                     [self->adv_status addObject:strAdv_status];
                     [self->advertisement addObject:strAdvertisement];
                     [self->booking_status addObject:strBooking_status];
                     [self->category_id addObject:strCategory_id];
                     [self->city_name addObject:strCity_name];
                     [self->contact_email addObject:strContact_email];
                     [self->contact_person addObject:strContact_person];
                     [self->country_name addObject:strCountry_name];
                     [self->description addObject:strDescription];
                     [self->end_date addObject:strEnd_date];
                     [self->event_address addObject:strEvent_address];
                     [self->event_banner addObject:strEvent_banner];
                     [self->event_city addObject:strEvent_city];
                     [self->event_colour_scheme addObject:strEvent_colour_scheme];
                     [self->event_country addObject:strEvent_country];
                     [self->event_id addObject:strEvent_id];
                     [self->event_latitude addObject:strEvent_latitude];
                     [self->event_longitude addObject:strEvent_longitude];
                     [self->event_name addObject:strEvent_name];
                     [self->event_status addObject:strEvent_status];
                     [self->event_type addObject:strEvent_type];
                     [self->event_venue addObject:strEvent_venue];
                     [self->hotspot_status addObject:stHotspot_status];
                     [self->popularity addObject:strPopularity];
                     [self->primary_contact_no addObject:strPrimary_contact_no];
                     [self->secondary_contact_no addObject:strSecondary_contact_no];
                     [self->start_date addObject:strStart_date];
                     [self->start_time addObject:strStart_time];
                     [self->end_time addObject:strEnd_time];
                 }
                 
                 if ([self->mapViewFlag isEqualToString:@"YES"])
                 {
                     self->_mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
                     [self.tableView addSubview:self->_mapView];
                     [self loadUserLocation];
                 }
                 else
                 {
                     self.mapView.hidden = YES;
                     self.nearbyImageView.hidden = YES;
                     self.tableView.hidden = NO;
                     [self.tableView reloadData];
                     
                 }
             }
             else
             {
                 self.tableView.hidden = YES;
                 self.nearbyImageView.hidden = NO;
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
- (void)didReceiveMemoryWarning {
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Eventdetails count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mapViewFlag = @"NO";
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([appDel.event_type isEqualToString:@"Hotspot"])
    {
        HomeViewTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.eventName.text = [event_name objectAtIndex:indexPath.row];
        cell.eventTime.text = [event_venue objectAtIndex:indexPath.row]; ;
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
        
        cell.eventStatus.text = [event_type objectAtIndex:indexPath.row];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        return cell;
    }
    else
    {
        HomeViewTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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
        
        cell.eventStatus.text = [event_type objectAtIndex:indexPath.row];
        cell.eventTime.text = [NSString stringWithFormat:@"%@ - %@",[start_date objectAtIndex:indexPath.row],[end_date objectAtIndex:indexPath.row]];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.event_Name = [event_name objectAtIndex:indexPath.row];
    appDel.event_StartTime = [start_time objectAtIndex:indexPath.row];
    appDel.event_StartDate = [start_date objectAtIndex:indexPath.row];
    appDel.event_Address = [event_venue objectAtIndex:indexPath.row];
    
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
    
    NSUInteger event_idInt = [event_name indexOfObject:appDel.event_Name];
    appDel.event_id = event_id[event_idInt];
    
    NSUInteger intbooking_status = [event_name indexOfObject:appDel.event_Name];
    appDel.booking_status = booking_status[intbooking_status];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EventDetailViewController *eventDetail = [storyboard instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
    [self.navigationController pushViewController:eventDetail animated:YES];
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
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)nearbyBtn:(id)sender
{
    [self showMenuFromButton:sender withDirection:LSFloatingActionMenuDirectionUp];
}
- (void)showMenuFromButton:(UIButton *)button withDirection:(LSFloatingActionMenuDirection)direction
{
    button.hidden = YES;
    self.tipsLabel.text = @"";
    NSArray *menuIcons = @[@"Plusicon",@"Listview",@"Mapview"];
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
                               if ([self.distanceTxtfield.text isEqualToString:@""])
                               {
                                   UIAlertController *alert= [UIAlertController
                                                              alertControllerWithTitle:@"Heyla"
                                                              message:@"Select your distance"
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
                               else
                               {
                                   self.tipsLabel.text = [NSString stringWithFormat:@"Click at index %d", (int)index];
                                   self->mapViewFlag = @"NO";
                                   [self loadUserLocation];
                               }
                           }
                           else if (index == 2)
                           {
                               if (self->selectedDistance.length == 0)
                               {
                                   
                                   UIAlertController *alert= [UIAlertController
                                                              alertControllerWithTitle:@"Heyla"
                                                              message:@"Select your distance"
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
                               else
                               {
                                   self.tipsLabel.text = [NSString stringWithFormat:@"Click at index %d", (int)index];
                                   [self->_mapView setMapType:MKMapTypeStandard];
                                   self->mapViewFlag = @"YES";
                                   [self loadUserLocation];
                               }

                           }
                       }
                        closeHandler:
                       ^{
                             [self.actionMenu removeFromSuperview];
                             self.actionMenu = nil;
                             button.hidden = NO;
                        }];
    self.actionMenu.itemSpacing = 12;
    self.actionMenu.startPoint = button.center;
    if (button == self.nearbyOtlet)
    {
        self.actionMenu.rotateStartMenu = YES;
    }
    [self.view addSubview:self.actionMenu];
    [self.actionMenu open];
}
@end
