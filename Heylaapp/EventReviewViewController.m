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
    NSString *aa;
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
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
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
                 
                 [self->comments addObject:strComments];
                 [self->event_id addObject:strevent_id];
                 [self->event_name addObject:strevent_name];
                 [self->event_rating addObject:strevent_rating];
                 [self->_id addObject:strid];
                 [self->user_name addObject:struser_name];

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
    
    self.tableView.estimatedRowHeight = 93;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
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
    
    cell.report_Outlet.tag = 1;
    [cell.report_Outlet addTarget:self action:@selector(reportButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.name.text = [user_name objectAtIndex:indexPath.row];
    cell.name.numberOfLines = 0;
    cell.status.numberOfLines = 0;
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
-(void)reportButtonClicked:(UIButton*)sender
{
    if (sender.tag == 1)
    {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
        NSString *review_id = [_id objectAtIndex:[indexPath row]];
        
        appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:review_id forKey:@"review_id"];
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        NSString *report_abuse = @"apimain/report_abuse";
        NSArray *components = [NSArray arrayWithObjects:baseUrl,report_abuse, nil];
        NSString *api = [NSString pathWithComponents:components];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             
             NSLog(@"%@",responseObject);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *msg = [responseObject objectForKey:@"msg"];
             NSString *status = [responseObject objectForKey:@"status"];
             NSLog(@"%@",msg);
             
             if ([status isEqualToString:@"success"])
             {
                 UIAlertController *alert= [UIAlertController
                                            alertControllerWithTitle:@"Heyla"
                                            message:msg
                                            preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* ok = [UIAlertAction
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
                 
             }
         }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             NSLog(@"error: %@", error);
         }];
    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *str = [comments objectAtIndex:indexPath.row];
//    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"muli" size:17] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:NSLineBreakByWordWrapping];
//    NSLog(@"%f",size.height);
//    return size.height + 10;
//}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)plusBtn:(id)sender
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([appDel.user_type isEqualToString:@"2"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@"Login to Access"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                 [self presentViewController:loginViewController animated:NO completion:nil];
                             }];
        
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"addreview"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Booking" bundle:nil];
        AddingReviewViewController *myNewVC = (AddingReviewViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AddingReviewViewController"];
        [self.navigationController pushViewController:myNewVC animated:YES];
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
