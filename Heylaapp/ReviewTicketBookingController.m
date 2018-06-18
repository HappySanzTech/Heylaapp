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
    self.mainView.layer.cornerRadius = 8.0;
    self.mainView.clipsToBounds = YES;
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
    NSString *time = appDel.event_SelectedTime;
    self.eventTime.text = time;
    self.eventlocation.text = appDel.event_Address;
    self.totalTickets.text = [NSString stringWithFormat:@"%@ %@",appDel.totalTickets,@"Tickets"];
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [df dateFromString:appDel.bookingdate];
    
    NSDateFormatter *dfTwo = [[NSDateFormatter alloc]init];
    [dfTwo setDateFormat:@"MMMM dd YYYY"];
    NSString *strDate = [dfTwo stringFromDate:date];
    self.eventdate.text = strDate;
//    [NSString stringWithFormat:@"%@ - %@",appDel.event_StartDate,appDel.event_EndDate];
    self.totalPrice.text = [NSString stringWithFormat:@"%@%@",@"Rs.",appDel.price];
    self.ticketPrice.text = [NSString stringWithFormat:@"%@%@",@"Rs.",appDel.price];
    btnClick =@"0";
    [ticketCountadd removeAllObjects];
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
- (IBAction)payNowButton:(id)sender
{
     self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
     UIStoryboard *eventStoryBoard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
     CCWebViewController* controller = [eventStoryBoard instantiateViewControllerWithIdentifier:@"CCWebViewController"];
     controller.accessCode = @"AVWD63DB90AK18DWKA";
     controller.merchantId = @"89958";
     controller.amount = self->appDel.total_price;
     controller.currency = @"INR";
     controller.orderId =  self->appDel.order_id;
     controller.redirectUrl = @"http://hobbistan.com/app/hobbistan/ccavenue/PHP/ccavResponseHandler.php";
     controller.cancelUrl = @"http://hobbistan.com/app/hobbistan/ccavenue/PHP/ccavResponseHandler.php";
     controller.rsaKeyUrl = @"http://hobbistan.com/app/hobbistan/ccavenue/PHP/GetRSA.php";
    
     controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
     [self.navigationController pushViewController:controller animated:YES];
                     
 
}
- (IBAction)backButton:(id)sender
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    BookingViewController *myNewVC = (BookingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"BookingViewController"];
//    [self.navigationController pushViewController:myNewVC animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
