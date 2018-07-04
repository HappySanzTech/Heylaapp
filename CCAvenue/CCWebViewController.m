 //
//  CCPOViewController.m
//  CCIntegrationKit
//
//  Created by test on 5/12/14.
//  Copyright (c) 2014 Avenues. All rights reserved.
//

#import "CCWebViewController.h"
#import "CCResultViewController.h"
#import "CCTool.h"

#define BILLING_NAME @"billing_name"
#define BILLING_ADDRESS @"billing_address"
#define BILLING_CITY @"billing_city"
#define BILLING_STATE @"billing_state"
#define BILLING_ZIP @"billing_zip"
#define BILLING_COUNTRY @"billing_country"
#define BILLING_TEL @"billing_tel"
#define BILLING_EMAIL @"billing_email"
#define DELIVERY_NAME @"delivery_name"
#define DELIVERY_ADDRESS @"delivery_address"
#define DELIVERY_CITY @"delivery_city"
#define DELIVERY_STATE @"delivery_state"
#define DELIVERY_ZIP @"delivery_zip"
#define DELIVERY_COUNTRY @"delivery_country"
#define DELIVERY_TEL @"delivery_tel"


@interface CCWebViewController ()

@end

@implementation CCWebViewController

@synthesize rsaKeyUrl;@synthesize accessCode;@synthesize merchantId;@synthesize orderId;
@synthesize amount;@synthesize currency;@synthesize redirectUrl;@synthesize cancelUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.viewWeb.delegate = self;
    
    //Getting RSA Key
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *rsaKeyDataStr = [NSString stringWithFormat:@"access_code=%@&order_id=%@",accessCode,orderId];
    NSData *requestData = [NSData dataWithBytes: [rsaKeyDataStr UTF8String] length: [rsaKeyDataStr length]];
    NSMutableURLRequest *rsaRequest = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: rsaKeyUrl]];
    [rsaRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [rsaRequest setHTTPMethod: @"POST"];
    [rsaRequest setHTTPBody: requestData];
    
    
    // NSData *rsaKeyData = [NSURLConnection sendSynchronousRequest: rsaRequest returningResponse: nil error: nil];
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    [[[NSURLSession sharedSession] dataTaskWithRequest:rsaRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
        if ([httpResponse statusCode] == 200)
        {
            NSLog(@"Success");
            NSString *rsaKey = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            rsaKey = [rsaKey stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            rsaKey = [NSString stringWithFormat:@"-----BEGIN PUBLIC KEY-----\n%@\n-----END PUBLIC KEY-----\n",rsaKey];
            NSLog(@"%@",rsaKey);
            
            NSString *myRequestString = [NSString stringWithFormat:@"amount=%@&currency=%@",self->amount,self->currency];
            NSLog(@"%@",self->amount);
            CCTool *ccTool = [[CCTool alloc] init];
            NSString *encVal = [ccTool encryptRSA:myRequestString key:rsaKey];
            encVal = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                           (CFStringRef)encVal,
                                                                                           NULL,
                                                                                           (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                           kCFStringEncodingUTF8 ));
            
            NSString *urlAsString = [NSString stringWithFormat:@"https://secure.ccavenue.com/transaction/initTrans"];
            NSString *encryptedStr = [NSString stringWithFormat:@"merchant_id=%@&order_id=%@&redirect_url=%@&cancel_url=%@&enc_val=%@&access_code=%@",self->merchantId,self->orderId,self->redirectUrl,self->cancelUrl,encVal,self->accessCode];
            
            NSData *myRequestData = [NSData dataWithBytes: [encryptedStr UTF8String] length: [encryptedStr length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: urlAsString]];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
            [request setValue:urlAsString forHTTPHeaderField:@"Referer"];
            [request setHTTPMethod: @"POST"];
            [request setHTTPBody: myRequestData];
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               [self->_viewWeb loadRequest:request];
                           });
            
        }
        else
        {
            NSLog(@"Fail");
        }
        
    }] resume];
    

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    NSString *string = webView.request.URL.absoluteString;
    if ([string rangeOfString:@"/ccavResponseHandler.php"].location != NSNotFound)
    {
        NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
        
        NSString *transStatus = @"Not Known";
        
        if (([html rangeOfString:@"Aborted"].location != NSNotFound) ||
            ([html rangeOfString:@"Cancel"].location != NSNotFound))
        {
            transStatus = @"Transaction Cancelled";
            [[NSUserDefaults standardUserDefaults]setObject:@"TC" forKey:@"TranscationStatus"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
            CCResultViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"CCResultViewController"];
            [self.navigationController presentViewController:controller animated:YES completion:nil];
        }
        else if (([html rangeOfString:@"Success"].location != NSNotFound))
        {
            transStatus = @"Transaction Successful";
            [[NSUserDefaults standardUserDefaults]setObject:@"TS" forKey:@"TranscationStatus"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
            CCResultViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"CCResultViewController"];
            [self.navigationController presentViewController:controller animated:YES completion:nil];
            
        }
        else if (([html rangeOfString:@"Fail"].location != NSNotFound))
        {
            transStatus = @"Transaction Failed";
            [[NSUserDefaults standardUserDefaults]setObject:@"TF" forKey:@"TranscationStatus"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
            CCResultViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"CCResultViewController"];
            [self.navigationController presentViewController:controller animated:YES completion:nil];
        }
        
//        CCResultViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCResultViewController"];
//        controller.transStatus = transStatus;
//        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentViewController:controller animated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
- (IBAction)backbutton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
