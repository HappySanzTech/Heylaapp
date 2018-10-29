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
    NSMutableArray *event_id;
    NSMutableArray *plan_id;
    NSMutableArray *seat_rate;
    NSMutableArray *seat_available;
    NSMutableArray *planName_seatrate;
    NSMutableArray *plan_time_id;
    NSString *dateTimeFlag;
    NSString *selectedDate;
    NSString *selectedTime;
    NSString *selectedPlan;
    NSString *streventDate;
    NSString *streventTime;
    NSString *getValue;
    NSMutableArray *selected_Seat;
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

    self.mainView.layer.cornerRadius = 8.0;
    self.mainView.clipsToBounds = YES;
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
    self.eventLocation.text = appDel.event_Address;
    
    monthName = [[NSMutableArray alloc]init];
    monthDate = [[NSMutableArray alloc]init];
    year = [[NSMutableArray alloc]init];
    Eventtime = [[NSMutableArray alloc]init];
    plan_name = [[NSMutableArray alloc]init];
    plan_id = [[NSMutableArray alloc]init];
    seat_rate = [[NSMutableArray alloc]init];
    seat_available = [[NSMutableArray alloc]init];
    Event_time_id = [[NSMutableArray alloc]init];
    selected_Seat = [[NSMutableArray alloc]init];
    planName_seatrate = [[NSMutableArray alloc]init];
    plan_time_id = [[NSMutableArray alloc]init];
    event_id = [[NSMutableArray alloc]init];
    
    self.eventDate.enabled = YES;
    self.eventTime.enabled = YES;
    self.eventPlan.enabled = YES;
    
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
             self.eventDate.enabled = NO;
             self.eventTime.enabled = NO;
             self.eventPlan.enabled = NO;
             
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
    
    self.eventTime.enabled = NO;
    self.eventPlan.enabled = NO;
    self.timeImageView.hidden = YES;
    self.planUmgView.hidden = YES;
    self.minusLabel.hidden = YES;
    self.plusLabel.hidden = YES;
    self.countText.hidden = YES;
    self.minusOulet.enabled = NO;
    self.plusOutlet.enabled = NO;
    
    datapickerView = [[UIPickerView alloc] init];
    datapickerView.delegate = self;
    datapickerView.dataSource = self;
    datapickerView.showsSelectionIndicator=YES;
    [self.eventDate setInputView:datapickerView];
    [self.eventTime setInputView:datapickerView];
    [self.eventPlan setInputView:datapickerView];
    
    toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SelectedValue)];
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(Cancel)];
    UIBarButtonItem *spacePicker=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:cancel,spacePicker,done, nil]];
    [self.eventDate setInputAccessoryView:toolbar];
    [self.eventTime setInputAccessoryView:toolbar];
    [self.eventPlan setInputAccessoryView:toolbar];
    [selected_Seat removeAllObjects];
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
        else if([self.eventPlan isFirstResponder])
        {
            return [planName_seatrate count];
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
        else if([self.eventPlan isFirstResponder])
        {
            selectedPlan = planName_seatrate[row];
            return planName_seatrate[row];
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
        self.eventTime.enabled = YES;
        self.timeImageView.hidden = NO;
        self.eventTime.textColor = [UIColor blackColor];
        self.eventPlan.textColor = [UIColor lightGrayColor];
        self.eventPlan.enabled = NO;
        self.planUmgView.hidden = YES;
        self.minusOulet.enabled = NO;
        self.plusOutlet.enabled = NO;
        self.minusLabel.hidden = YES;
        self.plusLabel.hidden = YES;
        self.countText.text = @"0";
        self.countText.hidden = YES;
        [self.amountOutlet setTitle:[NSString stringWithFormat:@"%@ %@%@",@"Pay - ",@"Rs.",@"0"] forState:UIControlStateNormal];
        [self.eventDate resignFirstResponder];
    }
    else if ([self.eventTime isFirstResponder])
    {
        self.eventTime.text = selectedTime;
        appDel.selected_Event_time = self.eventTime.text;
        [self getPlans];
        self.eventPlan.text = @"Plan";
        self.eventPlan.textColor = [UIColor blackColor];
        self.minusOulet.enabled = YES;
        self.plusOutlet.enabled = YES;
        self.minusLabel.hidden = NO;
        self.plusLabel.hidden = NO;
        self.countText.text = @"0";
        self.countText.hidden = NO;
        [self.eventTime resignFirstResponder];
    }
    else if ([self.eventPlan isFirstResponder])
    {
        if ([self.eventPlan.text isEqualToString:@"Select Your Plan"])
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Heyla"
                                       message:@"Please select the Plan"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            self.countText.text = @"0";
            [self.amountOutlet setTitle:[NSString stringWithFormat:@"%@ %@%@",@"Pay - ",@"Rs.",@"0"] forState:UIControlStateNormal];
        }
        else
        {
            self.eventPlan.text = selectedPlan;
            [self.eventPlan resignFirstResponder];
            self.countText.text = @"0";
            [self.amountOutlet setTitle:[NSString stringWithFormat:@"%@ %@%@",@"Pay - ",@"Rs.",@"0"] forState:UIControlStateNormal];
        }
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
    else if ([self.eventPlan isFirstResponder])
    {
        [datapickerView removeFromSuperview];
        [self.eventPlan resignFirstResponder];
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
                 self.eventTime.text = @"HH : MM";
                 self.eventPlan.text = @"Plan";
                 [self.amountOutlet setTitle:[NSString stringWithFormat:@"%@ %@%@",@"Pay - ",@"Rs.",@"0"] forState:UIControlStateNormal];
                 [self->Eventtime insertObject:@"Select Time" atIndex:0];
                 [self->datapickerView reloadAllComponents];
                 
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
    else if ([self.eventTime.text isEqualToString:@"Select Time"])
    {
        self.eventPlan.text = @"Plan";
        self.eventPlan.textColor = [UIColor lightGrayColor];
        self.eventPlan.enabled = NO;
        self.planUmgView.hidden = YES;
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
        appDel.event_SelectedTime = selectedTime;
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
                 [self->planName_seatrate  removeAllObjects];
                 
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
                     NSString *strplan_time_id = [dict objectForKey:@"plan_time_id"];
                     NSString *strEvent_id = [dict objectForKey:@"event_id"];
                     NSString *planName_seat = [NSString stringWithFormat:@"%@ - %@%@",strplan_name,@"Rs.",strseat_rate];
                     NSLog(@"%@%@%@",strevent_id,strshow_date,strshow_time);
                     [self->plan_id addObject:strplan_id];
                     [self->plan_name addObject:strplan_name];
                     [self->seat_available addObject:strseat_available];
                     [self->seat_rate addObject:strseat_rate];
                     [self->planName_seatrate addObject:planName_seat];
                     [self->plan_time_id addObject:strplan_time_id];
                     [self->event_id addObject:strEvent_id];
                 }
                 self.eventPlan.enabled = YES;
                 self.planUmgView.hidden = NO;
                 [self.amountOutlet setTitle:[NSString stringWithFormat:@"%@ %@%@",@"Pay - ",@"Rs.",@"0"] forState:UIControlStateNormal];
                 [self->planName_seatrate insertObject:@"Select Your Plan" atIndex:0];
                 [self->datapickerView reloadAllComponents];
                
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
- (IBAction)amountBtn:(id)sender
{
    if (selected_Seat.count == 0)
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@""
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
    else if ([self.eventTime.text isEqualToString:@"HH : MM"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please Select Your Time"
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
    else if ([self.eventPlan.text isEqualToString:@"Plan"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please Select Your Plan"
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
    else if ([self.eventPlan.text isEqualToString:@"Select Your Plan"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please Select Your Plan"
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
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"MMMM dd yyyy"];
        NSDate *date = [df dateFromString:self.eventDate.text];
        NSLog(@"%@",appDel.bookingdate);
        NSDateFormatter *dfTwo = [[NSDateFormatter alloc]init];
        [dfTwo setDateFormat:@"yyyy-MM-dd"];
        NSString *bookingDateString = [dfTwo stringFromDate:date];
        appDel.bookingdate = bookingDateString;
        [Eventtime removeObjectAtIndex:0];
        NSArray *splitArray = [self.eventPlan.text componentsSeparatedByString:@"-"];
        NSString *planName = [splitArray objectAtIndex:0];
        NSArray *arr = [planName componentsSeparatedByString:@" "];
        NSString *stt = [arr objectAtIndex:0];
        NSUInteger Eventplan_name= [plan_name indexOfObject:stt];
        appDel.plan_time_id = plan_time_id[Eventplan_name];
        appDel.plan_id = plan_id[Eventplan_name];
        appDel.planEvent_id = event_id[Eventplan_name];
        NSLog(@"%@",appDel.event_time_id);
        int randomNumber = (arc4random() % 9999999) + 1;
        NSString *ordeidUserID = [NSString stringWithFormat:@"%d",randomNumber];
        NSString *order_id = [NSString stringWithFormat: @"%@-%@",
                              ordeidUserID,appDel.user_Id];
        appDel.order_id = order_id;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:order_id forKey:@"order_id"];
        [parameters setObject:appDel.planEvent_id forKey:@"event_id"];
        [parameters setObject:appDel.plan_id forKey:@"plan_id"];
        [parameters setObject:appDel.plan_time_id forKey:@"plan_time_id"];
        [parameters setObject:appDel.user_Id forKey:@"user_id"];
        [parameters setObject:appDel.totalTickets forKey:@"number_of_seats"];
        [parameters setObject:appDel.total_price forKey:@"total_amount"];
        [parameters setObject:appDel.bookingdate forKey:@"booking_date"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString *bookingprocess = @"apimain/bookingProcess";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,bookingprocess, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             
             if ([msg isEqualToString:@"Bookingprocess"] && [status isEqualToString:@"success"])
             {
                 [[NSUserDefaults standardUserDefaults]setObject:self->selected_Seat forKey:@"tickcount_arr"];
                 [self performSegueWithIdentifier:@"to_bookingReview" sender:self];
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
- (IBAction)plusBtn:(id)sender
{
    if ([self.eventPlan.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"select your Plan"
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
    else if ([self.eventTime.text isEqualToString:@"HH : MM"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please Select Your Time"
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
    else if ([self.eventPlan.text isEqualToString:@"Plan"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please Select Your Plan"
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
    else if ([self.eventPlan.text isEqualToString:@"Select Your Plan"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please Select Your Plan"
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
        NSArray *splitArrayPN = [self.eventPlan.text componentsSeparatedByString:@"-"];
        NSString *planName = [splitArrayPN objectAtIndex:0];
        NSArray *arr = [planName componentsSeparatedByString:@" "];
        NSString *stt = [arr objectAtIndex:0];
        
        NSUInteger Eventplan_name = [plan_name indexOfObject:stt];
        appDel.ticlet_seat_available = seat_available[Eventplan_name];
        
        NSArray *splitArray = [self.eventPlan.text componentsSeparatedByString:@"-"];
        NSString *str = [splitArray objectAtIndex:1];
        NSArray *splitArray2 = [str componentsSeparatedByString:@"."];
        NSString *seat = [splitArray2 objectAtIndex:1];
        
        appDel.bookingdate = self.eventDate.text;
        NSString *quantity = self.countText.text;
        int value = [quantity intValue];
        NSNumber *number = [NSNumber numberWithInteger:value];
        int ans = [number intValue];
        number = [NSNumber numberWithInt:ans + 1];
        
     //   NSString *selected_seat = [NSString stringWithFormat:@"%@",number];
        
        NSString *Count =[NSString stringWithFormat:@"%@",number];
        int val = [appDel.ticlet_seat_available intValue];
        NSNumber *num = [NSNumber numberWithInteger:val];
        int seat_available = [num intValue];
       
        NSLog(@"%@",appDel.ticlet_seat_available);
       
        if ([number intValue] > seat_available)
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Heyla"
                                       message:@""
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
         else if ([Count isEqualToString:@"11"])
        {
            self.plusOutlet.enabled = NO;
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Heyla"
                                       message:@"Reached Maximum count."
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
            self.minusOulet.enabled = YES;
            self.countText.text = Count;
            appDel.totalTickets = Count;
            [selected_Seat addObject:Count];
            float seat_rate = [seat floatValue];
            int intpart = (int)seat_rate;
            float decpart = seat_rate - intpart;
            if(decpart == 0.0f)
            {
                //Contains no decimals
                NSLog(@"%@",@"Contains No decimal");
    
                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                f.numberStyle = NSNumberFormatterDecimalStyle;
                NSNumber *x = [f numberFromString:seat];
                NSNumber *y = [f numberFromString:Count];
                NSNumber *z = @(x.doubleValue * y.doubleValue);
                appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                appDel.total_price = [NSString stringWithFormat:@"%@",z];
                NSLog(@"%@",appDel.total_price);
                appDel.price = appDel.total_price;
                [self.amountOutlet setTitle:[NSString stringWithFormat:@"%@ %@%@",@"Pay - ",@"Rs.",appDel.price] forState:UIControlStateNormal];
        }
     }
   }
}
- (IBAction)minusBtn:(id)sender
{
    if ([self.eventPlan.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@""
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
    else if ([self.eventTime.text isEqualToString:@"HH : MM"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please Select Your Time"
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
    else if ([self.eventPlan.text isEqualToString:@"Plan"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please Select Your Plan"
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
    else if ([self.eventPlan.text isEqualToString:@"Select Your Plan"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Reached Maximum count."
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
        NSArray *splitArray = [self.eventPlan.text componentsSeparatedByString:@"-"];
        NSString *str = [splitArray objectAtIndex:1];
        NSArray *splitArray2 = [str componentsSeparatedByString:@"."];
        NSString *seat = [splitArray2 objectAtIndex:1];
        NSString *quantity = self.countText.text;
        int value = [quantity intValue];
        NSNumber *number = [NSNumber numberWithInteger:value];
        int ans = [number intValue];
        number = [NSNumber numberWithInt:ans - 1];
        NSString *Count = [NSString stringWithFormat:@"%@", number];
        if([Count isEqualToString:@"-1"])
        {
            self.countText.text = @"0";
            [self.amountOutlet setTitle:[NSString stringWithFormat:@"%@ %@%@",@"Pay - ",@"RS.",@"0"] forState:UIControlStateNormal];
            self.minusOulet.enabled = NO;
        }
        else
        {
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            self.minusOulet.enabled = YES;
            [self.amountOutlet setTitle:[NSString stringWithFormat:@"%@ %@%@",@"Pay - ",@"RS.",Count] forState:UIControlStateNormal];
            self.countText.text = Count;
            [selected_Seat removeLastObject];
            appDel.totalTickets = Count;
            float seat_rate = [seat  floatValue];
            int intpart = (int)seat_rate;
            float decpart = seat_rate - intpart;
            if(decpart == 0.0f)
            {
                //Contains no decimals
                NSLog(@"%@",@"Contains No decimal");
    
                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                f.numberStyle = NSNumberFormatterDecimalStyle;
                NSNumber *x = [f numberFromString:seat];
                NSNumber *y = [f numberFromString:Count];
                NSNumber *z = @(x.doubleValue * y.doubleValue);
                appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                appDel.total_price = [NSString stringWithFormat:@"%@",z];
                NSLog(@"%@",appDel.total_price);
                appDel.price = appDel.total_price;
                [self.amountOutlet setTitle:[NSString stringWithFormat:@"%@ %@%@",@"Pay - ",@"Rs.",appDel.price] forState:UIControlStateNormal];
        }
      }
   }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
