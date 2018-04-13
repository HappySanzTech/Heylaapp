//
//  EventReviewViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 19/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "EventReviewViewController.h"

@interface EventReviewViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *comments;
    NSMutableArray *event_id;
    NSMutableArray *event_name;
    NSMutableArray *event_rating;
    NSMutableArray *_id;
    NSMutableArray *user_name;

}
@end

@implementation EventReviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    comments =[[NSMutableArray alloc]init];
    event_id =[[NSMutableArray alloc]init];
    event_name =[[NSMutableArray alloc]init];
    event_rating =[[NSMutableArray alloc]init];
    _id =[[NSMutableArray alloc]init];
    user_name =[[NSMutableArray alloc]init];

    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.event_id forKey:@"event_id"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *bookinghistory = @"apimain/listEventReview";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,bookinghistory, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         if ([msg isEqualToString:@"View Reviews"] && [status isEqualToString:@"success"])
         {
             NSArray *Reviewdetails = [responseObject objectForKey:@"Reviewdetails"];
             for (int i = 0; i < [Reviewdetails count]; i++)
             {
                 NSDictionary *dict = [Reviewdetails objectAtIndex:i];
                 NSString *strComments = [dict objectForKey:@"comments"];
                 NSString *strevent_id = [dict objectForKey:@"event_id"];
                 NSString *strevent_name = [dict objectForKey:@"event_name"];
                 NSString *strevent_rating = [dict objectForKey:@"event_rating"];
                 NSString *strid = [dict objectForKey:@"id"];
                 NSString *struser_name = [dict objectForKey:@"user_name"];
                 
                 [comments addObject:strComments];
                 [event_id addObject:strevent_id];
                 [event_name addObject:strevent_name];
                 [event_rating addObject:strevent_rating];
                 [_id addObject:strid];
                 [user_name addObject:struser_name];

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
    return [user_name count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventReviewTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.name.text = [user_name objectAtIndex:indexPath.row];
    cell.status.text = [comments objectAtIndex:indexPath.row];
    
    NSString *strEventRating = [event_rating objectAtIndex:indexPath.row];
    if ([strEventRating isEqualToString:@"0"])
    {
        cell.firstImage.image = [UIImage imageNamed:@"star icon"];
        cell.secondImage.image = [UIImage imageNamed:@"star icon"];
        cell.thirdImage.image = [UIImage imageNamed:@"star icon"];
        cell.fourImage.image = [UIImage imageNamed:@"star icon"];
        cell.fifthImage.image = [UIImage imageNamed:@"star icon"];

    }
    else if ([strEventRating isEqualToString:@"1"])
    {
        cell.firstImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.secondImage.image = [UIImage imageNamed:@"star icon"];
        cell.thirdImage.image = [UIImage imageNamed:@"star icon"];
        cell.fourImage.image = [UIImage imageNamed:@"star icon"];
        cell.fifthImage.image = [UIImage imageNamed:@"star icon"];
    }
    else if ([strEventRating isEqualToString:@"2"])
    {
        cell.firstImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.secondImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.thirdImage.image = [UIImage imageNamed:@"star icon"];
        cell.fourImage.image = [UIImage imageNamed:@"star icon"];
        cell.fifthImage.image = [UIImage imageNamed:@"star icon"];
    }
    else if ([strEventRating isEqualToString:@"3"])
    {
        cell.firstImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.secondImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.thirdImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.fourImage.image = [UIImage imageNamed:@"star icon"];
        cell.fifthImage.image = [UIImage imageNamed:@"star icon"];
    }
    else if ([strEventRating isEqualToString:@"4"])
    {
        cell.firstImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.secondImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.thirdImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.fourImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.fifthImage.image = [UIImage imageNamed:@"star icon"];
    }
    else if ([strEventRating isEqualToString:@"5"])
    {
        cell.firstImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.secondImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.thirdImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.fourImage.image = [UIImage imageNamed:@"star icon_selected"];
        cell.fifthImage.image = [UIImage imageNamed:@"star icon_selected"];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)plusBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
    AddingReviewViewController *myNewVC = (AddingReviewViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AddingReviewViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
