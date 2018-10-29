//
//  SelectCityPageViewController.m
//  Heylaapp
//
//  Created by HappySanz on 13/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "SelectCityPageViewController.h"

@interface SelectCityPageViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *city_Latitude;
    NSMutableArray *city_Longitude;
    NSMutableArray *city_Name;
    NSMutableArray *city_Id;
    UIPickerView *listpickerView;
    UIToolbar *listToolBar;
    NSMutableArray *countryArray;
    NSMutableArray *countryID;
    NSString *strCountry;
    NSString *strCountry_id;
}
@end

@implementation SelectCityPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.currentCity.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"locatedCity"];
    _countryTxtFiled.layer.cornerRadius = 10.0;
    _countryTxtFiled.layer.borderWidth = 1.0;
    _countryTxtFiled.layer.borderColor = [UIColor blackColor].CGColor;
    
    city_Latitude = [[NSMutableArray alloc]init];
    city_Longitude = [[NSMutableArray alloc]init];
    city_Name = [[NSMutableArray alloc]init];
    city_Id = [[NSMutableArray alloc]init];
    countryArray = [[NSMutableArray alloc]init];
    countryID = [[NSMutableArray alloc]init];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"city" forKey:@"From_page"];
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_id"];
    self->appDel.user_Id = user_id;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *getEventCountries = @"apimain/getEventCountries";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,getEventCountries, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Countries"] && [status isEqualToString:@"success"])
         {
             NSArray *country = [responseObject objectForKey:@"Countries"];
             [self->countryArray removeAllObjects];
             
             for (int i =0; i < [country count]; i++)
             {
                 NSDictionary *dict = [country objectAtIndex:i];
                 NSString *str_country = [dict objectForKey:@"country_name"];
                 NSString *str_id = [dict objectForKey:@"id"];
                 
                 [self->countryArray addObject:str_country];
                 [self->countryID addObject:str_id];
             }
             self.countryTxtFiled.text = [self->countryArray objectAtIndex:0];
             self->strCountry_id = [self->countryID objectAtIndex:0];
             [self getEventCity];
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
    
    listpickerView = [[UIPickerView alloc] init];
    listpickerView.delegate = self;
    listpickerView.dataSource = self;
    [self.countryTxtFiled setInputView:listpickerView];
    listToolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [listToolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *done=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(SelectedCountry)];
    UIBarButtonItem *cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(CancelButton)];
    UIBarButtonItem *spacePicker=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [listToolBar setItems:[NSArray arrayWithObjects:cancel,spacePicker,done, nil]];
    [self.countryTxtFiled setInputAccessoryView:listToolBar];
    NSLog(@"%@",self.currentCity.text);
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"city_Page_alert"];
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"from_sideMenu"];
    if ([str isEqualToString:@"YES"])
    {
        _backOutlet.enabled = YES;
        _backOutlet.tintColor = [UIColor whiteColor];
    }
    else
    {
        _backOutlet.enabled = NO;
        _backOutlet.tintColor = [UIColor clearColor];
    }
      self.tableView.hidden = YES;
//    self.curentCityLabel.hidden = YES;
//    self.cityImage.hidden = YES;
//    self.heylaLogo.hidden = YES;
      self.locationTitle.hidden = YES;
//    self.curentCityImage.hidden = YES;
//    self.currentCity.hidden = YES;
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.user_Id = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_id"];

    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"cityPage"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}
-(void)getEventCity
{
        appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:strCountry_id forKey:@"country_id"];
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
        NSString *getEventcities = @"apimain/getEventcities";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,getEventcities, nil];
        NSString *api = [NSString pathWithComponents:components];
    
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
    
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];

         if ([msg isEqualToString:@"View Cities"] && [status isEqualToString:@"success"])
         {
             
         NSArray *cities = [responseObject objectForKey:@"cities"];
         [self->city_Latitude removeAllObjects];
         [self->city_Longitude removeAllObjects];
         [self->city_Name removeAllObjects];
         [self->city_Id removeAllObjects];

         for (int i =0; i < [cities count]; i++)
          {
             NSDictionary *dict = [cities objectAtIndex:i];
             NSString *strCity_latitude = [dict objectForKey:@"city_latitude"];
             NSString *strCity_longitude = [dict objectForKey:@"city_longitude"];
             NSString *strCity_name = [dict objectForKey:@"city_name"];
             NSString *strId = [dict objectForKey:@"id"];

             [self->city_Latitude addObject:strCity_latitude];
             [self->city_Longitude addObject:strCity_longitude];
             [self->city_Name addObject:strCity_name];
             [self->city_Id addObject:strId];
          }
        
         [[NSUserDefaults standardUserDefaults]setObject:self->city_Name forKey:@"cityName_Array"];
         [[NSUserDefaults standardUserDefaults]setObject:self->city_Id forKey:@"cityID_Array"];
         self.curentCityLabel.hidden = NO;
         self.cityImage.hidden = NO;
         self.heylaLogo.hidden = NO;
         self.locationTitle.hidden = NO;
         self.curentCityImage.hidden = NO;
         self.currentCity.hidden = NO;
         self.tableView.hidden = NO;
         [self.tableView reloadData];

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
        if([self.countryTxtFiled isFirstResponder])
        {
            return [countryArray count];
        }
    }
    
    return 0;
    
}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.countryTxtFiled isFirstResponder])
        {
            return countryArray[row];
        }
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == listpickerView)
    {
        if([self.countryTxtFiled isFirstResponder])
        {
            strCountry = countryArray[row];
        }
    }
}
-(void)SelectedCountry
{
    if ([self.countryTxtFiled isFirstResponder])
    {
        self.countryTxtFiled.text = strCountry;
        [self.countryTxtFiled resignFirstResponder];
        NSUInteger index = [countryArray indexOfObject:self.countryTxtFiled.text];
        strCountry_id = countryID[index];
        [self getEventCity];
    }
}
-(void)CancelButton
{
    if ([self.countryTxtFiled isFirstResponder])
    {
        [listpickerView removeFromSuperview];
        [self.countryTxtFiled resignFirstResponder];
        [listToolBar removeFromSuperview];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [city_Latitude count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCityTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.cityLabel.text = [city_Name objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//  SelectCityTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    appDel.selected_City = [city_Name objectAtIndex:indexPath.row];
    NSLog(@"%@",appDel.selected_City);
    [[NSUserDefaults standardUserDefaults]setObject:appDel.selected_City forKey:@"selected_city_prof"];
    NSUInteger city_Longitude_Index = [city_Name indexOfObject:appDel.selected_City];
    appDel.selected_City_Latittude = city_Latitude[city_Longitude_Index];
    
    NSUInteger city_Latitude_Index = [city_Name indexOfObject:appDel.selected_City];
    appDel.selected_City_Longitude = city_Longitude[city_Latitude_Index];
    
    NSUInteger city_Id_Index = [city_Name indexOfObject:appDel.selected_City];
    appDel.selected_City_Id = city_Id[city_Id_Index];
    NSLog(@"%@",appDel.selected_City_Id);
    [[NSUserDefaults standardUserDefaults]setObject:appDel.selected_City_Id forKey:@"stat_city_id"];
    [self performSegueWithIdentifier:@"to_categoeryView" sender:self];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 81;
    }
    else
    {
       return 45;
    }
}
- (IBAction)backBtn:(id)sender
{
//    [self.navigationController popViewControllerAnimated:YES];
      [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
