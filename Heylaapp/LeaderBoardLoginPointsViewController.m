//
//  LeaderBoardLoginPointsViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 20/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "LeaderBoardLoginPointsViewController.h"

@interface LeaderBoardLoginPointsViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation LeaderBoardLoginPointsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dailyPointsView.layer.cornerRadius = 10.0;
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    [parameters setObject:@"1" forKey:@"rule_id"];
    
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
         
         if ([msg isEqualToString:@"Login History"] && [status isEqualToString:@"success"])
         {
             self.totalLoginPoints.text = [responseObject objectForKey:@"Totalpoints"];
             NSArray *Data = [responseObject objectForKey:@"Data"];
             NSString *strcons_login_days;
             NSString *strlogin_date;
             for (int i =0; i < [Data count]; i++)
             {
                 NSDictionary *dict = [Data objectAtIndex:i];
                 strcons_login_days = [dict objectForKey:@"cons_login_days"];
                 strlogin_date = [dict objectForKey:@"login_date"];
             }
             if ([strcons_login_days isEqualToString:@"1"])
             {
                 self.dateOneImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateOneStarImg.image = [UIImage imageNamed:@"Star"];
             }
             else if ([strcons_login_days isEqualToString:@"2"])
             {
                 self.dateOneImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateOneStarImg.image = [UIImage imageNamed:@"Star"];
                 self.dateTwoImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateTwoStarImg.image = [UIImage imageNamed:@"Star"];
             }
             else if ([strcons_login_days isEqualToString:@"3"])
             {
                 self.dateOneImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateOneStarImg.image = [UIImage imageNamed:@"Star"];
                 self.dateTwoImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateTwoStarImg.image = [UIImage imageNamed:@"Star"];
                 self.dateThreeImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateThreeStarImg.image = [UIImage imageNamed:@"Star"];
             }
             else if ([strcons_login_days isEqualToString:@"4"])
             {
                 self.dateOneImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateOneStarImg.image = [UIImage imageNamed:@"Star"];
                 self.dateTwoImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateTwoStarImg.image = [UIImage imageNamed:@"Star"];
                 self.dateThreeImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateThreeStarImg.image = [UIImage imageNamed:@"Star"];
                 self.dateFourImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateFourStarImg.image = [UIImage imageNamed:@"Star"];
             }
             else if ([strcons_login_days isEqualToString:@"5"])
             {
                 self.dateOneImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateOneStarImg.image = [UIImage imageNamed:@"Star"];
                 self.dateTwoImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateTwoStarImg.image = [UIImage imageNamed:@"Star"];
                 self.dateThreeImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateThreeStarImg.image = [UIImage imageNamed:@"Star"];
                 self.dateFourImgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateFourStarImg.image = [UIImage imageNamed:@"Star"];
                 self.dateFiveimgView.image = [UIImage imageNamed:@"Pointsselect"];
                 self.dateFiveStarImg.image = [UIImage imageNamed:@"Star"];
             }
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

- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
