//
//  AdvanceFilterViewController.m
//  Heylaapp
//
//  Created by HappySanz on 28/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "AdvanceFilterViewController.h"

@interface AdvanceFilterViewController ()
{
    AppDelegate *appDel;
    UIDatePicker *datePicker;
    UIPickerView *listpickerView;
    UIToolbar *toolBar;
    UIToolbar *listToolBar;
    NSMutableArray *eventTypeArray;
    NSMutableArray *eventCategoeryArray;
    NSMutableArray *preference;
    NSMutableArray *eventCityArray;
    NSString *streventType;
    NSString *streventCategoery;
    NSString *streventPrefernce;
    NSString *streventcity;
    NSString *selectedDateToday;
    NSString *selectedDateTommorow;
    NSString *selectedDate;
    NSString *sliderFinalValue;

}
@property(nonatomic) float maximumValue;
@end
@implementation AdvanceFilterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    _today.layer.cornerRadius = 8;
    _today.clipsToBounds = YES;
    
    _tommorow.layer.cornerRadius = 8;
    _tommorow.clipsToBounds = YES;
    
    _viewDate.layer.cornerRadius = 8;
    _viewDate.clipsToBounds = YES;
    
    _today.layer.cornerRadius = 8;
    _today.clipsToBounds = YES;
    
    _cancel.layer.cornerRadius = 8;
    _cancel.clipsToBounds = YES;
    
    _search.layer.cornerRadius = 8;
    _search.clipsToBounds = YES;
    
    _fromDate.delegate = self;
    _toDate.delegate = self;
    _dateTextFiled.delegate = self;
    
    _eventType.delegate = self;
    _eventCategoery.delegate = self;
    _eventPreference.delegate = self;
    _eventCity.delegate = self;
    
    eventTypeArray = [[NSMutableArray alloc]init];
    eventCategoeryArray = [[NSMutableArray alloc]init];
    preference = [[NSMutableArray alloc]init];
    eventCityArray = [[NSMutableArray alloc]init];
    
    [eventTypeArray addObject:@"Select Event Type"];
    [eventTypeArray addObject:@"Paid"];
    [eventTypeArray addObject:@"Free"];
    
    [eventCategoeryArray addObject:@"Select Event Category"];
    [eventCategoeryArray addObject:@"Hotspot"];
    [eventCategoeryArray addObject:@"Popular"];
    
    preference = [[NSUserDefaults standardUserDefaults]objectForKey:@"preferenceName_Array"];
   // eventCityArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"cityName_Array"];
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.fromDate setInputView:datePicker];
    [self.toDate setInputView:datePicker];
    [self.dateTextFiled setInputView:datePicker];

    toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *cancelBtn=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(ShowsCancelButton)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:cancelBtn,space,doneBtn, nil]];
    [self.fromDate setInputAccessoryView:toolBar];
    [self.toDate setInputAccessoryView:toolBar];
    [self.dateTextFiled setInputAccessoryView:toolBar];
    
    listpickerView = [[UIPickerView alloc] init];
    listpickerView.delegate = self;
    listpickerView.dataSource = self;
    [self.eventType setInputView:listpickerView];
    [self.eventCategoery setInputView:listpickerView];
    [self.eventPreference setInputView:listpickerView];
    [self.eventCity setInputView:listpickerView];
    
    
    listToolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [listToolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SelectedDate)];
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButton)];
    UIBarButtonItem *spacePicker=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [listToolBar setItems:[NSArray arrayWithObjects:cancel,spacePicker,done, nil]];
    [self.eventType setInputAccessoryView:listToolBar];
    [self.eventCategoery setInputAccessoryView:listToolBar];
    [self.eventPreference setInputAccessoryView:listToolBar];
    [self.eventCity setInputAccessoryView:listToolBar];
    selectedDate =@"";
    selectedDateToday =@"";
    selectedDateTommorow =@"";
    sliderFinalValue = @"";
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *bookingPricerange = @"apimain/bookingPricerange/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,bookingPricerange, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"Price Range"] && [status isEqualToString:@"success"])
         {
             NSString *Value = [responseObject objectForKey:@"Pricerange"];
             self.sliderSelectedValue.text = [NSString stringWithFormat:@"%@%@",@"Rs.",Value] ;
             self->_maximumValue = [Value floatValue];
             self->_slider.maximumValue = self->_maximumValue;
             self->_slider.minimumValue = 0;
         }
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
    _today.layer.borderColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0].CGColor;
    _today.layer.borderWidth = 1.0;
    [_today setTitleColor:[UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _tommorow.layer.borderColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0].CGColor;
     _tommorow.layer.borderWidth = 1.0;
    [_tommorow setTitleColor:[UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _viewDate.layer.borderColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0].CGColor;
    _viewDate.layer.borderWidth = 1.0;
    self.dateTextFiled.textColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0];
}
-(void)viewWillAppear:(BOOL)animated
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *selectAllCity = @"apimain/selectAllCity/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,selectAllCity, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Cities"] && [status isEqualToString:@"success"])
         {
                NSArray *cities = [responseObject objectForKey:@"Cities"];
                [self->eventCityArray removeAllObjects];
             
             for (int i =0; i < [cities count]; i++)
             {
                 NSDictionary *dict = [cities objectAtIndex:i];
                 NSString *strCity_name = [dict objectForKey:@"city_name"];
                 [self->eventCityArray addObject:strCity_name];
             }
                  [self->eventCityArray insertObject:@"Select Your City" atIndex:0];
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
-(void)ShowSelectedDate
{
    if([self.fromDate isFirstResponder])
    {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        self.fromDate.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
        [self.fromDate resignFirstResponder];
    }
    else if([self.toDate isFirstResponder])
    {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        self.toDate.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
        [self.toDate resignFirstResponder];
    }
    else
    {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        self.dateTextFiled.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
        self.dateTextFiled.textColor = [UIColor whiteColor];
        selectedDate = self.dateTextFiled.text;
        [self.dateTextFiled resignFirstResponder];
    }
}
-(void)ShowsCancelButton
{
    if([self.fromDate isFirstResponder])
    {
        [datePicker removeFromSuperview];
        [self.fromDate resignFirstResponder];
        [toolBar removeFromSuperview];
        
    }
    else if([self.toDate isFirstResponder])
    {
        [datePicker removeFromSuperview];
        [self.toDate resignFirstResponder];
        [toolBar removeFromSuperview];
    }
    else
    {
        [datePicker removeFromSuperview];
        [self.dateTextFiled resignFirstResponder];
        self.dateTextFiled.textColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0];
        [toolBar removeFromSuperview];
    }
}
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
        if([self.eventType isFirstResponder])
        {
            return [eventTypeArray count];
        }
        else if([self.eventCategoery isFirstResponder])
        {
            return [eventCategoeryArray count];
        }
        else if([self.eventPreference isFirstResponder])
        {
            return [preference count];
        }
        else if([self.eventCity isFirstResponder])
        {
            return [eventCityArray count];
        }
    }
    return 0;
    
}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.eventType isFirstResponder])
        {
            return eventTypeArray[row];
        }
        else if([self.eventCategoery isFirstResponder])
        {
            return eventCategoeryArray[row];
        }
        else if([self.eventPreference isFirstResponder])
        {
            return preference[row];
        }
        else if([self.eventCity isFirstResponder])
        {
            return eventCityArray[row];
        }
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView == listpickerView)
    {
        if([self.eventType isFirstResponder])
        {
            streventType = eventTypeArray[row];
        }
        else if([self.eventCategoery isFirstResponder])
        {
            streventCategoery = eventCategoeryArray[row];
        }
        else if([self.eventPreference isFirstResponder])
        {
            streventPrefernce = preference[row];
        }
        else if([self.eventCity isFirstResponder])
        {
            streventcity = eventCityArray[row];
        }
    }
}
-(void)SelectedDate
{
    if ([self.eventType isFirstResponder])
    {
        self.eventType.text = streventType;
        [listpickerView reloadAllComponents];
        [listpickerView selectRow:0 inComponent:0 animated:YES];
        [self.eventType resignFirstResponder];
    }
    else if ([self.eventCategoery isFirstResponder])
    {
        self.eventCategoery.text = streventCategoery;
        [listpickerView reloadAllComponents];
        [listpickerView selectRow:0 inComponent:0 animated:YES];
        [self.eventCategoery resignFirstResponder];
    }
    else if ([self.eventPreference isFirstResponder])
    {
        self.eventPreference.text = streventPrefernce;
        [listpickerView reloadAllComponents];
        [listpickerView selectRow:0 inComponent:0 animated:YES];
        [self.eventPreference resignFirstResponder];
    }
    else if ([self.eventCity isFirstResponder])
    {
        self.eventCity.text = streventcity;
        [listpickerView reloadAllComponents];
        [listpickerView selectRow:0 inComponent:0 animated:YES];
        [self.eventCity resignFirstResponder];
    }
}
-(void)CancelButton
{
    if ([self.eventType isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.eventType resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
    else if([self.eventCategoery isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.eventCategoery resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
    else if([self.eventPreference isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.eventPreference resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
    else if([self.eventCity isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.eventCity resignFirstResponder];
        [listToolBar removeFromSuperview];
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
    HomeViewController *homeviewController = (HomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:homeviewController animated:YES];
    
}
- (IBAction)todayBtn:(id)sender
{
    _today.layer.backgroundColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0].CGColor;
    [_today setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _tommorow.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _tommorow.layer.borderColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0].CGColor;
    _tommorow.layer.borderWidth = 1.0;
    [_tommorow setTitleColor:[UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _viewDate.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _viewDate.layer.borderColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0].CGColor;
    _viewDate.layer.borderWidth = 1.0;
    self.dateTextFiled.textColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0];

    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:today];
    selectedDateToday = dateString;
}
- (IBAction)tomorrowBtn:(id)sender
{
    _today.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [_today setTitleColor:[UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    _tommorow.layer.backgroundColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:204/255.0 alpha:1.0].CGColor;
    [_tommorow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _viewDate.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _viewDate.layer.borderColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0].CGColor;
    _viewDate.layer.borderWidth = 1.0;
    self.dateTextFiled.textColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *tomorrow = [cal dateByAddingUnit:NSCalendarUnitDay
                                       value:1
                                      toDate:[NSDate date]
                                     options:0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-DD"];
    NSString *dateString = [dateFormat stringFromDate:tomorrow];
    selectedDateTommorow = dateString;

}
- (IBAction)cancelBtn:(id)sender
{
    self.eventType.text = @"";
    self.eventCategoery.text = @"";
    self.eventPreference.text = @"";
    self.eventCity.text = @"";
    self.fromDate.text = @"";
    self.toDate.text = @"";
    self.dateTextFiled.text = @"";
    _today.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [_today setTitleColor:[UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];
    _tommorow.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [_tommorow setTitleColor:[UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.dateTextFiled.textColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0];
}

- (IBAction)searchBtn:(id)sender
{
    if ([self.eventCity.text isEqualToString:@"Select Your City"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please select the city"
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
        [parameters setObject:selectedDateToday forKey:@"today_date"];
        [parameters setObject:selectedDateTommorow forKey:@"tomorrow_date"];
        [parameters setObject:selectedDate forKey:@"single_date"];
        [parameters setObject:self.fromDate.text forKey:@"from_date"];
        [parameters setObject:self.toDate.text forKey:@"to_date"];
        [parameters setObject:self.eventType.text forKey:@"event_type"];
        [parameters setObject:self.eventCategoery.text forKey:@"event_category"];
        [parameters setObject:self.eventPreference.text forKey:@"selected_preference"];
        [parameters setObject:self.eventCity.text forKey:@"selected_city"];
        [parameters setObject:sliderFinalValue forKey:@"price_range"];
        
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString *advanceSearch = @"apimain/advanceSearch";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,advanceSearch, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             
             if ([msg isEqualToString:@"View Events"] && [status isEqualToString:@"success"])
             {
                 
                 NSArray *eventListArray = [responseObject objectForKey:@"Eventdetails"];
                 [[NSUserDefaults standardUserDefaults]setObject:eventListArray forKey:@"eventList_AdvSearch"];
                 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
                 AdvanceFilterResultViewController *advanceFilterResultViewController = (AdvanceFilterResultViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AdvanceFilterResultViewController"];
                 [self.navigationController pushViewController:advanceFilterResultViewController animated:YES];
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
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.dateTextFiled)
    {
        _today.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _today.layer.borderColor = [UIColor colorWithRed:63/255.0 green:142/255.0 blue:204/255.0 alpha:1.0].CGColor;
        _today.layer.borderWidth = 1.0;
        [_today setTitleColor:[UIColor colorWithRed:63/255.0 green:142/255.0 blue:204/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        _tommorow.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _tommorow.layer.borderColor = [UIColor colorWithRed:63/255.0 green:142/255.0 blue:204/255.0 alpha:1.0].CGColor;
        _tommorow.layer.borderWidth = 1.0;
        [_tommorow setTitleColor:[UIColor colorWithRed:63/255.0 green:142/255.0 blue:204/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        _viewDate.layer.backgroundColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:204/255.0 alpha:1.0].CGColor;
         self.dateTextFiled.textColor = [UIColor whiteColor];
        
    }
    return YES;
}
- (IBAction)progImgBTn:(id)sender
{
    
}
- (IBAction)sliderButton:(id)sender
{
    NSString *strsliderValue = [NSString stringWithFormat:@"%@%d",@"Rs.",(int)floorf(self->_slider.value)];
    NSString *strVal = [NSString stringWithFormat:@"%@",strsliderValue];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    sliderFinalValue = [NSString stringWithFormat:@"%d%@",(int)floorf(self->_slider.value),@".00"];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = [NSString stringWithFormat:@"%@ %@ - %@%@",@"Price Range:",@"Rs.0",strVal,@".00"];
    hud.margin = 10.f;
    hud.yOffset = 200.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}
@end
