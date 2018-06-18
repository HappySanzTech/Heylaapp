//
//  CCResultViewController.m
//  CCIntegrationKit
//
//  Created by test on 5/16/14.
//  Copyright (c) 2014 Avenues. All rights reserved.
//

#import "CCResultViewController.h"
#import "CCInitViewController.h"

@interface CCResultViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation CCResultViewController
//@synthesize transStatus;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    UIImage *img = [UIImage imageNamed:@"heylalogomainpage.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imgView setImage:img];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.mainView.layer.cornerRadius = 5.0;
    self.continueOtlet.layer.cornerRadius = 5.0;
    NSDate *currentDate = [[NSDate alloc] init];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"MMMM dd yyyy"];
    NSString *localDateString = [dateFormatter stringFromDate:currentDate];
    NSString *strStatus = [[NSUserDefaults standardUserDefaults]objectForKey:@"TranscationStatus"];
    if ([strStatus isEqualToString:@"TS"])
    {
        
        self.mainView.backgroundColor = [UIColor colorWithRed:138/255.0f green:195/255.0f blue:83/255.0f alpha:1.0];
        self.statusImageView.image = [UIImage imageNamed:@"paymentsucess"];
        self.orderNumber.text = appDel.order_id;
        self.transcationDate.text = localDateString;
        self.amount.text = appDel.total_price;
        self.statusLabel.text = @"Payment Success";
        self.FinalStatus.text = @"Success";
        [_continueOtlet setTitle:@"Continue" forState:UIControlStateNormal];
        [_continueOtlet setTitleColor:[UIColor colorWithRed:138/255.0f green:195/255.0f blue:83/255.0f alpha:1.0] forState:UIControlStateNormal];

    }
    else if ([strStatus isEqualToString:@"TC"])
    {
        self.mainView.backgroundColor = [UIColor colorWithRed:242/255.0f green:163/255.0f blue:68/255.0f alpha:1.0];
        self.statusImageView.image = [UIImage imageNamed:@"paymentcancel"];
        self.orderNumber.text = appDel.order_id;
        self.transcationDate.text = localDateString;
        self.amount.text = appDel.total_price;
        self.statusLabel.text = @"Payment Cancel";
        self.FinalStatus.text = @"Cancel";
        [_continueOtlet setTitle:@"Try Again" forState:UIControlStateNormal];
        [_continueOtlet setTitleColor:[UIColor colorWithRed:242/255.0f green:163/255.0f blue:68/255.0f alpha:1.0] forState:UIControlStateNormal];
    }
    else
    {
        self.mainView.backgroundColor = [UIColor colorWithRed:188/255.0f green:61/255.0f blue:45/255.0f alpha:1.0];
        self.statusImageView.image = [UIImage imageNamed:@"paymentfailed"];
        self.orderNumber.text = appDel.order_id;
        self.transcationDate.text = localDateString;
        self.amount.text = appDel.total_price;
        self.statusLabel.text = @"Payment Failed";
        self.FinalStatus.text = @"Failed";
        [_continueOtlet setTitle:@"Try Again" forState:UIControlStateNormal];
        [_continueOtlet setTitleColor:[UIColor colorWithRed:188/255.0f green:61/255.0f blue:45/255.0f alpha:1.0] forState:UIControlStateNormal];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)continueBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
