//
//  WhishListViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 20/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "WhishListViewController.h"

@interface WhishListViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *adv_status;
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
    NSMutableArray *wishlist_id;
    NSArray *EventdetailsArr;
}
@end

@implementation WhishListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    adv_status = [[NSMutableArray alloc]init];
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
    wishlist_id = [[NSMutableArray alloc]init];
    [self whistList];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}
-(void)whistList
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];http:
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    [parameters setObject:@"1" forKey:@"wishlist_master_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *viewWishList = @"apimain/viewWishList";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,viewWishList, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
         self->appDel.review_id = [responseObject objectForKey:@"review_id"];
         
         if ([msg isEqualToString:@"View Wishlist"] && [status isEqualToString:@"success"])
         {
             self->EventdetailsArr = [responseObject objectForKey:@"Eventdetails"];
             
             [self->adv_status removeAllObjects];
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
             
             for (int i = 0; i < [self->EventdetailsArr count]; i++)
             {
                 NSDictionary *dict = [self->EventdetailsArr objectAtIndex:i];
                 NSString *strAdv_status = [dict objectForKey:@"adv_status"];
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
                 NSString *strHotspot_status = [dict objectForKey:@"hotspot_status"];
                 NSString *strPopularity = [dict objectForKey:@"popularity"];
                 NSString *strPrimary_contact_no = [dict objectForKey:@"primary_contact_no"];
                 NSString *strSecondary_contact_no = [dict objectForKey:@"secondary_contact_no"];
                 NSString *strStart_date = [dict objectForKey:@"start_date"];
                 NSString *strStart_time = [dict objectForKey:@"start_time"];
                 NSString *strEnd_time = [dict objectForKey:@"end_time"];
                 NSString *strWishlist_id = [dict objectForKey:@"wishlist_id"];
                 
                 
                 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                 NSDate *date = [[NSDate alloc] init];
                 date = [dateFormatter dateFromString:strStart_date];
                 // converting into our required date format
                 [dateFormatter setDateFormat:@"MMMM dd yyyy"];
                 NSString *reqDateString = [dateFormatter stringFromDate:date];
                 NSLog(@"date is %@", reqDateString);
                 
                 [self->adv_status addObject:strAdv_status];
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
                 [self->hotspot_status addObject:strHotspot_status];
                 [self->popularity addObject:strPopularity];
                 [self->primary_contact_no addObject:strPrimary_contact_no];
                 [self->secondary_contact_no addObject:strSecondary_contact_no];
                 [self->start_date addObject:strStart_date];
                 [self->start_time addObject:strStart_time];
                 [self->end_time addObject:strEnd_time];
                 [self->wishlist_id addObject:strWishlist_id];
                 
             }
             self.tableView.hidden = NO;
             [self.tableView reloadData];
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
    return [EventdetailsArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *strhotSpot = [hotspot_status objectAtIndex:indexPath.row];
    if ([strhotSpot isEqualToString:@"Y"])
    {
        HomeViewTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.eventName.text = [event_name objectAtIndex:indexPath.row];
        cell.eventTime.text = [event_venue objectAtIndex:indexPath.row];
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
        cell.eventTime.text = [NSString stringWithFormat:@"%@ %@",[start_date objectAtIndex:indexPath.row],[end_date objectAtIndex:indexPath.row]];
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
        cell.eventStatus.text = [event_type objectAtIndex:indexPath.row];
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
    EventDetailViewController *eventDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
    [self.navigationController pushViewController:eventDetailViewController animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSString *strWishList = [wishlist_id objectAtIndex:indexPath.row];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];http:
        [parameters setObject:appDel.user_Id forKey:@"user_id"];
        [parameters setObject:strWishList forKey:@"wishlist_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString *deleteWishList = @"apimain/deleteWishList";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,deleteWishList, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
//           self->appDel.review_id = [responseObject objectForKey:@"review_id"];
             
             if ([msg isEqualToString:@"Wishlist Deleted"] && [status isEqualToString:@"success"])
             {
                 [self whistList];
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
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
//    [navigationController setViewControllers:@[[storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"]]];
//
//    SideMenuMainViewController *sideMenuMainViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SideMenuMainViewController"]; //or
//    sideMenuMainViewController.rootViewController = navigationController;
//    [sideMenuMainViewController setupWithType:0];
//    self.window.rootViewController = navigationController;
//    [self.window makeKeyAndVisible];
//
//    UIWindow *window = UIApplication.sharedApplication.delegate.window;
//    window.rootViewController = sideMenuMainViewController;
//
//    [UIView transitionWithView:window
//                      duration:0.3
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:nil
//                    completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
