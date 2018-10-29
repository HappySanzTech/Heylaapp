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
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
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
        
        cell.name.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"statFull_Name"];
        
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 225;
    }
    else
    {
        return 195;

    }
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
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
//    [navigationController setViewControllers:@[[storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"]]];
//    SideMenuMainViewController *sideMenuMainViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SideMenuMainViewController"]; //or
//    sideMenuMainViewController.rootViewController = navigationController;
//    [sideMenuMainViewController setupWithType:0];
//    self.window.rootViewController = navigationController;
//    [self.window makeKeyAndVisible];
//    UIWindow *window = UIApplication.sharedApplication.delegate.window;
//    window.rootViewController = sideMenuMainViewController;
//
//    [UIView transitionWithView:window
//                      duration:0.3
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:nil
//                    completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)payNowbtn:(id)sender
{
    __block NSString *check = nil;
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
             check = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             if ([msg isEqualToString:@"Attendees Added"] && [status isEqualToString:@"success"])
             {
                 NSLog(@"%@",check);
                 //if ([check isEqualToString:@"Attendees Added"])
                 //{
                 //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 //ReviewTicketBookingController *reviewTicketBookingController = (ReviewTicketBookingController *)[storyboard instantiateViewControllerWithIdentifier:@"ReviewTicketBookingController"];
                 //[self.navigationController pushViewController:reviewTicketBookingController animated:YES];
                 //}
             }
         }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
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
//-(void)navigation_NextView
//{
//    if ([msg isEqualToString:@"Attendees Added"])
//    {
//        [self performSegueWithIdentifier:@"to_ReviewPage" sender:self];
//    }
//}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
