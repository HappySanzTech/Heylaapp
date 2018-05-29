//
//  BookingViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 17/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "BookingViewController.h"

@interface BookingViewController ()
{
    AppDelegate *appDel;
    UIPickerView *datapickerView;
    UIToolbar *toolbar;
    NSString *selectedEventDate;
    NSMutableArray *monthName;
    NSMutableArray *monthDate;
    NSMutableArray *year;
    NSMutableArray *Eventtime;
    NSMutableArray *Event_time_id;
    NSMutableArray *plan_name;
    NSMutableArray *plan_id;
    NSMutableArray *seat_rate;
    NSMutableArray *seat_available;
    NSString *dateTimeFlag;
    NSString *selectedDate;
    NSString *selectedTime;
    NSString *streventDate;
    NSString *streventTime;

}
@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    _eventDate.delegate = self;
    _eventTime.delegate = self;
    
    _eventDate.layer.borderColor = [UIColor clearColor].CGColor;
    _eventTime.layer.borderColor = [UIColor clearColor].CGColor;

    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
    __weak typeof(self) weakSelf = self;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:appDel.event_picture]];
    [self.imageView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
     {
         weakSelf.imageView.image = image;
         
     } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error)
     {
         
         NSLog(@"%@",error);
         
     }];
    self.eventTitle.text = appDel.event_Name;
    NSString *time = appDel.event_StartTime;
    self.timeLabel.text = time;
    self.eventLocation.text = appDel.event_Address;
    self.eventVenue.text = appDel.event_Address;
    
    monthName = [[NSMutableArray alloc]init];
    monthDate = [[NSMutableArray alloc]init];
    year = [[NSMutableArray alloc]init];
    Eventtime = [[NSMutableArray alloc]init];
    plan_name = [[NSMutableArray alloc]init];
    plan_id = [[NSMutableArray alloc]init];
    seat_rate = [[NSMutableArray alloc]init];
    seat_available = [[NSMutableArray alloc]init];
    Event_time_id = [[NSMutableArray alloc]init];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.event_id forKey:@"event_id"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *bookingplandates = @"apimain/bookingPlanDates";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,bookingplandates, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Booking Dates"] && [status isEqualToString:@"success"])
         {
             NSArray *Eventdates = [responseObject objectForKey:@"Eventdates"];
             for (int i = 0; i < [Eventdates count]; i++)
             {
                 NSDictionary *dict = [Eventdates objectAtIndex:i];
                 NSString *str = [NSString stringWithFormat:@"%@",[dict objectForKey:@"show_date"]];
                 NSDateFormatter* df = [[NSDateFormatter alloc]init];
                 [df setDateFormat:@"yyyy-MM-dd"];
                 NSDate *date = [df dateFromString:str];
                 
                 NSDateFormatter *dfTwo = [[NSDateFormatter alloc]init];
                 [dfTwo setDateFormat:@"MMMM dd YYYY"];
                 NSString *strDate = [dfTwo stringFromDate:date];
                 
                 [self->monthName addObject:strDate];
             }
             [self->monthName insertObject:@"Select the Date" atIndex:0];
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
    
    datapickerView = [[UIPickerView alloc] init];
    datapickerView.delegate = self;
    datapickerView.dataSource = self;
    datapickerView.showsSelectionIndicator=YES;
    [self.eventDate setInputView:datapickerView];
    [self.eventTime setInputView:datapickerView];
    
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SelectedValue)];
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(Cancel)];
    UIBarButtonItem *spacePicker=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:cancel,spacePicker,done, nil]];
    [self.eventDate setInputAccessoryView:toolbar];
    [self.eventTime setInputAccessoryView:toolbar];
    
    self.eventTime.hidden = YES;
    self.timeImageView.hidden = YES;
    self.tableView.hidden = YES;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == datapickerView)
    {
        return 1;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == datapickerView)
    {
        if([self.eventDate isFirstResponder])
        {
            return [monthName count];
        }
        else if([self.eventTime isFirstResponder])
        {
            return [Eventtime count];
        }
    }
    return 0;
    
}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == datapickerView)
    {
        if([self.eventDate isFirstResponder])
        {
            streventDate = monthName[row];
            return monthName[row];
        }
        else if([self.eventTime isFirstResponder])
        {
            selectedTime = Eventtime[row];
            return Eventtime[row];
        }
    }
    return nil;
}
-(void)SelectedValue
{
    if ([self.eventDate isFirstResponder])
    {
        self.eventDate.text = streventDate;
        [self getTimings];
        self.eventTime.hidden = NO;
        self.timeImageView.hidden = NO;
        [self.eventDate resignFirstResponder];
    }
    else if ([self.eventTime isFirstResponder])
    {
        self.eventTime.text = selectedTime;
        appDel.selected_Event_time = self.eventTime.text;
        [self getPlans];
        [self.eventTime resignFirstResponder];
    }
}
-(void)Cancel
{
    if ([self.eventDate isFirstResponder])
    {
        [datapickerView removeFromSuperview];
        [self.eventDate resignFirstResponder];
        [toolbar removeFromSuperview];
    }
    else if([self.eventTime isFirstResponder])
    {
        [datapickerView removeFromSuperview];
        [self.eventTime resignFirstResponder];
        [toolbar removeFromSuperview];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getTimings
{
    if ([self.eventDate.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Date Not Selected"
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
    else if ([self.eventDate.text isEqualToString:@"Select the Date"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Date Not Selected"
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
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"MMMM dd yyyy"];
        NSDate *date = [df dateFromString:streventDate];
        
        NSDateFormatter *dfTwo = [[NSDateFormatter alloc]init];
        [dfTwo setDateFormat:@"yyyy-MM-dd"];
        selectedDate = [dfTwo stringFromDate:date];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.event_id forKey:@"event_id"];
        [parameters setObject:selectedDate forKey:@"show_date"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString *bookingplantimes = @"apimain/bookingPlanTimes";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,bookingplantimes, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             
             [self->Eventtime removeAllObjects];
             [self->Event_time_id removeAllObjects];
             if ([msg isEqualToString:@"View Booking Timings"] && [status isEqualToString:@"success"])
             {
                 NSArray *Eventtiming = [responseObject objectForKey:@"Eventtiming"];
                 for (int i = 0; i < [Eventtiming count]; i++)
                 {
                     NSDictionary *dict = [Eventtiming objectAtIndex:i];
                     NSString *str = [dict objectForKey:@"show_time"];
                     NSString *id_time = [dict objectForKey:@"id"];
                     [self->Eventtime addObject:str];
                     [self->Event_time_id addObject:id_time];
                 }
                 [self->Eventtime insertObject:@"Select Time" atIndex:0];
                 
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
-(void)getPlans
{
    if ([self.eventTime.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Select the time"
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
    else if ([self.eventTime.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Select the time"
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
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.event_id forKey:@"event_id"];
        [parameters setObject:selectedDate forKey:@"show_date"];
        [parameters setObject:selectedTime forKey:@"show_time"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString *bookingplans = @"apimain/bookingPlans";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,bookingplans, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             
             if ([msg isEqualToString:@"Booking Plans"] && [status isEqualToString:@"success"])
             {
                 [self->plan_name removeAllObjects];
                 [self->seat_rate removeAllObjects];
                 NSArray *Plandetails = [responseObject objectForKey:@"Plandetails"];
                 for (int i = 0; i < [Plandetails count]; i++)
                 {
                     NSDictionary *dict = [Plandetails objectAtIndex:i];
                     NSString *strevent_id = [dict objectForKey:@"event_id"];
                     NSString *strplan_id = [dict objectForKey:@"plan_id"];
                     NSString *strplan_name = [dict objectForKey:@"plan_name"];
                     NSString *strseat_available = [dict objectForKey:@"seat_available"];
                     NSString *strseat_rate = [dict objectForKey:@"seat_rate"];
                     NSString *strshow_date = [dict objectForKey:@"show_date"];
                     NSString *strshow_time = [dict objectForKey:@"show_time"];
                     NSLog(@"%@%@%@",strevent_id,strshow_date,strshow_time);
                     [self->plan_id addObject:strplan_id];
                     [self->plan_name addObject:strplan_name];
                     [self->seat_available addObject:strseat_available];
                     [self->seat_rate addObject:strseat_rate];
                 }
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
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [plan_name count];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 43)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width,18)];
    [label setFont:[UIFont fontWithName:@"Muli" size:16]];
    NSString *string =[plan_name objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor whiteColor]];//your background color...
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [seat_rate count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.planLabel.text = [NSString stringWithFormat:@"%@%@",@"Rs.",[seat_rate objectAtIndex:indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [Eventtime removeObjectAtIndex:0];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.plan_id = [plan_id objectAtIndex:indexPath.row];
    appDel.plan_name = [plan_name objectAtIndex:indexPath.section];
    appDel.seat_rate = [seat_rate objectAtIndex:indexPath.row];
    appDel.bookingdate = self.eventDate.text;
    NSUInteger Eventtimeint = [Eventtime indexOfObject:appDel.selected_Event_time];
    appDel.event_time_id = Event_time_id[Eventtimeint];
    appDel.ticlet_seat_available = [seat_available objectAtIndex:indexPath.row];
    
    NSLog(@"%@",appDel.event_time_id);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    ReviewTicketBookingController *myNewVC = (ReviewTicketBookingController *)[storyboard instantiateViewControllerWithIdentifier:@"ReviewTicketBookingController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backBtn:(id)sender;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
