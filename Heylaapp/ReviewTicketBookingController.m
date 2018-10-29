//
//  ReviewTicketBookingController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 18/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "ReviewTicketBookingController.h"
#import "PaymentsSDK.h"

@interface ReviewTicketBookingController ()
{
    AppDelegate *appDel;
    NSMutableArray *ticketCountadd;
    NSString *btnClick;
    NSString *CALLBACK_URL;
    NSString *CHANNEL_ID;
    NSString *CHECKSUMHASH;
    NSString *CUST_ID;
    NSString *INDUSTRY_TYPE_ID;
    NSString *MID;
    NSString *ORDER_ID;
    NSString *TXN_AMOUNT;
    NSString *WEBSITE;
    NSString *payt_STATUS;
    NSString *TXNID;
    NSString *PAYMENTMODE;
    NSString *TXNDATE;
    NSString *STATUS;
    NSString *RESPCODE;
    NSString *RESPMSG;
    NSString *GATEWAYNAME;
    NSString *BANKTXNID;
    NSString *BANKNAME;
    NSString *PaytmServicecall;

    NSTimer *timer;
    int currMinute;
    int currSeconds;
}
@property (nonatomic, strong) NSTimer *statusTimer;

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
    
    CALLBACK_URL = @"";
    CHANNEL_ID  = @"";
    CHECKSUMHASH  = @"";
    CUST_ID  = @"";
    INDUSTRY_TYPE_ID  = @"";
    MID  = @"";
    ORDER_ID  = @"";
    TXN_AMOUNT  = @"";
    WEBSITE  = @"";
    payt_STATUS  = @"";
    TXNID  = @"";
    PAYMENTMODE  = @"";
    TXNDATE  = @"";
    STATUS  = @"";
    RESPCODE  = @"";
    RESPMSG  = @"";
    GATEWAYNAME  = @"";
    BANKTXNID  = @"";
    BANKNAME  = @"";
    PaytmServicecall = @"";
    
    currMinute = 3;
    currSeconds = 00;
    [self startTimer];
}
-(void)startTimer
{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(updateTime)
                                           userInfo:nil
                                            repeats:YES];
}
-(void)updateTime
{
    if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        if(currSeconds==0)
        {
            currMinute-=1;
            currSeconds=59;
        }
        else if(currSeconds>0)
        {
            currSeconds-=1;
        }
        if  (currMinute>-1)
            [_sessionLabel setText:[NSString stringWithFormat:@"%@%d%@%02d",@"Session has Expired In : ",currMinute,@":",currSeconds]];
    }
    else
    {
        [timer invalidate];

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
        [navigationController setViewControllers:@[[storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"]]];
        
        SideMenuMainViewController *sideMenuMainViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SideMenuMainViewController"]; //or
        sideMenuMainViewController.rootViewController = navigationController;
        [sideMenuMainViewController setupWithType:0];
        self.window.rootViewController = navigationController;
        [self.window makeKeyAndVisible];
        
        UIWindow *window = UIApplication.sharedApplication.delegate.window;
        window.rootViewController = sideMenuMainViewController;
        
        [UIView transitionWithView:window
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:nil
                        completion:nil];
        
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Heyla"
                                       message:@"Session has Expired"
                                       preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {

                                 }];

            UIAlertAction *cancel = [UIAlertAction
                                     actionWithTitle:@"Cancel"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {

                                     }];

            [alert addAction:ok];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
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
- (IBAction)payNowButton:(id)sender
{
    [timer invalidate];

    PaytmServicecall = @"YES";
    // Create the configuration, which is necessary so we can cancel cacheing amongst other things.
    NSURLSessionConfiguration * defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    // Disables cacheing
    defaultConfigObject.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString * scriptURL = [NSString stringWithFormat:@"https://heylaapp.com/paytm_app/generateChecksum.php"];
    //Converts the URL string to a URL usable by NSURLSession
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:scriptURL]];
    NSString * postDataString = [NSString stringWithFormat:@"ORDER_ID=%@&TXN_AMOUNT=%@&CUST_ID=%@",appDel.order_id,appDel.price,appDel.user_Id];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[postDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest];
    // Fire the data task.
    [dataTask resume];
}
- (NSString *)URLEncode:(NSString *)originalString encoding:(NSStringEncoding)encoding
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                 kCFAllocatorDefault,
                                                                                 (__bridge CFStringRef)originalString,
                                                                                 NULL,
                                                                                 CFSTR(":/?#[]@!$&'()*+,;="),
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    // Handler allows us to receive and parse responses from the server
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    // Parse the JSON that came in into an NSDictionary
    NSError * err = nil;
    NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
    
    if ([PaytmServicecall isEqualToString:@"YES"])
    {
        self->CALLBACK_URL = [jsonDict objectForKey:@"CALLBACK_URL"];
        self->CHANNEL_ID = [jsonDict objectForKey:@"CHANNEL_ID"];
        self->CHECKSUMHASH = [jsonDict objectForKey:@"CHECKSUMHASH"];
        self->CUST_ID = [jsonDict objectForKey:@"CUST_ID"];
        self->INDUSTRY_TYPE_ID = [jsonDict objectForKey:@"INDUSTRY_TYPE_ID"];
        self->MID = [jsonDict objectForKey:@"MID"];
        self->WEBSITE = [jsonDict objectForKey:@"WEBSITE"];
        self->payt_STATUS = [jsonDict objectForKey:@"payt_STATUS"];
        self->ORDER_ID = [jsonDict objectForKey:@"ORDER_ID"];
        self->TXN_AMOUNT = [jsonDict objectForKey:@"TXN_AMOUNT"];
        
        [self paytmKaro];
    }
    else
    {
        NSString *msg = [jsonDict objectForKey:@"message"];
        NSLog(@"%@",msg);
        
    }
}
-(void)paytmKaro
{
    PaytmServicecall = @"NO";

    self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    PGOrder *order = [PGOrder orderForOrderID:self->ORDER_ID
                                   customerID:self->CUST_ID
                                            amount:self->TXN_AMOUNT
                                 customerMail:@""
                               customerMobile:@""];
    
    order.params =   @{@"MID" : self->MID,
                       @"ORDER_ID": self->ORDER_ID,
                       @"CUST_ID" : self->CUST_ID,
                       @"CHANNEL_ID": self->CHANNEL_ID,
                       @"INDUSTRY_TYPE_ID": self->INDUSTRY_TYPE_ID,
                       @"WEBSITE": self->WEBSITE,
                       @"TXN_AMOUNT": self->TXN_AMOUNT,
                       @"CHECKSUMHASH":self->CHECKSUMHASH,
                       @"CALLBACK_URL":self->CALLBACK_URL
                       };
    PGTransactionViewController *txnController = [[PGTransactionViewController alloc] initTransactionForOrder:order];
    txnController.loggingEnabled = YES;
    
    txnController.serverType = eServerTypeProduction;
    txnController.merchant = [PGMerchantConfiguration defaultConfiguration];
    txnController.delegate = self;
         
    [self.navigationController pushViewController:txnController animated:YES];
}
- (void)checkStatus:(id)sender
{
    self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [PGServerEnvironment statusForOrderID:appDel.order_id responseHandler:^(NSDictionary *response, NSError *error)
     {
         if (error)DEBUGLOG(@"STATUS ERROR: %@",error.localizedDescription);
         else      DEBUGLOG(@"STATUS RESPONSE: %@",response.description);
     }];
}
-(void)didFinishedResponse:(PGTransactionViewController *)controller response:(NSString *)responseString
{
    DEBUGLOG(@"ViewController::didFinishedResponse:response = %@", responseString);
    [controller.navigationController popViewControllerAnimated:YES];

    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
    
    self->MID = [jsonData valueForKey:@"MID"];
    self->STATUS = [jsonData valueForKey:@"STATUS"];
    self->ORDER_ID = [jsonData valueForKey:@"ORDERID"];
    self->TXN_AMOUNT = [jsonData valueForKey:@"TXNAMOUNT"];
    
    self->TXNID  = [jsonData valueForKey:@"TXNID"];
    self->BANKTXNID = [jsonData valueForKey:@"BANKTXNID"];
    self->GATEWAYNAME  = [jsonData valueForKey:@"GATEWAYNAME"];
    self->RESPCODE  = [jsonData valueForKey:@"RESPCODE"];
    self->RESPMSG  = [jsonData valueForKey:@"RESPMSG"];
    self->BANKNAME  = [jsonData valueForKey:@"BANKNAME"];
    self->PAYMENTMODE  = [jsonData valueForKey:@"PAYMENTMODE"];
    self->TXNDATE  = [jsonData valueForKey:@"TXNDATE"];
    
    NSURLSessionConfiguration * defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    // Disables cacheing
    defaultConfigObject.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSString * scriptURL = [NSString stringWithFormat:@"https://heylaapp.com/paytm_app/TxnStatus.php"];
    //Converts the URL string to a URL usable by NSURLSession
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:scriptURL]];
    NSString * postDataString = [NSString stringWithFormat:@"MID=%@&STATUS=%@&ORDERID=%@&TXNAMOUNT=%@&TXNID=%@&BANKTXNID=%@&GATEWAYNAME=%@&RESPCODE=%@&RESPMSG=%@&BANKNAME=%@&PAYMENTMODE=%@&TXNDATE=%@",MID,STATUS,ORDER_ID,TXN_AMOUNT,TXNID,BANKTXNID,GATEWAYNAME,RESPCODE,RESPMSG,BANKNAME,PAYMENTMODE,TXNDATE];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[postDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest];
    // Fire the data task.
    [dataTask resume];
    
    [[NSUserDefaults standardUserDefaults]setObject:STATUS forKey:@"TranscationStatus"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    CCResultViewController *cCResultViewController = (CCResultViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CCResultViewController"];
    [self.navigationController pushViewController:cCResultViewController animated:YES];

}
-(void)didCancelTrasaction:(PGTransactionViewController *)controller
{
    [_statusTimer invalidate];
    NSString *msg = [NSString stringWithFormat:@"UnSuccessful"];
    NSLog(@"%@",msg);
    [[NSUserDefaults standardUserDefaults]setObject:@"TXN_CANCEL" forKey:@"TranscationStatus"];
    self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.price = @"Rs.0";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    CCResultViewController *cCResultViewController = (CCResultViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CCResultViewController"];
    [self.navigationController pushViewController:cCResultViewController animated:YES];
//  [[[UIAlertView alloc] initWithTitle:@"Transaction Cancel" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//    UIAlertController *alert= [UIAlertController
//                               alertControllerWithTitle:@"Transaction Cancel"
//                               message:msg
//                               preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *ok = [UIAlertAction
//                         actionWithTitle:@"OK"
//                         style:UIAlertActionStyleDefault
//                         handler:^(UIAlertAction * action)
//                         {
//                             [self dismissViewControllerAnimated:YES completion:nil];
//
//                         }];
//
//    UIAlertAction *cancel = [UIAlertAction
//                             actionWithTitle:@"Cancel"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//
//                             }];
//
//    [alert addAction:ok];
//    [alert addAction:cancel];
//    [self presentViewController:alert animated:YES completion:nil];
 //   [controller.navigationController popViewControllerAnimated:YES];
}
//Called when a required parameter is missing.
-(void)errorMisssingParameter:(PGTransactionViewController *)controller error:(NSError *) error {
    DEBUGLOG(@"Parameter is missing %@",error.localizedDescription);
    [controller.navigationController popViewControllerAnimated:YES];
}
- (IBAction)backButton:(id)sender
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    BookingViewController *myNewVC = (BookingViewController *)[storyboard instantiateViewControllerWithIdentifier:@"BookingViewController"];
//    [self.navigationController pushViewController:myNewVC animated:YES];
      [self dismissViewControllerAnimated:YES completion:nil];
}
@end
