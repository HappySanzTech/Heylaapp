//
//  CCInitViewController.m
//  CCIntegrationKit
//
//  Created by test on 7/14/14.
//  Copyright (c) 2014 Avenues. All rights reserved.
//

#import "CCInitViewController.h"
#import "CCWebViewController.h"

@interface CCInitViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation CCInitViewController

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
    
    
    self.accessCode.text = @"AVWD63DB90AK18DWKA";
    self.merchantId.text = @"89958";
    self.currency.text = @"INR";
    self.amount.text = appDel.total_price;
    NSLog(@"%@",self.amount.text);
    self.accessCode.hidden = YES;
    self.merchantId.hidden = YES;
    self.currency.hidden = YES;
    self.amount.hidden = YES;

    self.cancelUrl.hidden = YES;
    self.redirectUrl.hidden = YES;
    self.rsaKeyUrl.hidden = YES;
    self.orderId.hidden = YES;
    
    UIButton *nextBtn = (UIButton*)[self.view viewWithTag:1];
    [nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
}

//-(void)viewWillAppear:(BOOL)animated
//{
////    [[UIHelper sharedInstance] hideHudInView:self.view];
//
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextClick:(id)sender
{
//    [[UIHelper sharedInstance] showHudInView:self.view];


    CCWebViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCWebViewController"];
    
    controller.accessCode = @"AVYQ00EB90CF69QYFC";
    controller.merchantId = @"89958";
    controller.amount = appDel.total_price;
    NSLog(@"%@",controller.amount);
    controller.currency = @"INR";
    controller.orderId =  appDel.order_id;
    controller.redirectUrl = @"http://hobbistan.com/app/hobbistan/ccavenue/PHP/ccavResponseHandler.php";
    controller.cancelUrl = @"http://hobbistan.com/app/hobbistan/ccavenue/PHP/ccavResponseHandler.php";
    controller.rsaKeyUrl = @"http://hobbistan.com/app/hobbistan/ccavenue/PHP/GetRSA.php";
    

    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];

}

-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}
 
- (IBAction)backbutton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}
@end
