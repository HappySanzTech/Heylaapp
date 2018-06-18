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
}
@end

@implementation SelectCityPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.currentCity.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"locatedCity"];
    NSLog(@"%@",self.currentCity.text);
    city_Latitude = [[NSMutableArray alloc]init];
    city_Longitude = [[NSMutableArray alloc]init];
    city_Name = [[NSMutableArray alloc]init];
    city_Id = [[NSMutableArray alloc]init];
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
    self.curentCityLabel.hidden = YES;
    self.cityImage.hidden = YES;
    self.heylaLogo.hidden = YES;
    self.locationTitle.hidden = YES;
    self.curentCityImage.hidden = YES;
    self.currentCity.hidden = YES;
    appDel.user_Id = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_id"];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *selectAllCity = @"apimain/selectallcity";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,selectAllCity, nil];
    NSString *api = [NSString pathWithComponents:components];

    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Cities"] && [status isEqualToString:@"success"])
         {
             NSArray *cities = [responseObject objectForKey:@"Cities"];
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

    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"cityPage"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
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
    
//    SelectCityTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    appDel.selected_City = [city_Name objectAtIndex:indexPath.row];
    NSLog(@"%@",appDel.selected_City);
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
