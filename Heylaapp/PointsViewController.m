//
//  PointsViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 03/09/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "PointsViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface PointsViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *email_id;
    NSMutableArray *name;
    NSMutableArray *total_points;
    NSMutableArray *user_name;
    NSMutableArray *user_picture;

}
@end

@implementation PointsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    email_id = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    total_points = [[NSMutableArray alloc]init];
    user_name = [[NSMutableArray alloc]init];
    user_picture = [[NSMutableArray alloc]init];

    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *user_pointsuser_id = @"apimain/user_points";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,user_pointsuser_id, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"Points found"] && [status isEqualToString:@"success"])
         {
             NSArray *user_points = [responseObject objectForKey:@"user_points"];
             for (int i =0 ; i < [user_points count]; i++)
             {
                 NSDictionary *dict = [user_points objectAtIndex:i];
                 NSString *stremail_id = [dict objectForKey:@"email_id"];
                 NSString *strname = [dict objectForKey:@"name"];
                 NSString *strtotal_points = [dict objectForKey:@"total_points"];
                 NSString *struser_name = [dict objectForKey:@"user_name"];
                 NSString *struser_picture = [dict objectForKey:@"user_picture"];

                 [self->email_id addObject:stremail_id];
                 [self->name addObject:strname];
                 [self->total_points addObject:strtotal_points];
                 [self->user_name addObject:struser_name];
                 [self->user_picture addObject:struser_picture];

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
    return [user_name count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PointsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.userName.text = [name objectAtIndex:indexPath.row];
    if ([cell.userName.text isEqualToString:@""])
    {
         cell.userName.text = [name objectAtIndex:indexPath.row];
    }
     NSString *imageUrl = [user_picture objectAtIndex:indexPath.row];
    __weak PointsTableViewCell *weakCell = cell;
    UIImage *placeholderImage = [UIImage imageNamed:@"profile.png"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
    [cell.userImage setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
     {
         weakCell.userImage.hidden = YES;
//         weakCell.userImage.image = image;
//         weakCell.userImage.layer.cornerRadius =  25;
//         weakCell.userImage.clipsToBounds = YES;
//         weakCell.userImage.layer.masksToBounds = YES;
         
     } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
         
         NSLog(@"%@",error);
         
     }];
    cell.userPoints.text = [total_points objectAtIndex:indexPath.row];
    cell.userRank.text = [NSString stringWithFormat:@"%li", indexPath.row +1];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 69;
}
- (IBAction)backButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
