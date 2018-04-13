//
//  BookingHistoryViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 18/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "BookingHistoryViewController.h"

@interface BookingHistoryViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *category_name;
    NSMutableArray *created_at;
    NSMutableArray *event_address;
    NSMutableArray *event_colour_scheme;
    NSMutableArray *event_id;
    NSMutableArray *event_name;
    NSMutableArray *event_venue;
    NSMutableArray *_id;
    NSMutableArray *number_of_seats;
    NSMutableArray *order_id;
    NSMutableArray *plan_name;
    NSMutableArray *show_date;
    NSMutableArray *show_time;
    NSMutableArray *total_amount;
}
@end

@implementation BookingHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    category_name = [[NSMutableArray alloc]init];
    created_at = [[NSMutableArray alloc]init];
    event_address = [[NSMutableArray alloc]init];
    event_colour_scheme = [[NSMutableArray alloc]init];
    event_id = [[NSMutableArray alloc]init];
    event_name = [[NSMutableArray alloc]init];
    event_venue = [[NSMutableArray alloc]init];
    _id = [[NSMutableArray alloc]init];
    number_of_seats = [[NSMutableArray alloc]init];
    order_id = [[NSMutableArray alloc]init];
    plan_name = [[NSMutableArray alloc]init];
    show_time = [[NSMutableArray alloc]init];
    show_date = [[NSMutableArray alloc]init];
    total_amount = [[NSMutableArray alloc]init];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *bookinghistory = @"apimain/bookingHistory";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,bookinghistory, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         if ([msg isEqualToString:@"View Booking History"] && [status isEqualToString:@"success"])
         {
             [category_name removeAllObjects];
             [created_at removeAllObjects];
             [event_address removeAllObjects];
             [event_colour_scheme removeAllObjects];
             [event_id removeAllObjects];
             [event_name removeAllObjects];
             [event_venue removeAllObjects];
             [_id removeAllObjects];
             [number_of_seats removeAllObjects];
             [order_id removeAllObjects];
             [plan_name removeAllObjects];
             [show_date removeAllObjects];
             [show_time removeAllObjects];
             [total_amount removeAllObjects];
             
             NSArray *Bookinghistory = [responseObject objectForKey:@"Bookinghistory"];
             for (int i = 0; i < [Bookinghistory count]; i++)
             {
                 NSDictionary *dict = [Bookinghistory objectAtIndex:i];
                 NSString *strcategry_name = [dict objectForKey:@"category_name"];
                 NSString *strcreated_at = [dict objectForKey:@"created_at"];
                 NSString *strcategry_event_addressname = [dict objectForKey:@"event_address"];
                 NSString *strevent_colour_scheme = [dict objectForKey:@"event_colour_scheme"];
                 NSString *strevent_id = [dict objectForKey:@"event_id"];
                 NSString *strevent_name = [dict objectForKey:@"event_name"];
                 NSString *strevent_venue = [dict objectForKey:@"event_venue"];
                 NSString *strid = [dict objectForKey:@"id"];
                 NSString *strnumber_of_seats = [dict objectForKey:@"number_of_seats"];
                 NSString *strorder_id = [dict objectForKey:@"order_id"];
                 NSString *strplan_name = [dict objectForKey:@"plan_name"];
                 NSString *strshow_date = [dict objectForKey:@"show_date"];
                 NSString *strshow_time = [dict objectForKey:@"show_time"];
                 NSString *strtotal_amount = [dict objectForKey:@"total_amount"];
                 
                 
                 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                 NSDate *date = [[NSDate alloc] init];
                 date = [dateFormatter dateFromString:strshow_date];
                 // converting into our required date format
                 [dateFormatter setDateFormat:@"EEEE, MMMM dd, yyyy"];
                 NSString *reqDateString = [dateFormatter stringFromDate:date];
                 NSLog(@"date is %@", reqDateString);
                 
                 [category_name addObject:strcategry_name];
                 [created_at addObject:strcreated_at];
                 [event_address addObject:strcategry_event_addressname];
                 [event_colour_scheme addObject:strevent_colour_scheme];
                 [event_id addObject:strevent_id];
                 [event_name addObject:strevent_name];
                 [event_venue addObject:strevent_venue];
                 [_id addObject:strid];
                 [number_of_seats addObject:strnumber_of_seats];
                 [order_id addObject:strorder_id];
                 [plan_name addObject:strplan_name];
                 [show_date addObject:reqDateString];
                 [show_time addObject:strshow_time];
                 [total_amount addObject:strtotal_amount];
                 
             }
             
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
    return [event_name count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookingHistoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.eventName.text = [event_name objectAtIndex:indexPath.row];
    cell.dateLabel.text = [show_date objectAtIndex:indexPath.row];
    cell.timeLabel.text = [show_time objectAtIndex:indexPath.row];
    cell.locationLabel.text = [event_venue objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.event_Name = [event_name objectAtIndex:indexPath.row];
    appDel.event_StartDate = [show_date objectAtIndex:indexPath.row];
    appDel.event_StartTime = [show_time objectAtIndex:indexPath.row];
    appDel.event_Address = [event_address objectAtIndex:indexPath.row];
    appDel.order_id = [order_id objectAtIndex:indexPath.row];
    appDel.plan_name = [plan_name objectAtIndex:indexPath.row];
    appDel.seat_count = [number_of_seats objectAtIndex:indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    BookingHistoryDetailsViewController *myNewVC = (BookingHistoryDetailsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"BookingHistoryDetailsViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 247;
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
