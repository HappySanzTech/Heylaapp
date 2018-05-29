//
//  ReviewTicketBookingController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 18/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ReviewTicketBookingController.h"

@interface ReviewTicketBookingController ()
{
    AppDelegate *appDel;
    NSMutableArray *ticketCountadd;
    NSString *btnClick;
}
@end

@implementation ReviewTicketBookingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    _plus.layer.cornerRadius = 2;
    _plus.clipsToBounds = YES;
    
    _ticketCount.layer.cornerRadius = 2;
    _ticketCount.clipsToBounds = YES;
    
    _minus.layer.cornerRadius = 4;
    _minus.clipsToBounds = YES;
    
    ticketCountadd = [[NSMutableArray alloc]init];
    
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
    
    self.eventName.text = appDel.event_Name;
    NSString *time = appDel.event_StartTime;
    self.eventTime.text = time;
    self.eventlocation.text = appDel.event_Address;
    self.emailId.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"statemail_id"];
    self.phoneNum.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"statemobile_no"];
    self.planName.text = appDel.plan_name;
    self.planAmount.text = [NSString stringWithFormat:@"%@%@",@"Rs.",appDel.seat_rate];
    self.totalPrice.text = [NSString stringWithFormat:@"%@%@",@"Rs.",@"0"];
    self.ticketPrice.text = [NSString stringWithFormat:@"%@%@",@"Rs.",@"0"];
    btnClick =@"0";
    [ticketCountadd removeAllObjects];
}
- (IBAction)plusButton:(id)sender
{
    self.minus.enabled = YES;
    NSString *quantity = self.ticketCount.text;
    int value = [quantity intValue];
    NSNumber *number = [NSNumber numberWithInteger:value];
    int ans = [number intValue];
    number = [NSNumber numberWithInt:ans + 1];
    NSString *getValue =[NSString stringWithFormat:@"%@",number];
    
    if (self.ticketCount.text >= appDel.ticlet_seat_available)
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
    else
    {
        if ([getValue isEqualToString:@"11"])
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
            [ticketCountadd addObject:getValue];
            self.ticketCount.text = getValue;
            float seat_rate = [appDel.seat_rate  floatValue];
            int intpart = (int)seat_rate;
            float decpart = seat_rate - intpart;
            if(decpart == 0.0f)
            {
                //Contains no decimals
                NSLog(@"%@",@"Contains No decimal");
                
                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                f.numberStyle = NSNumberFormatterDecimalStyle;
                NSNumber *x = [f numberFromString:appDel.seat_rate];
                NSNumber *y = [f numberFromString:getValue];
                NSNumber *z = @(x.doubleValue * y.doubleValue);
                self.totalTickets.text = [NSString stringWithFormat:@"%@ %@",getValue,@"Tickets"];
                self.totalPrice.text = [NSString stringWithFormat:@"%@%@ %@",@"Rs.",z,@".00"];
                self.ticketPrice.text = [NSString stringWithFormat:@"%@%@ %@",@"Rs.",z,@".00"];
                appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                appDel.total_price = [NSString stringWithFormat:@"%@",z];
                NSLog(@"%@",appDel.total_price);
                appDel.price = getValue;
                self.planAmount.text = [NSString stringWithFormat:@"%@%@ %@ %@",@"Rs.",appDel.seat_rate,@"x",getValue];
                appDel.seat_count = self.ticketCount.text;
                
            }
            else
            {
                //Number contains decimals
                NSLog(@"%@",@"Contains decimal");
                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                f.numberStyle = NSNumberFormatterDecimalStyle;
                NSNumber *x = [f numberFromString:appDel.seat_rate];
                NSNumber *y = [f numberFromString:getValue];
                NSNumber *z = @(x.doubleValue * y.doubleValue);
                self.totalTickets.text = [NSString stringWithFormat:@"%@%@",getValue,@"Tickets"];
                self.totalPrice.text = [NSString stringWithFormat:@"%@%@%@",@"Rs.",z,@".00"];
                self.ticketPrice.text = [NSString stringWithFormat:@"%@%@%@",@"Rs.",z,@".00"];
                appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                appDel.total_price = [NSString stringWithFormat:@"%@",z];
                NSLog(@"%@",appDel.total_price);
                appDel.price = getValue;
                self.planAmount.text = [NSString stringWithFormat:@"%@%@ %@ %@",@"Rs.",appDel.seat_rate,@"x",getValue];
                appDel.seat_count = self.ticketCount.text;
                
            }
            
        }
    }
}
- (IBAction)minusButton:(id)sender
{
    NSString *quantity = self.ticketCount.text;
    int value = [quantity intValue];
    NSNumber *number = [NSNumber numberWithInteger:value];
    int ans = [number intValue];
    number = [NSNumber numberWithInt:ans - 1];
    NSString *getValue =[NSString stringWithFormat:@"%@", number];
    self.planAmount.text = [NSString stringWithFormat:@"%@%@ %@ %@",@"Rs.",appDel.seat_rate,@"x",getValue];
    
        if ([getValue isEqualToString:@"-1"])
        {
            self.minus.enabled = NO;
            self.ticketCount.text = @"0";
        }
        else if ([getValue isEqualToString:@"0"])
        {
            self.minus.enabled = NO;
            self.ticketCount.text = getValue;
            self.totalPrice.text = [NSString stringWithFormat:@"%@%@",@"Rs.",@"0"];
            NSLog(@"%@",appDel.total_price);
            self.ticketPrice.text = [NSString stringWithFormat:@"%@%@",@"Rs.",@"0"];
        }
        else
        {
            [ticketCountadd removeLastObject];
            self.ticketCount.text = getValue;
//            float seat_rate = [appDel.seat_rate  floatValue];
//            float ticketCount = [getValue floatValue];
//            int totalPrice = seat_rate * ticketCount;
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            f.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *x = [f numberFromString:appDel.seat_rate];
            NSNumber *y = [f numberFromString:self.ticketCount.text];
            NSNumber *z = @(x.doubleValue * y.doubleValue);
            self.totalTickets.text = [NSString stringWithFormat:@"%@ %@",getValue,@"Tickets"];
            self.totalPrice.text = [NSString stringWithFormat:@"%@%@%@",@"Rs.",z,@".0"];
            self.ticketPrice.text = [NSString stringWithFormat:@"%@%@%@",@"Rs.",z,@".0"];
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            appDel.total_price = [NSString stringWithFormat:@"%@",z];
            NSLog(@"%@",appDel.total_price);
            if ([getValue isEqualToString:@"-1"])
            {
                
            }
            else
            {
                self.planAmount.text = [NSString stringWithFormat:@"%@%@ %@ %@",@"Rs.",appDel.seat_rate,@"x",getValue];
            }
            appDel.seat_count = self.ticketCount.text;
            
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
- (IBAction)payNowButton:(id)sender
{
    if ([btnClick isEqualToString:@"0"])
    {
        if([self.ticketCount.text isEqualToString:@"0"])
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Heyla"
                                       message:@"select your tickets"
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
            btnClick = @"1";
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSDate *today = [NSDate date];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"YYYY-MM-dd"];
            NSString *dateString = [dateFormat stringFromDate:today];
            
            
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            int randomNumber = (arc4random() % 9999999) + 1;
            NSString *ordeidUserID = [NSString stringWithFormat:@"%d",randomNumber];
            NSString *combined = [NSString stringWithFormat: @"%@-%@",
                                  ordeidUserID,appDel.user_Id];
            appDel.order_id =combined;
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.order_id forKey:@"order_id"];
            [parameters setObject:appDel.event_id forKey:@"event_id"];
            [parameters setObject:appDel.plan_id forKey:@"plan_id"];
            [parameters setObject:appDel.event_time_id forKey:@"plan_time_id"];
            [parameters setObject:appDel.user_Id forKey:@"user_id"];
            [parameters setObject:appDel.seat_count forKey:@"number_of_seats"];
            [parameters setObject:appDel.total_price forKey:@"total_amount"];
            [parameters setObject:dateString forKey:@"booking_date"];
            
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
                     [[NSUserDefaults standardUserDefaults]setObject:self->ticketCountadd forKey:@"tickcount_arr"];
                     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
                     AttendeesViewController *attendees = [storyboard instantiateViewControllerWithIdentifier:@"AttendeesViewController"];
                     [self.navigationController pushViewController:attendees animated:YES];
                     
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
    
}
- (IBAction)backButton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BookingViewController *myNewVC = (BookingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"BookingViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
}
@end
