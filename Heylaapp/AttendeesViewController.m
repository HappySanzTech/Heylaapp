//
//  AttendeesViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 31/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "AttendeesViewController.h"

@interface AttendeesViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *seats;
    NSMutableArray *nameArr;
    NSMutableArray *emailArr;
    NSMutableArray *mobArr;

}
@end

@implementation AttendeesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    seats =  [[NSMutableArray alloc]init];
    seats = [[NSUserDefaults standardUserDefaults]objectForKey:@"tickcount_arr"];
    nameArr = [[NSMutableArray alloc]init];
    emailArr = [[NSMutableArray alloc]init];
    mobArr = [[NSMutableArray alloc]init];
    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.bottom = keyboardRect.size.height;
    self.tableView.contentInset = contentInset;
}
- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = contentInsets;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [seats count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        AttendeesTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"staticCell" forIndexPath:indexPath];
        
        cell.name.delegate = self;
        
        cell.email.delegate = self;
        
        cell.mobNum.delegate = self;
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        cell.name.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"statUser_Name"];
        
        [nameArr addObject:cell.name.text ];

        NSLog(@"%@",appDel.user_name);
        
        cell.email.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"statemail_id"];
        
        [emailArr addObject:cell.email.text];

        NSLog(@"%@",appDel.email_id);
        
        cell.mobNum.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"statemobile_no"];
        
        [mobArr addObject:cell.mobNum.text];

        NSLog(@"%@",appDel.mobile_no);
        
        return cell;
    }
    else
    {
        AttendeesTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"dynamicCell" forIndexPath:indexPath];
        
        cell.name.delegate = self;
        
        cell.email.delegate = self;
        
        cell.mobNum.delegate = self;
        
        return cell;

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 195;
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    AttendeesTableViewCell *cell = (AttendeesTableViewCell*)theTextField.superview.superview;

    if (theTextField.tag == 1)
    {
    [cell.email becomeFirstResponder];
    }
    else if (theTextField.tag == 2)
    {
        [cell.mobNum becomeFirstResponder];
        
    }
    else if (theTextField.tag == 3)
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    AttendeesTableViewCell *cell = (AttendeesTableViewCell*) textField.superview.superview;
    NSIndexPath *txtIndPath = [self.tableView indexPathForCell:cell];
    NSInteger index = txtIndPath.row;
    NSLog(@"%ld",(long)index);
    
    if (textField.tag == 1)
    {
        [nameArr addObject:textField.text];
    }
    else if (textField.tag == 2)
    {
        
        [emailArr addObject:textField.text];
    }
    else if (textField.tag == 3)
    {
       [mobArr addObject:textField.text];
       
    }
    if ([textField.superview.superview isKindOfClass:[UITableViewCell class]])
    {
        AttendeesTableViewCell *cell = (AttendeesTableViewCell*)textField.superview.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:TRUE];
    }
    
    return YES;
}

- (IBAction)backBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:homeViewController animated:self];
}

- (IBAction)payNowbtn:(id)sender
{
        NSString *strName;
        NSString *stremail;
        NSString *strMob_no;

        for (int i = 0; i < [seats count]; i++)
        {
           
            @try
            {
                strName = [nameArr objectAtIndex:i];
                
                stremail = [emailArr objectAtIndex:i];
                
                strMob_no = [mobArr objectAtIndex:i];
            }
            @catch (NSException *exception)
            {
              
                strName =@"";
                
                stremail =@"";

                strMob_no =@"";

            }
            
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:appDel.order_id forKey:@"order_id"];
            [parameters setObject:strName forKey:@"name"];
            [parameters setObject:stremail forKey:@"email_id"];
            [parameters setObject:strMob_no forKey:@"mobile_no"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            
            NSString *bookingAttendees = @"apimain/bookingAttendees";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,bookingAttendees, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 
                 NSLog(@"%@",responseObject);
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSString *status = [responseObject objectForKey:@"status"];
                 if ([msg isEqualToString:@"Attendees Added"] && [status isEqualToString:@"success"])
                 {
                     
                 }
                 
             }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
             {
                 NSLog(@"error: %@", error);
             }];
        }
            [self navigation_NextView];
}
-(void)navigation_NextView
{
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *eventStoryBoard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    CCWebViewController* controller = [eventStoryBoard instantiateViewControllerWithIdentifier:@"CCWebViewController"];
    controller.accessCode = @"AVWD63DB90AK18DWKA";
    controller.merchantId = @"89958";
    controller.amount = appDel.total_price;
    controller.currency = @"INR";
    controller.orderId =  appDel.order_id;
    controller.redirectUrl = @"http://hobbistan.com/app/hobbistan/ccavenue/PHP/ccavResponseHandler.php";
    controller.cancelUrl = @"http://hobbistan.com/app/hobbistan/ccavenue/PHP/ccavResponseHandler.php";
    controller.rsaKeyUrl = @"http://hobbistan.com/app/hobbistan/ccavenue/PHP/GetRSA.php";
    
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
