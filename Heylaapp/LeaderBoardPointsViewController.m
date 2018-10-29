//
//  LeaderBoardPointsViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 20/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "LeaderBoardPointsViewController.h"

@interface LeaderBoardPointsViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *event_name;
    NSMutableArray *event_venue;

}
@end

@implementation LeaderBoardPointsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    event_name = [[NSMutableArray alloc]init];
    event_venue = [[NSMutableArray alloc]init];
    NSString *check = [[NSUserDefaults standardUserDefaults]objectForKey:@"LeaderBoardType"];
    self.navigationItem.title = check;
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if ([check isEqualToString:@"Share"])
    {
        [parameters setObject:appDel.user_Id forKey:@"user_id"];
        [parameters setObject:@"2" forKey:@"rule_id"];
        self.sideView.backgroundColor = [UIColor colorWithRed:68/255.0 green:77/255.0 blue:161/255.0 alpha:1.0];
    }
    else if ([check isEqualToString:@"CheckIn"])
    {
        [parameters setObject:appDel.user_Id forKey:@"user_id"];
        [parameters setObject:@"3" forKey:@"rule_id"];
        self.sideView.backgroundColor = [UIColor colorWithRed:237/255.0 green:28/255.0 blue:36/255.0 alpha:1.0];
    }
    else if ([check isEqualToString:@"Review"])
    {
        [parameters setObject:appDel.user_Id forKey:@"user_id"];
        [parameters setObject:@"4" forKey:@"rule_id"];
        self.sideView.backgroundColor = [UIColor colorWithRed:02/255.0 green:155/255.0 blue:140/255.0 alpha:1.0];
    }
    else if ([check isEqualToString:@"Booking"])
    {
        [parameters setObject:appDel.user_Id forKey:@"user_id"];
        [parameters setObject:@"5" forKey:@"rule_id"];
        self.sideView.backgroundColor = [UIColor colorWithRed:238/255.0 green:127/255.0 blue:34/255.0 alpha:1.0];
    }
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *userActivity = @"apimain/activityHistory";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,userActivity, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"Checking History"] && [status isEqualToString:@"success"])
         {
             NSArray *data  = [responseObject objectForKey:@"Data"];
             for (int i = 0; i < [data count];i++)
             {
                 NSDictionary *dict = [data objectAtIndex:i];
                 NSString *strevent_name =  [dict objectForKey:@"event_name"];
                 NSString *strevent_venue =  [dict objectForKey:@"event_venue"];
                 [self->event_name addObject:strevent_name];
                 [self->event_venue addObject:strevent_venue];

             }
                 [self.tableView reloadData];
         }
         else if ([msg isEqualToString:@"Sharing History"] && [status isEqualToString:@"success"])
         {
             NSArray *data  = [responseObject objectForKey:@"Data"];
             for (int i = 0; i < [data count];i++)
             {
                 NSDictionary *dict = [data objectAtIndex:i];
                 NSString *strevent_name =  [dict objectForKey:@"event_name"];
                 NSString *strevent_venue =  [dict objectForKey:@"event_venue"];
                 [self->event_name addObject:strevent_name];
                 [self->event_venue addObject:strevent_venue];
             }
                 [self.tableView reloadData];
         }
         else if ([msg isEqualToString:@"Booking History"] && [status isEqualToString:@"success"])
         {
             NSArray *data  = [responseObject objectForKey:@"Data"];
             for (int i = 0; i < [data count];i++)
             {
                 NSDictionary *dict = [data objectAtIndex:i];
                 NSString *strevent_name =  [dict objectForKey:@"event_name"];
                 NSString *strevent_venue =  [dict objectForKey:@"event_venue"];
                 [self->event_name addObject:strevent_name];
                 [self->event_venue addObject:strevent_venue];
             }
                 [self.tableView reloadData];
         }
         else if ([msg isEqualToString:@"Review History"] && [status isEqualToString:@"success"])
         {
             NSArray *data  = [responseObject objectForKey:@"Data"];
             for (int i = 0; i < [data count];i++)
             {
                 NSDictionary *dict = [data objectAtIndex:i];
                 NSString *strevent_name =  [dict objectForKey:@"event_name"];
                 NSString *strevent_venue =  [dict objectForKey:@"event_venue"];
                 [self->event_name addObject:strevent_name];
                 [self->event_venue addObject:strevent_venue];
             }
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
-(void)viewWillAppear:(BOOL)animated
{
    NSString *check = [[NSUserDefaults standardUserDefaults]objectForKey:@"LeaderBoardType"];
    
    if ([check isEqualToString:@"Share"])
    {
        self.sideView.backgroundColor = [UIColor colorWithRed:68/255.0f green:77/255.0f blue:161/255.0f alpha:1.0];
    }
    if ([check isEqualToString:@"CheckIn"])
    {
        self.sideView.backgroundColor = [UIColor colorWithRed:237/255.0f green:28/255.0f blue:36/255.0f alpha:1.0];
    }
    if ([check isEqualToString:@"Review"])
    {
        self.sideView.backgroundColor = [UIColor colorWithRed:02/255.0f green:155/255.0f blue:140/255.0f alpha:1.0];
    }
    if ([check isEqualToString:@"Booking"])
    {
        self.sideView.backgroundColor = [UIColor colorWithRed:238/255.0f green:127/255.0f blue:34/255.0f alpha:1.0];
    }
}
- (void)didReceiveMemoryWarning {
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
    return [event_name count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeaderBoardTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.Name.text = [event_name objectAtIndex:indexPath.row];
    cell.location.text = [event_venue objectAtIndex:indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}
- (IBAction)backBtn:(id)sender
{
//  [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
