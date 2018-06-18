//
//  AdvanceFilterResultViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 18/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "AdvanceFilterResultViewController.h"

@interface AdvanceFilterResultViewController ()
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
}
@end

@implementation AdvanceFilterResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
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
    date_label = [[NSMutableArray alloc]init];
    month_label = [[NSMutableArray alloc]init];
    
    
    Eventdetails = [[NSUserDefaults standardUserDefaults]objectForKey:@"eventList_AdvSearch"];
    
    [adv_status removeAllObjects];
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
    
    for(int i = 0;i < [Eventdetails count];i++)
    {
        NSDictionary *dict = [Eventdetails objectAtIndex:i];
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
        NSString *stHotspot_status = [dict objectForKey:@"hotspot_status"];
        NSString *strPopularity = [dict objectForKey:@"popularity"];
        NSString *strPrimary_contact_no = [dict objectForKey:@"primary_contact_no"];
        NSString *strSecondary_contact_no = [dict objectForKey:@"secondary_contact_no"];
        NSString *strStart_date = [dict objectForKey:@"start_date"];
        NSString *strStart_time = [dict objectForKey:@"start_time"];
        NSString *strEnd_time = [dict objectForKey:@"end_time"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [[NSDate alloc] init];
        date = [dateFormatter dateFromString:strStart_date];
        // converting into our required date format
        [dateFormatter setDateFormat:@"EEEE, MMM dd, yyyy"];
        NSString *reqDateString = [dateFormatter stringFromDate:date];
        NSLog(@"date is %@", reqDateString);
        
        NSArray *testArray = [reqDateString componentsSeparatedByString:@" "];
        NSString *strdate = [testArray objectAtIndex:1];
        NSString *strMonth = [testArray objectAtIndex:2];
        
        [adv_status addObject:strAdv_status];
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
    }
    [self.tableView  reloadData];
}
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
    HomeViewTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  
        cell.eventName.text = [event_name objectAtIndex:indexPath.row];
        cell.dateLabel.text = [date_label objectAtIndex:indexPath.row];
        cell.monthLabel.text = [month_label objectAtIndex:indexPath.row];
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
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
    
    NSUInteger event_idInt = [event_name indexOfObject:appDel.event_Name];
    appDel.event_id = event_id[event_idInt];
    
    NSUInteger intbooking_status = [event_name indexOfObject:appDel.event_Name];
    appDel.booking_status = booking_status[intbooking_status];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"advnce_filter"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EventDetailViewController *eventDetail = [storyboard instantiateViewControllerWithIdentifier:@"EventDetailViewController"];
    [self.navigationController pushViewController:eventDetail animated:self];
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

- (IBAction)backBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AdvanceFilterViewController *advanceFilterViewController = (AdvanceFilterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdvanceFilterViewController"];
    [self.navigationController pushViewController:advanceFilterViewController animated:YES];
}
@end
