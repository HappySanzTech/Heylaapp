//
//  LoginViewController.m
//  Heylaapp
//
//  Created by HappySanz on 25/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "LoginViewController.h"
#import "ACFloatingTextField.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface LoginViewController ()
{
    NSString *signInPasswordEyeFlag;
    NSString *signUpPasswordEyeFlag;
    NSString *checkBoxFlage;
    NSString *facebookName;
    NSString *facebookEmail_id;
    NSString *fbprofilePic;
    NSString *fbID;
    AppDelegate *appDel;
    CLLocationManager *objLocationManager;
    double latitude_UserLocation, longitude_UserLocation;
    NSString *address;
}
@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _login.layer.cornerRadius = 8;
    _login.clipsToBounds = YES;
    _facebook.layer.cornerRadius = 8;
    _facebook.clipsToBounds = YES;
    _google.layer.cornerRadius = 8;
    _google.layer.borderWidth = 0.5;
    _google.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _google.clipsToBounds = YES;
    _signUpBtnOtlet.layer.cornerRadius = 8;
    _signUpBtnOtlet.clipsToBounds = YES;
    self.signUpView.hidden = YES;
    self.signInView.hidden = NO;
    self.signInUserName.tag = 1;
    self.signInPassword.tag = 2;
    _signInUserName.delegate = self;
    _signInPassword.delegate = self;
    _SignUpUserName.delegate = self;
    _SignUpMobileNo.delegate = self;
    _signUpPassword.delegate = self;
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    _SignUpMobileNo.inputAccessoryView = numberToolbar;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    signUpPasswordEyeFlag = @"0";
    signInPasswordEyeFlag = @"0";
    checkBoxFlage = @"0";
    NSString *remember_Me = [[NSUserDefaults standardUserDefaults]objectForKey:@"remember_me"];
    if ([remember_Me isEqualToString:@"YES"])
    {
        self.signInUserName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        self.signInPassword.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];

        if ([self.signInUserName.text isEqualToString:@""])
        {
            self.signInUserName.text = @"";
            [_checkBoxBtn setSelected:NO];
            checkBoxFlage =@"1";
        }
        else
        {
            [_checkBoxBtn setSelected:YES];
            checkBoxFlage =@"0";
        }
         if([self.signInPassword.text isEqualToString:@""])
        {
            self.signInPassword.text = @"";
            [_checkBoxBtn setSelected:NO];
            checkBoxFlage =@"1";
        }
        else
        {
            [_checkBoxBtn setSelected:YES];
            checkBoxFlage =@"0";
        }
    }
    [self loadUserLocation];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
- (void)loadUserLocation
{
    objLocationManager = [[CLLocationManager alloc] init];
    objLocationManager.delegate = self;
    objLocationManager.distanceFilter = kCLDistanceFilterNone;
    objLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([objLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [objLocationManager requestWhenInUseAuthorization];
    }
    [objLocationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0)
{
    CLLocation *newLocation = [locations objectAtIndex:0];
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    NSLog(@"%@",newLocation);
    [objLocationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSString *address = [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@",
                                  placemark.thoroughfare,
                                  placemark.locality,
                                  placemark.subLocality,
                                  placemark.administrativeArea,
                                  placemark.postalCode,
                                  placemark.country];
             NSLog(@"%@", address);
             NSArray *splitArray = [address componentsSeparatedByString:@","];
             NSString *City = [splitArray objectAtIndex:1];
             NSArray *spiltSpace = [City componentsSeparatedByString:@" "];
             NSString *locatedCity = [spiltSpace objectAtIndex:1];
             [[NSUserDefaults standardUserDefaults]setObject:locatedCity forKey:@"locatedCity"];
         }
     }];
}
-(void)cancelNumberPad
{
    [_SignUpMobileNo resignFirstResponder];
    _SignUpMobileNo.text = @"";
}
-(void)doneWithNumberPad
{
    [_SignUpMobileNo resignFirstResponder];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.scrollViewTwo.contentSize = CGSizeMake(self.view.frame.size.width,410);
}
- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    UIEdgeInsets contentInset = self.scrollViewTwo.contentInset;
    contentInset.bottom = keyboardRect.size.height;
    self.scrollViewTwo.contentInset = contentInset;
}
- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollViewTwo.contentInset = contentInsets;
}
-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if (self.signInUserName.tag ==1)
    {
        self.signUpView.hidden = NO;
        self.signInView.hidden = YES;
        _signUP.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [_signUP setTitleColor:[UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];
        _signIn.layer.backgroundColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0].CGColor;
        [_signIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if (self.signInPassword.tag ==2)
    {
        self.signUpView.hidden = YES;
        self.signInView.hidden = NO;
        _signIn.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [_signIn setTitleColor:[UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];
        _signUP.layer.backgroundColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0].CGColor;
        [_signUP setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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

- (IBAction)signInBtn:(id)sender
{
    if (self.signInUserName.tag ==1)
    {
        self.signUpView.hidden = YES;
        self.signInView.hidden = NO;
        _signIn.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [_signIn setTitleColor:[UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];
        _signUP.layer.backgroundColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0].CGColor;
        [_signUP setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
- (IBAction)signUpBtn:(id)sender
{
    if (self.signInPassword.tag ==2)
    {
        self.signUpView.hidden = NO;
        self.signInView.hidden = YES;
        _signUP.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [_signUP setTitleColor:[UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0] forState:UIControlStateNormal];
        _signIn.layer.backgroundColor = [UIColor colorWithRed:68/255.0 green:142/255.0 blue:203/255.0 alpha:1.0].CGColor;
        [_signIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
- (IBAction)forgotPasswordBtn:(id)sender
{
    [self performSegueWithIdentifier:@"to_forgot_Password" sender:self];
}
- (IBAction)facebookBtn:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    UIViewController *vc=self.view.window.rootViewController;
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    login.loginBehavior=FBSDKLoginBehaviorWeb;
    [login logOut];
    [login logInWithReadPermissions:@[@"public_profile",@"email"]  fromViewController:vc handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error) {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSLog(@"There was an error with FB:n %@",error.description);
         }
         else if (result.isCancelled) {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }
         else {
             if ([result.grantedPermissions containsObject:@"email"]) {
                 NSLog(@"permissions granted! %@",[[FBSDKAccessToken currentAccessToken]permissions]);
                 [self facebookInfo];
                 NSLog(@"RESULT %@",result);
             }else{
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 NSLog(@"permissions NOT granted");
             }
         }
     }];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)facebookInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields" : @"id,email,first_name,last_name,link,locale"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
    {
         if (!error)
         {
             NSLog(@"fetched user:%@  and Email : %@", result,result[@"email"]);
             NSLog(@"fetched user:%@  and Email : %@", result,result[@"first_name"]);
             self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
             self->fbID=[result objectForKey:@"id"];
             NSString *firstName = [result objectForKey:@"first_name"];
             NSString *lastName = [result objectForKey:@"last_name"];
             self->facebookEmail_id = [result objectForKey:@"email"];
             self->facebookName = [NSString stringWithFormat:@"%@%@",firstName,lastName];
             self->fbprofilePic = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",self->fbID];
             NSURL *fbPicURL = [NSURL URLWithString:self->fbprofilePic];
             self->appDel.picture_url = fbPicURL.absoluteString;
             NSLog(@"%@",self->appDel.picture_url);
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.picture_url forKey:@"picture_Url"];
             [self facebookLogin];
         }
     }];
}
-(void)facebookLogin
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken_Key"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:facebookName forKey:@"name"];
    [parameters setObject:facebookEmail_id forKey:@"email_id"];
    [parameters setObject:deviceToken forKey:@"gcm_key"];
    [parameters setObject:@"2" forKey:@"mobile_type"];
    [parameters setObject:@"1" forKey:@"login_type"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *fbLogin = @"apimain/socialLogin";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,fbLogin, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         if ([msg isEqualToString:@"Login Successfully"] && [status isEqualToString:@"Success"])
         {
             NSDictionary *dict = [responseObject objectForKey:@"userData"];
             self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
             NSString *user_id = [dict objectForKey:@"user_id"];
             self->appDel.user_Id = [dict objectForKey:@"user_id"];
             self->appDel.address_line_1 = [dict objectForKey:@"address_line_1"];
             self->appDel.address_line_2 = [dict objectForKey:@"address_line_2"];
             self->appDel.address_line_3 = [dict objectForKey:@"address_line_3"];
             self->appDel.birth_date = [dict objectForKey:@"birth_date"];
             self->appDel.city_id = [dict objectForKey:@"city_id"];
             self->appDel.city_name = [dict objectForKey:@"city_name"];
             self->appDel.country_id = [dict objectForKey:@"country_id"];
             self->appDel.country_name = [dict objectForKey:@"country_name"];
             NSString *emailId = [dict objectForKey:@"email_id"];
             self->appDel.email_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"statemail_id"];
             self->appDel.email_verify_status = [dict objectForKey:@"email_verify_status"];
             self->appDel.full_name = [dict objectForKey:@"full_name"];
             self->appDel.gender = [dict objectForKey:@"gender"];
             NSString *mobile_no = [dict objectForKey:@"mobile_no"];
             self->appDel.mobile_no = [[NSUserDefaults standardUserDefaults]objectForKey:@"statemobile_no"];
             self->appDel.newsletter_status = [dict objectForKey:@"newsletter_status"];
             self->appDel.occupation = [dict objectForKey:@"occupation"];
             self->appDel.picture_url = [dict objectForKey:@"picture_url"];
             self->appDel.referal_code = [dict objectForKey:@"referal_code"];
             self->appDel.state_id = [dict objectForKey:@"state_id"];
             self->appDel.state_name = [dict objectForKey:@"state_name"];
             NSString *userName = [dict objectForKey:@"user_name"];
             
             self->appDel.user_role = [dict objectForKey:@"user_role"];
             self->appDel.user_role_name = [dict objectForKey:@"user_role_name"];
             self->appDel.zip = [dict objectForKey:@"zip"];
             self->appDel.user_type = @"1";
             self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
             NSLog(@"%@",self->appDel.picture_url);
//             if (![self->appDel.picture_url isEqualToString:@""])
//             {
                 NSString *log_Type = @"FB";
                 [[NSUserDefaults standardUserDefaults]setObject:log_Type forKey:@"login_type"];
                 self->appDel.login_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_type"];
                 self->fbprofilePic= [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",self->fbID];
                 [[NSUserDefaults standardUserDefaults]setObject:self->fbprofilePic forKey:@"picture_Url"];
//             }
//             else
//             {
//                 NSString *log_Type = @"";
//                 [[NSUserDefaults standardUserDefaults]setObject:log_Type forKey:@"login_type"];
//                 self->appDel.login_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_type"];
//                 [[NSUserDefaults standardUserDefaults]setObject:self->appDel.picture_url forKey:@"picture_Url"];
//             }
             [[NSUserDefaults standardUserDefaults]setObject:mobile_no forKey:@"statemobile_no"];
             [[NSUserDefaults standardUserDefaults]setObject:emailId forKey:@"statemail_id"];
             [[NSUserDefaults standardUserDefaults]setObject:user_id forKey:@"stat_user_id"];
             [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"stat_user_type"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.full_name forKey:@"statFull_Name"];
             [[NSUserDefaults standardUserDefaults]setObject:userName forKey:@"statUser_Name"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.birth_date forKey:@"dobTextFiled"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.occupation forKey:@"occupation"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.gender forKey:@"gender"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.address_line_1 forKey:@"addressLine"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.address_line_2 forKey:@"addressLineTwo"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.address_line_3 forKey:@"addressLineThree"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.country_name forKey:@"country"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.state_name forKey:@"state"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.city_name forKey:@"city"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.zip forKey:@"pincode"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.country_id forKey:@"country_id"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.state_id forKey:@"state_id"];
             [[NSUserDefaults standardUserDefaults]setObject:self->appDel.city_id forKey:@"city_id"];
             [[NSUserDefaults standardUserDefaults]setObject:@"signIn" forKey:@"status"];
             [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"from_sideMenu"];
             [self performSegueWithIdentifier:@"facebook_CityPage" sender:self];
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
- (IBAction)viewOneCheckBoxBtn:(id)sender
{
    if ([self.signInUserName.text isEqualToString:@""])
    {
        [_signInUserName showErrorWithText:@"username cannot be empty"];
    }
    else if ([self.signInPassword.text isEqualToString:@""])
    {
        [_signInPassword showErrorWithText:@"username cannot be empty"];
    }
    else
    {
        if ([checkBoxFlage isEqualToString:@"0"])
        {
            [_checkBoxBtn setSelected:YES];
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"remember_me"];
            checkBoxFlage =@"1";
        }
        else
        {
            [_checkBoxBtn setSelected:NO];
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"remember_me"];
            checkBoxFlage =@"0";
        }
    }
}
- (IBAction)viewTwoSignUpBtn:(id)sender
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    appDel.mobileNumber = self.SignUpMobileNo.text;
    
    NSString *password = self.signUpPassword.text;
    
    if (![_SignUpUserName.text isEqualToString:@""])
    {
        if ([emailTest evaluateWithObject:self.SignUpUserName.text] == NO)
        {
            [_SignUpUserName showErrorWithText:@"Enter valid email address"];
        }
        else if ([self.SignUpMobileNo.text isEqualToString:@""])
        {
            [_SignUpMobileNo showErrorWithText:@"mobilenumber cannot be empty"];
        }
        else if (appDel.mobileNumber.length != 10)
        {
            [_SignUpMobileNo showErrorWithText:@"enter valid mobile number."];
        }
        else if ([self.signUpPassword.text isEqualToString:@""])
        {
            [_signUpPassword showErrorWithText:@"password cannot be empty"];
        }
        else if (password.length < 6)
        {
            [_signUpPassword showErrorWithText:@"password should contain atleast 6 characters"];
        }
        else
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSString *deviceToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken_Key"];
            [[NSUserDefaults standardUserDefaults]setObject:appDel.mobileNumber forKey:@"statemobile_no"];
            [[NSUserDefaults standardUserDefaults]setObject:self.SignUpUserName.text forKey:@"statemail_id"];
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:self.SignUpUserName.text forKey:@"email_id"];
            [parameters setObject:appDel.mobileNumber forKey:@"mobile_no"];
            [parameters setObject:password forKey:@"password"];
            [parameters setObject:deviceToken forKey:@"gcm_key"];
            [parameters setObject:@"2" forKey:@"mobile_type"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            NSString *signUp = @"apimain/signup";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,signUp, nil];
            NSString *api = [NSString pathWithComponents:components];
            
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
                 NSLog(@"%@",responseObject);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSString *status = [responseObject objectForKey:@"status"];
                 
                 if ([msg isEqualToString:@"Signup Successfully"] && [status isEqualToString:@"Success"])
                 {
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"statFull_Name"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"statUser_Name"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"dob"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"occupation"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"gender"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"addressLine"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"addressLineTwo"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"addressLineThree"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"country"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"state"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"city"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"pincode"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"country_id"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"state_id"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"city_id"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"new_Letter"];
                     NSString *log_Type = @"";
                     [[NSUserDefaults standardUserDefaults]setObject:log_Type forKey:@"login_type"];
                     self->appDel.login_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_type"];
                     self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                     self->appDel.user_type = @"1";
                     [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"stat_user_type"];
                     [[NSUserDefaults standardUserDefaults]setObject:@"signIn" forKey:@"status"];
                     OTPViewController *oTPViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OTPViewController"];
                     [self presentViewController:oTPViewController animated:NO completion:nil];
                     UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:oTPViewController];
                     [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"for_Alert"];
                     [self.navigationController pushViewController:navigationController animated:YES];
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
    else if ([self.SignUpMobileNo.text isEqualToString:@""])
    {
        [_SignUpMobileNo showErrorWithText:@"mobilenumber cannot be empty"];
    }
    else if (appDel.mobileNumber.length != 10)
    {
        [_SignUpMobileNo showErrorWithText:@"enter valid mobile number."];
    }
    else if ([self.signUpPassword.text isEqualToString:@""])
    {
        [_signUpPassword showErrorWithText:@"password cannot be empty"];
    }
    else if (password.length < 6)
    {
        [_signUpPassword showErrorWithText:@"password should contain atleast 6 characters"];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *deviceToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken_Key"];
        [[NSUserDefaults standardUserDefaults]setObject:appDel.mobileNumber forKey:@"statemobile_no"];
        [[NSUserDefaults standardUserDefaults]setObject:self.SignUpUserName.text forKey:@"statemail_id"];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:self.SignUpUserName.text forKey:@"email_id"];
        [parameters setObject:appDel.mobileNumber forKey:@"mobile_no"];
        [parameters setObject:password forKey:@"password"];
        [parameters setObject:deviceToken forKey:@"gcm_key"];
        [parameters setObject:@"2" forKey:@"mobile_type"];

        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString *signUp = @"apimain/signup";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,signUp, nil];
        NSString *api = [NSString pathWithComponents:components];

        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];

             if ([msg isEqualToString:@"Signup Successfully"] && [status isEqualToString:@"Success"])
             {
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"statFull_Name"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"statUser_Name"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"dob"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"occupation"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"gender"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"addressLine"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"addressLineTwo"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"addressLineThree"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"country"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"state"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"city"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"pincode"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"country_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"state_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"city_id"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"new_Letter"];
                 NSString *log_Type = @"";
                 [[NSUserDefaults standardUserDefaults]setObject:log_Type forKey:@"login_type"];
                 self->appDel.login_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_type"];
                 self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                 self->appDel.user_type = @"1";
                 [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"stat_user_type"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"signIn" forKey:@"status"];
                 OTPViewController *oTPViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OTPViewController"];
                 [self presentViewController:oTPViewController animated:NO completion:nil];
                 UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:oTPViewController];
                 [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"for_Alert"];
                 [self.navigationController pushViewController:navigationController animated:YES];
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
- (IBAction)passwordEyeBtn:(id)sender
{
    if ([signUpPasswordEyeFlag isEqualToString:@"0"])
    {
        self.signEyeImageView.image = [UIImage imageNamed:@"unhide"];
        signUpPasswordEyeFlag = @"1";
        self.signUpPassword.secureTextEntry = NO;
    }
    else
    {
        self.signEyeImageView.image = [UIImage imageNamed:@"hide"];
        signUpPasswordEyeFlag = @"0";
        self.signUpPassword.secureTextEntry =  YES;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.signInUserName)
    {
        [_signInPassword becomeFirstResponder];
    }
    else if (theTextField == self.signInPassword)
    {
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.SignUpUserName)
    {
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.SignUpMobileNo)
    {
        [_SignUpMobileNo becomeFirstResponder];
    }
    else if (theTextField == self.signUpPassword)
    {
        [_SignUpUserName becomeFirstResponder];
    }
    return YES;
}
- (IBAction)signInPaswrdEyeBtn:(id)sender
{
    if ([signInPasswordEyeFlag isEqualToString:@"0"])
    {
        self.signInImageView.image = [UIImage imageNamed:@"hide.png"];
        signInPasswordEyeFlag = @"1";
        self.signInPassword.secureTextEntry = YES;
    }
    else
    {
        self.signInImageView.image = [UIImage imageNamed:@"unhide"];
        signInPasswordEyeFlag = @"0";
        self.signInPassword.secureTextEntry = NO;
    }
}
- (IBAction)googleBtn:(id)sender
{
    
}
- (IBAction)loginBtn:(id)sender
{
    NSString *password =self.signInPassword.text;
    [[NSUserDefaults standardUserDefaults]setObject:self.signInUserName.text forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];

    if ([self.signInUserName.text isEqualToString:@""])
    {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"username cannot be empty"
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
    else if ([self.signInPassword.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"password cannot be empty"
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
            NSString *deviceToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken_Key"];
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:self.signInUserName.text forKey:@"username"];
            [parameters setObject:self.signInPassword.text forKey:@"password"];
            [parameters setObject:@"sdjhksjdhkjsdhksdjfhkdj" forKey:@"gcm_key"];
            [parameters setObject:@"2" forKey:@"mobile_type"];
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            NSString *signIn = @"apimain/login";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,signIn, nil];
            NSString *api = [NSString pathWithComponents:components];
        
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                 {
                     NSLog(@"%@",responseObject);
                     self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     NSString *msg = [responseObject objectForKey:@"msg"];
                     NSString *status = [responseObject objectForKey:@"status"];
        
                     if ([msg isEqualToString:@"Login Successfully"] && [status isEqualToString:@"Success"])
                     {
                         NSDictionary *dict = [responseObject objectForKey:@"userData"];
                         NSString *user_id = [dict objectForKey:@"user_id"];
                         self->appDel.user_Id = [dict objectForKey:@"user_id"];
                         self->appDel.address_line_1 = [dict objectForKey:@"address_line_1"];
                         self->appDel.address_line_2 = [dict objectForKey:@"address_line_2"];
                         self->appDel.address_line_3 = [dict objectForKey:@"address_line_3"];
                         self->appDel.birth_date = [dict objectForKey:@"birth_date"];
                         self->appDel.city_id = [dict objectForKey:@"city_id"];
                         self->appDel.city_name = [dict objectForKey:@"city_name"];
                         self->appDel.country_id = [dict objectForKey:@"country_id"];
                         self->appDel.country_name = [dict objectForKey:@"country_name"];
                         self->appDel.email_verify_status = [dict objectForKey:@"email_verify_status"];
                         NSString *full_Name = [dict objectForKey:@"full_name"];
                         [[NSUserDefaults standardUserDefaults]setObject:full_Name forKey:@"statFull_Name"];
                         self->appDel.full_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"statFull_Name"];
                         self->appDel.gender = [dict objectForKey:@"gender"];
                         self->appDel.newsletter_status = [dict objectForKey:@"newsletter_status"];
                         self->appDel.occupation = [dict objectForKey:@"occupation"];
                         self->appDel.picture_url = [dict objectForKey:@"picture_url"];
                         NSString *picture = [dict objectForKey:@"picture_url"];
                         self->appDel.referal_code = [dict objectForKey:@"referal_code"];
                         self->appDel.state_id = [dict objectForKey:@"state_id"];
                         self->appDel.state_name = [dict objectForKey:@"state_name"];
                         self->appDel.user_role = [dict objectForKey:@"user_role"];
                         self->appDel.user_role_name = [dict objectForKey:@"user_role_name"];
                         self->appDel.zip = [dict objectForKey:@"zip"];
                         NSString *emailId = [dict objectForKey:@"email_id"];
                         self->appDel.email_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"statemail_id"];
                         NSString *mobile_no = [dict objectForKey:@"mobile_no"];
                         self->appDel.mobile_no = [[NSUserDefaults standardUserDefaults]objectForKey:@"statemobile_no"];
                         NSString *userName = [dict objectForKey:@"user_name"];
                         [[NSUserDefaults standardUserDefaults]setObject:userName forKey:@"statUser_Name"];
                         self->appDel.user_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"statUser_Name"];
                         NSString *log_Type = @"";
                         [[NSUserDefaults standardUserDefaults]setObject:log_Type forKey:@"login_type"];
                         self->appDel.login_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"login_type"];
                         self->appDel.user_type = @"1";
                         NSLog(@"%@",self->appDel.user_Id);
                         [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"stat_user_type"];
                         [[NSUserDefaults standardUserDefaults]setObject:emailId forKey:@"statemail_id"];
                         [[NSUserDefaults standardUserDefaults]setObject:@"signIn" forKey:@"status"];
                         [[NSUserDefaults standardUserDefaults]setObject:picture forKey:@"picture_Url"];
                         [[NSUserDefaults standardUserDefaults]setObject:user_id forKey:@"stat_user_id"];
                         [[NSUserDefaults standardUserDefaults]setObject:mobile_no forKey:@"statemobile_no"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.full_name forKey:@"statFull_Name"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.birth_date forKey:@"dob"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.occupation forKey:@"occupation"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.gender forKey:@"gender"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.address_line_1 forKey:@"addressLine"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.address_line_2 forKey:@"addressLineTwo"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.address_line_3 forKey:@"addressLineThree"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.country_name forKey:@"country"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.state_name forKey:@"state"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.city_name forKey:@"city"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.zip forKey:@"pincode"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.country_id forKey:@"country_id"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.state_id forKey:@"state_id"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.city_id forKey:@"city_id"];
                         [[NSUserDefaults standardUserDefaults]setObject:self->appDel.newsletter_status forKey:@"new_Letter"];
                         [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"for_Alert"];
                         [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"from_sideMenu"];
                         [self performSegueWithIdentifier:@"to_countryPage" sender:self];
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
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
- (IBAction)guestBtn:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"picture_Url"];
    NSString *Identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"output is : %@", Identifier);
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken_Key"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:Identifier forKey:@"unique_id"];
    [parameters setObject:deviceToken forKey:@"gcm_key"];
    [parameters setObject:@"2" forKey:@"mobile_type"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *guestlogin = @"apimain/guestLogin";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,guestlogin, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         self->appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"Guest Login Successfully"] && [status isEqualToString:@"Success"])
         {
             NSDictionary *dict = [responseObject objectForKey:@"userData"];
             NSString *user_id = [dict objectForKey:@"user_id"];
             [[NSUserDefaults standardUserDefaults]setObject:user_id forKey:@"stat_user_id"];
             self->appDel.user_Id = user_id;
             self->appDel.user_type = @"2";
             [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"stat_user_type"];
             [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"for_Alert"];
             [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"from_sideMenu"];
             [self performSegueWithIdentifier:@"to_countryPage" sender:self];
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.signUpPassword)
    {
        if (textField.text.length >= 12 && range.length == 0)
        {
            return NO;
        }
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == self.signInUserName)
    {
        if ([self.self.signInUserName.text isEqualToString:@""])
        {
            [[NSUserDefaults standardUserDefaults]setObject:self.signInUserName.text forKey:@"userName"];
            [_checkBoxBtn setSelected:NO];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults]setObject:self.signInUserName.text forKey:@"userName"];
        }
    }
    else if (textField == self.signInPassword)
    {
        if ([self.self.signInUserName.text isEqualToString:@""])
        {
            NSString *password =self.signInPassword.text;
            [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
            [_checkBoxBtn setSelected:NO];
        }
        else
        {
            NSString *password =self.signInPassword.text;
            [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
        }
    }
    return YES;
}
-(void)dismissKeyboard
{
    [_SignUpUserName resignFirstResponder];
    [_SignUpMobileNo resignFirstResponder];
    [_signUpPassword resignFirstResponder];
    [_signInUserName resignFirstResponder];
    [_signInPassword resignFirstResponder];
}
@end
