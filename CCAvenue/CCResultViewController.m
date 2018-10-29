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
    self.navigationItem.titleView = imgView;
    self.navigationItem.hidesBackButton = YES;
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    self.mainView.layer.cornerRadius = 5.0;
    self.continueOtlet.layer.cornerRadius = 5.0;
    NSDate *currentDate = [[NSDate alloc] init];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *localDateString = [dateFormatter stringFromDate:currentDate];
    NSString *strStatus = [[NSUserDefaults standardUserDefaults]objectForKey:@"TranscationStatus"];
    if ([strStatus isEqualToString:@"TXN_SUCCESS"])
    {
        self.mainView.backgroundColor = [UIColor whiteColor];
        self.statusImageView.image = [UIImage imageNamed:@"paymentsucess"];
        self.orderNumber.text = appDel.order_id;
        self.transcationDate.text = localDateString;
        self.amount.text = appDel.price;
        self.statusLabel.text = @"Transaction Success !";
        self.statusLabel.textColor = [UIColor colorWithRed:64/255.0f green:181/255.0f blue:73/255.0f alpha:1.0];
        self.FinalStatus.text = @"Success";
        [_continueOtlet setTitle:@"Continue" forState:UIControlStateNormal];
        _continueOtlet.layer.backgroundColor = [UIColor colorWithRed:64/255.0f green:181/255.0f blue:73/255.0f alpha:1.0].CGColor;
    }
    else if ([strStatus isEqualToString:@"TXN_CANCEL"])
    {
        self.mainView.backgroundColor = [UIColor whiteColor];
        self.statusImageView.image = [UIImage imageNamed:@"paymentcancel"];
        self.orderNumber.text = appDel.order_id;
        self.transcationDate.text = localDateString;
        self.amount.text = appDel.price;
        self.statusLabel.text = @"Transaction Cancel";
        self.statusLabel.textColor = [UIColor colorWithRed:244/255.0f green:163/255.0f blue:55/255.0f alpha:1.0];
        self.FinalStatus.text = @"Canceled";
        [_continueOtlet setTitle:@"Try Again" forState:UIControlStateNormal];
        _continueOtlet.layer.backgroundColor = [UIColor colorWithRed:244/255.0f green:163/255.0f blue:55/255.0f alpha:1.0].CGColor;
    }
    else
    {
        self.mainView.backgroundColor = [UIColor whiteColor];
        self.statusImageView.image = [UIImage imageNamed:@"paymentfailed"];
        self.orderNumber.text = appDel.order_id;
        self.transcationDate.text = localDateString;
        self.amount.text = appDel.price;
        self.statusLabel.text = @"Transaction Failed";
        self.statusLabel.textColor = [UIColor colorWithRed:191/255.0f green:59/255.0f blue:48/255.0f alpha:1.0];
        self.FinalStatus.text = @"Failed";
        [_continueOtlet setTitle:@"Try Again" forState:UIControlStateNormal];
        _continueOtlet.layer.backgroundColor = [UIColor colorWithRed:191/255.0f green:59/255.0f blue:48/255.0f alpha:1.0].CGColor;
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
    
    NSString *strStatus = [[NSUserDefaults standardUserDefaults]objectForKey:@"TranscationStatus"];
    if ([strStatus isEqualToString:@"TXN_SUCCESS"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AttendeesViewController *attendeesViewController = (AttendeesViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AttendeesViewController"];
        [self.navigationController pushViewController:attendeesViewController animated:YES];
    }
    else
    {
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

    }
    
}
@end
