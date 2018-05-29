//
//  SelectCityPageViewController.m
//  Heylaapp
//
//  Created by HappySanz on 13/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "SelectCityPageViewController.h"

@interface SelectCityPageViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *city_Latitude;
    NSMutableArray *city_Longitude;
    NSMutableArray *city_Name;
    NSMutableArray *city_Id;
    CLLocationManager *objLocationManager;
    double latitude_UserLocation, longitude_UserLocation;
    NSString *address;

}
@end

@implementation SelectCityPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    city_Latitude = [[NSMutableArray alloc]init];
    city_Longitude = [[NSMutableArray alloc]init];
    city_Name = [[NSMutableArray alloc]init];
    city_Id = [[NSMutableArray alloc]init];
//    if ([objLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
//    {
//        [objLocationManager requestWhenInUseAuthorization];
//    }
//    [objLocationManager startUpdatingLocation];
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
//    [geocoder reverseGeocodeLocation:objLocationManager.location
//                   completionHandler:^(NSArray *placemarks, NSError *error)
//     {
//         NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
//         if (error)
//         {
//             NSLog(@"Geocode failed with error: %@", error);
//             return;
//         }
//         CLPlacemark *placemark = [placemarks objectAtIndex:0];
//         self->address = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",
//                          placemark.thoroughfare,
//                          placemark.locality,
//                          placemark.subLocality,
//                          placemark.administrativeArea,
//                          placemark.postalCode,
//                          placemark.country];
//         NSLog(@"%@", self->address);
//         NSArray *splitArray = [self->address componentsSeparatedByString:@","];
//         NSString *locatedCity = [splitArray objectAtIndex:1];
//         [[NSUserDefaults standardUserDefaults]setObject:locatedCity forKey:@"locatedCity"];
//
//     }];
    [self loadUserLocation];
    self.tableView.hidden = YES;
    appDel.user_Id = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_id"];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *selectAllCity = @"apimain/selectallcity";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,selectAllCity, nil];
    NSString *api = [NSString pathWithComponents:components];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Cities"] && [status isEqualToString:@"success"])
         {
             NSArray *cities = [responseObject objectForKey:@"Cities"];
             [MBProgressHUD hideHUDForView:self.view animated:YES];

             [self->city_Latitude removeAllObjects];
             [self->city_Longitude removeAllObjects];
             [self->city_Name removeAllObjects];
             [self->city_Id removeAllObjects];
             
             for (int i =0; i < [cities count]; i++)
             {
                 NSDictionary *dict = [cities objectAtIndex:i];
                 NSString *strCity_latitude = [dict objectForKey:@"city_latitude"];
                 NSString *strCity_longitude = [dict objectForKey:@"city_longitude"];
                 NSString *strCity_name = [dict objectForKey:@"city_name"];
                 NSString *strId = [dict objectForKey:@"id"];
                 
                 [self->city_Latitude addObject:strCity_latitude];
                 [self->city_Longitude addObject:strCity_longitude];
                 [self->city_Name addObject:strCity_name];
                 [self->city_Id addObject:strId];

             }
             [[NSUserDefaults standardUserDefaults]setObject:self->city_Name forKey:@"cityName_Array"];
             [[NSUserDefaults standardUserDefaults]setObject:self->city_Id forKey:@"cityID_Array"];
             self.tableView.hidden = NO;
             [self.tableView reloadData];

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

    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"cityPage"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}
- (void)loadUserLocation
{
    objLocationManager = [[CLLocationManager alloc] init];
    objLocationManager.delegate = self;
    objLocationManager.distanceFilter = kCLDistanceFilterNone;
    objLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
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
     NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
     NSLog(@"%@",newLocation);
     [objLocationManager stopUpdatingLocation];
     CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
     [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSString *address = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@",
                                  placemark.thoroughfare,
                                  placemark.locality,
                                  placemark.subLocality,
                                  placemark.administrativeArea,
                                  placemark.postalCode,
                                  placemark.country];
             NSLog(@"%@", address);
             NSArray *splitArray = [address componentsSeparatedByString:@","];
             NSString *City = [splitArray objectAtIndex:1];
             NSArray *spiltSpace = [City componentsSeparatedByString:@" "];
             NSString *locatedCity = [spiltSpace objectAtIndex:1];
             [[NSUserDefaults standardUserDefaults]setObject:locatedCity forKey:@"locatedCity"];
         }
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [city_Latitude count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCityTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.cityLabel.text = [city_Name objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    SelectCityTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    appDel.selected_City = [city_Name objectAtIndex:indexPath.row];
    NSLog(@"%@",appDel.selected_City);
    NSUInteger city_Longitude_Index = [city_Name indexOfObject:appDel.selected_City];
    appDel.selected_City_Latittude = city_Latitude[city_Longitude_Index];
    
    NSUInteger city_Latitude_Index = [city_Name indexOfObject:appDel.selected_City];
    appDel.selected_City_Longitude = city_Longitude[city_Latitude_Index];
    
    NSUInteger city_Id_Index = [city_Name indexOfObject:appDel.selected_City];
    appDel.selected_City_Id = city_Id[city_Id_Index];
    NSLog(@"%@",appDel.selected_City_Id);
    [[NSUserDefaults standardUserDefaults]setObject:appDel.selected_City_Id forKey:@"stat_city_id"];
    [self performSegueWithIdentifier:@"to_categoeryView" sender:self];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
