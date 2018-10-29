//
//  ProfileViewController.m
//  Heylaapp
//
//  Created by HappySanz on 06/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "ProfileViewController.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsFilter.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <Photos/Photos.h>
#import <QuartzCore/QuartzCore.h>

@interface ProfileViewController ()
{
    AppDelegate *appDel;
    NSString *selectedImage;
    UIDatePicker *datePicker;
    UIToolbar *toolBar;
    UIToolbar *listToolBar;
    NSString *maleButtonFlag;
    NSString *femaleButtonFlag;
    NSString *newsLetterFlag;
    UIPickerView *listpickerView;
    NSArray *occupationList;
    NSArray *genderArray;
    NSMutableArray *country_Name;
    NSMutableArray *country_id;
    NSMutableArray *state_Name;
    NSMutableArray *state_id;
    NSMutableArray *city_Name;
    NSMutableArray *city_id;
    NSString *strCountry;
    NSString *strState;
    NSString *strCity;
    NSString *strOccupation;
    NSString *strGender;
    NSString *newLetterResult;
    NSString *imageName;
    NSString *strcountry_id;
    NSString *strstate_id;
    NSString *strcity_id;
    NSString *strnews_letter;
    NSData *image;
}
@property (nonatomic, strong) UIImage *chosenImage;
@property (nonatomic, strong) UIImage *cropImage;
@end
@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    _fullName.delegate = self;
    _userName.delegate = self;
    _addressLine.delegate = self;
    _addressLineTwo.delegate = self;
    _addressLineThree.delegate = self;
    _pincode.delegate = self;
    
    _dobTextFiled.delegate = self;
    _genderTexfiled.delegate = self;
    _occupation.delegate = self;
    _country.delegate = self;
    _state.delegate = self;
    _city.delegate = self;
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"from_otp"];
    if ([str isEqualToString:@"YES"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"from_otp"];
        self.navigationItem.hidesBackButton = YES;
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"from_otp"];
        self.navigationItem.hidesBackButton = NO;
        
    }
    
//    self.profImageView.hidden = YES;
//    self.imageBtnOtlet.enabled = NO;
    self.profImageView.clipsToBounds = YES;
    NSLog(@"%@",appDel.login_type);
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([appDel.login_type isEqualToString:@"FB"])
    {
        NSURL *url = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"picture_Url"]];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        self.profImageView.image = image;
        self.profImageView.layer.cornerRadius = self.profImageView.frame.size.width / 2;
        self.profImageView.clipsToBounds = YES;
        self.profImageView.layer.borderWidth = 4.0f;
        self.profImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        [self scaleAndRotateImage:image];
    }
    else
    {
        __weak ProfileViewController *profile = self;
        UIImage *placeholderImage = [UIImage imageNamed:@"profile.png"];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"picture_Url"]]];
        NSLog(@"%@",appDel.picture_url);
        [self.profImageView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
         {
             profile.profImageView.image = image;
             profile.profImageView.layer.cornerRadius = self.profImageView.frame.size.width / 2;
             profile.profImageView.clipsToBounds = YES;
             profile.profImageView.layer.borderWidth = 4.0f;
             profile.profImageView.layer.borderColor = [UIColor whiteColor].CGColor;
             [profile scaleAndRotateImage:image];

             UIGraphicsEndImageContext();
         } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {

             NSLog(@"%@",error);

         }];
    }
    _save.layer.cornerRadius = 5.0;
    _save.clipsToBounds = YES;

    listpickerView = [[UIPickerView alloc] init];
    listpickerView.delegate = self;
    listpickerView.dataSource = self;
    [self.occupation setInputView:listpickerView];
    [self.genderTexfiled setInputView:listpickerView];
    [self.country setInputView:listpickerView];
    [self.state setInputView:listpickerView];
    [self.city setInputView:listpickerView];

    country_Name = [[NSMutableArray alloc]init];
    country_id = [[NSMutableArray alloc]init];
    state_Name = [[NSMutableArray alloc]init];
    state_id = [[NSMutableArray alloc]init];
    city_Name = [[NSMutableArray alloc]init];
    city_id = [[NSMutableArray alloc]init];

    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.maximumDate=[NSDate date];
    toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *cancelBtn=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(ShowsCancelButton)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:cancelBtn,space,doneBtn, nil]];
    [self.dobTextFiled setInputView:datePicker];
    [self.dobTextFiled setInputAccessoryView:toolBar];
    
    listToolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [listToolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SelectedDate)];
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButton)];
    UIBarButtonItem *spacePicker=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [listToolBar setItems:[NSArray arrayWithObjects:cancel,spacePicker,done, nil]];
    
    [self.occupation setInputAccessoryView:listToolBar];
    [self.genderTexfiled setInputAccessoryView:listToolBar];
    [self.country setInputAccessoryView:listToolBar];
    [self.state setInputAccessoryView:listToolBar];
    [self.city setInputAccessoryView:listToolBar];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    maleButtonFlag = @"0";
    femaleButtonFlag = @"0";
    newsLetterFlag = @"0";
    
    occupationList = @[@"Select Your Occupation",@"Student",@"Employed",@"Self Employed",@"Business",@"Home Maker",@"Other"];
    
    genderArray = @[@"Select Your Gender",@"Male",@"Female",@"Other",@"Rather not Talk about it"];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.userName.text = appDel.user_name;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *selectCountry = @"apimain/selectCountry";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,selectCountry, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
    
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
    
             if ([msg isEqualToString:@"View Countries"] && [status isEqualToString:@"success"])
             {
                 NSArray *responseObj = [responseObject objectForKey:@"Countries"];
                 [self->country_Name removeAllObjects];
                 [self->country_id removeAllObjects];
                 for (int i = 0; i < [responseObj count]; i++)
                 {
                     NSDictionary *dict = [responseObj objectAtIndex:i];
                     NSString *str_CountryName = [dict objectForKey:@"country_name"];
                     NSString *str_id = [dict objectForKey:@"id"];
                     
                     [self->country_Name addObject:str_CountryName];
                     [self->country_id addObject:str_id];

                 }
                 
                 [MBProgressHUD hideHUDForView:self.view animated:YES];

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
        
    self.fullName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"statFull_Name"];
    self.userName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"statUser_Name"];
    NSString *dob = [[NSUserDefaults standardUserDefaults]objectForKey:@"dob"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //// here set format of date which is in your output date (means above str with format)
    NSDate *date = [dateFormatter dateFromString:dob]; // here you can fetch date from string with define format
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];// here set format which you want...
    NSString *convertedString = [dateFormatter stringFromDate:date];
    self.dobTextFiled.text = convertedString;
    self.occupation.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"occupation"];
    self.genderTexfiled.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"gender"];
    self.addressLine.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"addressLine"];
    self.addressLineTwo.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"addressLineTwo"];
    self.addressLineThree.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"addressLineThree"];
    self.country.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"country"];
    self.state.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"state"];
    self.city.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"city"];
    self.pincode.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"pincode"];
    strcountry_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"country_id"];
    strstate_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"state_id"];
    strcity_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"city_id"];
    strnews_letter = [[NSUserDefaults standardUserDefaults]objectForKey:@"new_Letter"];
    
    if (!strcountry_id.length)
    {
        strcountry_id = @"";
    }
    if (!strstate_id.length)
    {
        strstate_id = @"";
    }
    if (!strcity_id.length)
    {
        strcity_id = @"";
    }
    if (!strnews_letter.length)
    {
        strnews_letter = @"";
    }
    if ([strnews_letter isEqualToString:@"N"])
    {
        [_newsLetter setSelected:NO];
        newsLetterFlag = @"0";
        [[NSUserDefaults standardUserDefaults]setObject:@"N" forKey:@"new_Letter"];
    }
    else
    {
        [_newsLetter setSelected:YES];
        newsLetterFlag = @"1";
        [[NSUserDefaults standardUserDefaults]setObject:@"Y" forKey:@"new_Letter"];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
    action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
#pragma mark - UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == listpickerView)
    {
        return 1;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.occupation isFirstResponder])
        {
        return [occupationList count];
        }
        else if([self.genderTexfiled isFirstResponder])
        {
            return [genderArray count];
        }
        else if([self.country isFirstResponder])
        {
        return [country_Name count];
        }
        else if([self.state isFirstResponder])
        {
            return [state_Name count];
        }
        else if([self.city isFirstResponder])
        {
            return [city_Name count];
        }
    }
    return 0;

}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.occupation isFirstResponder])
        {
            return occupationList[row];
        }
        else if([self.genderTexfiled isFirstResponder])
        {
            return genderArray[row];
        }
        else if([self.country isFirstResponder])
        {
            return country_Name[row];
        }
        else if([self.state isFirstResponder])
        {
            return state_Name[row];
        }
        else if([self.city isFirstResponder])
        {
            return city_Name[row];
        }
    }
        return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.occupation isFirstResponder])
        {
            strOccupation = occupationList[row];
        }
        else if([self.genderTexfiled isFirstResponder])
        {
            strGender = genderArray[row];
        }
        else if([self.country isFirstResponder])
        {
            strCountry = country_Name[row];
        }
        else if([self.state isFirstResponder])
        {
            strState = state_Name[row];
        }
        else if([self.city isFirstResponder])
        {
            strCity = city_Name[row];
        }
    }
}
- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];

    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.bottom = keyboardRect.size.height;
    self.scrollView.contentInset = contentInset;
}
- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
}
-(void)viewDidLayoutSubviews
{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width,900);
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
-(void)ShowSelectedDate
{
    if([self.dobTextFiled isFirstResponder])
    {
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    self.dobTextFiled.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.dobTextFiled resignFirstResponder];
        
    }
}
-(void)ShowsCancelButton
{
    if([self.dobTextFiled isFirstResponder])
    {
    [datePicker removeFromSuperview];
    [self.dobTextFiled resignFirstResponder];
    [toolBar removeFromSuperview];
        
    }
}
-(void)CancelButton
{
    if ([self.occupation isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.occupation resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
    else if([self.genderTexfiled isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.genderTexfiled resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
    else if([self.country isFirstResponder])
    {
       
        [listpickerView removeFromSuperview];
        [self.country resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
    else if([self.country isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.country resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
    else if([self.state isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.state resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
    else if([self.city isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.city resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
}
-(void)SelectedDate
{
    if ([self.occupation isFirstResponder])
    {
        self.occupation.text = strOccupation;
        [self.occupation resignFirstResponder];
    }
    else if ([self.genderTexfiled isFirstResponder])
    {
        self.genderTexfiled.text = strGender;
        [self.genderTexfiled resignFirstResponder];
    }
    else if ([self.country isFirstResponder])
    {
        self.country.text = strCountry;
        self.city.text = @"";
        self.state.text = @"";
        NSUInteger index = [country_Name indexOfObject:self.country.text];
        strcountry_id = country_id[index];
        [[NSUserDefaults standardUserDefaults]setObject:strcountry_id forKey:@"state_id"];
        [self.country resignFirstResponder];
    }
    else if ([self.state isFirstResponder])
    {
        self.city.text = @"";
        self.state.text = strState;
        if ([self.state.text isEqualToString:@"Select Your State"])
        {
            self.state.text = strState;
            [self.state resignFirstResponder];
        }
        else
        {
            [state_Name removeObjectAtIndex:0];
            NSUInteger index = [state_Name indexOfObject:self.state.text];
            strstate_id = state_id[index];
            [[NSUserDefaults standardUserDefaults]setObject:strstate_id forKey:@"state_id"];
            self.state.text = strState;
            [self.state resignFirstResponder];
        }
    }
    else if ([self.city isFirstResponder])
    {
        self.city.text = strCity;
        if ([strCity isEqualToString:@"Select Your City"])
        {
            self.city.text = strCity;
            [self.city resignFirstResponder];
        }
        else
        {
            [city_Name removeObjectAtIndex:0];
            self.city.text = strCity;
            NSUInteger index = [city_Name indexOfObject:self.city.text];
            strcity_id = city_id[index];
            [[NSUserDefaults standardUserDefaults]setObject:strcity_id forKey:@"city_id"];
            [self.city resignFirstResponder];
        }
    }
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)imageBTn:(id)sender
{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Take photo"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                  
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                  imagePickerController.delegate = self;
                                  alert.popoverPresentationController.sourceView = self.imageBtnOtlet;
                                  [self presentViewController:imagePickerController animated:YES completion:^{}];
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Choose From Gallery"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                  
                                  UIImagePickerController *imagePickerController= [[UIImagePickerController alloc] init];
                                  imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                  imagePickerController.delegate = self;
                                  alert.popoverPresentationController.sourceView = self.imageBtnOtlet;
                                  [self presentViewController:imagePickerController animated:YES completion:^{}];
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  
                              }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    alert.popoverPresentationController.sourceView = self.imageBtnOtlet;
    [self presentViewController:alert animated:YES completion:nil];
}
-(UIImage *)scaleAndRotateImage:(UIImage *)image
{
    // No-op if the orientation is already correct
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _chosenImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self changeImage];

}
-(void)changeImage
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = self->_chosenImage;
    UIImage *image = self.chosenImage;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 4,
                                          (height - length) / 4,
                                          length,
                                          length);
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
        [self presentViewController:navigationController animated:YES completion:NULL];
}
- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    self.profImageView.image = croppedImage;
    _cropImage = croppedImage;
    image = UIImageJPEGRepresentation(_cropImage, 0.1);
    [self scaleAndRotateImage:croppedImage];
    self.profImageView.layer.cornerRadius = self.profImageView.frame.size.width / 2;
    self.profImageView.clipsToBounds = YES;
    self.profImageView.layer.borderWidth = 4.0f;
    self.profImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self profile_Pic];
}
- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
    }
    [controller dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)newsLetterBtn:(id)sender
{
    if ([newsLetterFlag isEqualToString:@"0"])
    {
        [_newsLetter setSelected:YES];
        newsLetterFlag = @"1";
        [[NSUserDefaults standardUserDefaults]setObject:@"Y" forKey:@"new_Letter"];
    }
    else
    {
        [_newsLetter setSelected:NO];
        newsLetterFlag = @"0";
        [[NSUserDefaults standardUserDefaults]setObject:@"N" forKey:@"new_Letter"];
    }
}
- (IBAction)saveBtn:(id)sender
{

    if ([self.fullName.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Fullname cannot be empty"
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
    else if([self.userName.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Username cannot be empty"
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
    else if([self.city.text isEqualToString:@"Select Your City"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please select your city"
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
    else if([self.state.text isEqualToString:@"Select Your state"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Please select your state"
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
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [[NSUserDefaults standardUserDefaults]setObject:self.fullName.text forKey:@"statFull_Name"];
        [[NSUserDefaults standardUserDefaults]setObject:self.userName.text forKey:@"statUser_Name"];
        [[NSUserDefaults standardUserDefaults]setObject:self.dobTextFiled.text forKey:@"dob"];
        [[NSUserDefaults standardUserDefaults]setObject:self.occupation.text forKey:@"occupation"];
        [[NSUserDefaults standardUserDefaults]setObject:self.genderTexfiled.text forKey:@"gender"];
        [[NSUserDefaults standardUserDefaults]setObject:self.addressLine.text forKey:@"addressLine"];
        [[NSUserDefaults standardUserDefaults]setObject:self.addressLineTwo.text forKey:@"addressLineTwo"];
        [[NSUserDefaults standardUserDefaults]setObject:self.addressLineThree.text forKey:@"addressLineThree"];
        [[NSUserDefaults standardUserDefaults]setObject:self.country.text forKey:@"country"];
        [[NSUserDefaults standardUserDefaults]setObject:self.state.text forKey:@"state"];
        [[NSUserDefaults standardUserDefaults]setObject:self.city.text forKey:@"city"];
        [[NSUserDefaults standardUserDefaults]setObject:self.pincode.text forKey:@"pincode"];
        [[NSUserDefaults standardUserDefaults]setObject:strcountry_id forKey:@"country_id"];
        [[NSUserDefaults standardUserDefaults]setObject:strstate_id forKey:@"state_id"];
        [[NSUserDefaults standardUserDefaults]setObject:strcity_id forKey:@"city_id"];
        NSString *srrNewsletter = [[NSUserDefaults standardUserDefaults]objectForKey:@"new_Letter"];
        [[NSUserDefaults standardUserDefaults]setObject:srrNewsletter forKey:@"new_Letter"];
        NSLog(@"%@",srrNewsletter);
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:appDel.user_Id forKey:@"user_id"];
        [parameters setObject:self.fullName.text forKey:@"full_name"];
        [parameters setObject:self.userName.text forKey:@"username"];
        [parameters setObject:self.dobTextFiled.text forKey:@"date_of_birth"];
        [parameters setObject:self.genderTexfiled.text forKey:@"gender"];
        [parameters setObject:self.occupation.text forKey:@"occupation"];
        [parameters setObject:self.addressLine.text forKey:@"address_line_1"];
        [parameters setObject:self.addressLineTwo.text forKey:@"address_line_2"];
        [parameters setObject:self.addressLineThree.text forKey:@"address_line_3"];
        [parameters setObject:strcountry_id forKey:@"country_id"];
        [parameters setObject:strstate_id forKey:@"state_id"];
        [parameters setObject:strcity_id forKey:@"city_id"];
        [parameters setObject:self.pincode.text forKey:@"zip_code"];
        [parameters setObject:srrNewsletter forKey:@"news_letter"];

        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

        NSString *profileUpdate = @"apimain/profileupdate";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,profileUpdate, nil];
        NSString *api = [NSString pathWithComponents:components];

        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];

             if ([msg isEqualToString:@"Profile Updated"] && [status isEqualToString:@"success"])
             {
                 NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"From_page"];
                 
                 if ([str isEqualToString:@"city"])
                 {
                     [self performSegueWithIdentifier:@"to_selectCity" sender:self];
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
-(void)profile_Pic
{
    [self scaleAndRotateImage:_cropImage];
    CGImageRef cgref = [_cropImage CGImage];
    CIImage *cim = [_cropImage CIImage];
    
    if (cim == nil && cgref == NULL)
    {
       
    }
    else
    {
//      [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *url = [NSString stringWithFormat:@"%@/%@",@"https://heylaapp.com/apimain/profilePictureUpload",appDel.user_Id];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_pic\";filename=\"%@\"\r\n",@"473.png"]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:image]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              if (error)
                                              {
                                                  NSLog(@"%@", error);
                                              }
                                              else
                                              {
                                                  NSString *text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                  NSLog(@"%@", text);
                                                  NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                  NSLog(@"%@", result);
                                                  NSString *img = result[@"picture_url"];
                                                  NSLog(@"%@%@",result,img);
                                                  self->appDel.picture_url = img;                                                  
                                                  [[NSUserDefaults standardUserDefaults]setObject:img forKey:@"picture_Url"];
                                              }
                                          }];
        [dataTask resume];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.fullName)
    {
        [_userName becomeFirstResponder];
    }
    else if (theTextField == self.userName)
    {
        self.userName.text = [theTextField text];
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.addressLine)
    {
        [_addressLineTwo becomeFirstResponder];
    }
    else if (theTextField == self.addressLineTwo )
    {
        [_addressLineThree becomeFirstResponder];
    }
    else if (theTextField == self.addressLineThree)
    {
        [theTextField resignFirstResponder];
    }
    else if (theTextField == self.pincode )
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == self.userName)
    {
        self.userName.text = [textField text];
        [textField resignFirstResponder];
    }
    return YES;
}
- (IBAction)cityBtn:(id)sender
{
    if([self.state.text isEqualToString:@""] || [self.country.text isEqualToString:@"Select Your State"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Select the state"
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
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
//      NSUInteger index = [country_Name indexOfObject:self.country.text];
//      NSString *countryId = country_id[index];
//      NSUInteger stateIndex = [state_Name indexOfObject:self.state.text];
//      NSString *stateId = state_id[stateIndex];
//      [[NSUserDefaults standardUserDefaults]setObject:stateId forKey:@"state_idStat"];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:strcountry_id forKey:@"country_id"];
        [parameters setObject:strstate_id forKey:@"state_id"];

        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString *selectCity = @"apimain/selectCity";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,selectCity, nil];
        NSString *api = [NSString pathWithComponents:components];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             
             if ([msg isEqualToString:@"View Cities"] && [status isEqualToString:@"success"])
             {
                 NSArray *responseObj = [responseObject objectForKey:@"Cities"];
                 [self->city_Name removeAllObjects];
                 [self->city_id removeAllObjects];
                 [self->city_Name insertObject:@"Select Your City" atIndex:0];
                 
                 for (int i = 0; i < [responseObj count]; i++)
                 {
                     NSDictionary *dict = [responseObj objectAtIndex:i];
                     NSString *str_cityName= [dict objectForKey:@"city_name"];
                     NSString *cityId = [dict objectForKey:@"id"];
                     
                     [self->city_Name addObject:str_cityName];
                     [self->city_id addObject:cityId];
                     [self->listpickerView selectRow:0 inComponent:0 animated:YES];

                 }
                     [self.city becomeFirstResponder];
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

- (IBAction)stateBtn:(id)sender
{
        if([self.country.text isEqualToString:@""])
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Heyla"
                                       message:@"Select the country"
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
            [listpickerView reloadAllComponents];
            appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            NSUInteger index = [country_Name indexOfObject:self.country.text];
            NSString *countryId = country_id[index];
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
            [parameters setObject:countryId forKey:@"country_id"];
            [[NSUserDefaults standardUserDefaults]setObject:countryId forKey:@"country_idStat"];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
            NSString *selectState = @"apimain/selectState";
            NSArray *components = [NSArray arrayWithObjects:baseUrl,selectState, nil];
            NSString *api = [NSString pathWithComponents:components];
    
            [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
             {
    
                 NSLog(@"%@",responseObject);
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 NSString *msg = [responseObject objectForKey:@"msg"];
                 NSString *status = [responseObject objectForKey:@"status"];
    
                 if ([msg isEqualToString:@"View States"] && [status isEqualToString:@"success"])
                 {
                     NSArray *responseObj = [responseObject objectForKey:@"States"];
                     [self->state_Name removeAllObjects];
                     [self->state_id removeAllObjects];
                     [self->state_Name insertObject:@"Select Your State" atIndex:0];

                     for (int i = 0; i < [responseObj count]; i++)
                     {
                         NSDictionary *dict = [responseObj objectAtIndex:i];
                         NSString *str_stateName = [dict objectForKey:@"state_name"];
                         NSString *str_stateid = [dict objectForKey:@"id"];
    
                         [self->state_Name addObject:str_stateName];
                         [self->state_id addObject:str_stateid];
                         [self->listpickerView selectRow:0 inComponent:0 animated:YES];
                     }
                     [self.state becomeFirstResponder];
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
-(void)dismissKeyboard
{
    [_fullName resignFirstResponder];
    [_userName resignFirstResponder];
    [_addressLine resignFirstResponder];
    [_addressLineTwo resignFirstResponder];
    [_addressLineThree resignFirstResponder];
    [_pincode resignFirstResponder];
}
- (IBAction)profImgBtn:(id)sender
{
    
}

@end
