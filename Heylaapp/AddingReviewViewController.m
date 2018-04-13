//
//  AddingReviewViewController.m
//  Heylaapp
//
//  Created by Happy Sanz Tech on 19/01/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "AddingReviewViewController.h"

@interface AddingReviewViewController ()
{
    AppDelegate *appDel;
    NSString *first;
    NSString *second;
    NSString *third;
    NSString *four;
    NSString *five;
    NSString *msg;
    NSString *selectedStars;
    NSString *strComments;
    NSString *_id;
    NSString *status;
}
@end

@implementation AddingReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    _commentTxtfiled.delegate = self;
    _commentTxtfiled.layer.cornerRadius = 5.0;
    _commentTxtfiled.layer.borderWidth = 1.0;
    _commentTxtfiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _commentTxtfiled.layer.masksToBounds = YES;
    _submit.layer.cornerRadius = 4.0;
    
    first = @"0";
    second = @"0";
    third = @"0";
    four = @"0";
    five = @"0";
    selectedStars = @"0";
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.event_id forKey:@"event_id"];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
   
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *checkReview = @"apimain/checkReview";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,checkReview, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         msg = [responseObject objectForKey:@"msg"];
         status = [responseObject objectForKey:@"status"];
         appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
         appDel.review_id = [responseObject objectForKey:@"review_id"];
         
         if ([msg isEqualToString:@"Already Exist"] && [status isEqualToString:@"exist"])
         {
             
             NSArray *Reviewdetails = [responseObject objectForKey:@"Reviewdetails"];
             NSString *event_rating;
             for (int i = 0; i < [Reviewdetails count];i++)
             {
                 NSDictionary *dict = [Reviewdetails objectAtIndex:i];
                 strComments = [dict objectForKey:@"comments"];
                 _id = [dict objectForKey:@"id"];
                 event_rating = [dict objectForKey:@"event_rating"];
             }
             self.commentTxtfiled.text =strComments;
             
             if ([event_rating isEqualToString:@"0"])
             {
                 [_firstStar setSelected:NO];
                 [_secondStar setSelected:NO];
                 [_thiredStar setSelected:NO];
                 [_fourthStar setSelected:NO];
                 [_fivethStar setSelected:NO];
                 
                 selectedStars = @"0";

             }
             else if ([event_rating isEqualToString:@"1"])
             {
                 [_firstStar setSelected:YES];
                 [_secondStar setSelected:NO];
                 [_thiredStar setSelected:NO];
                 [_fourthStar setSelected:NO];
                 [_fivethStar setSelected:NO];
                 
                 selectedStars = @"1";
                 first = @"1";


             }
             else if ([event_rating isEqualToString:@"2"])
             {
                 [_firstStar setSelected:YES];
                 [_secondStar setSelected:YES];
                 [_thiredStar setSelected:NO];
                 [_fourthStar setSelected:NO];
                 [_fivethStar setSelected:NO];
                 
                 selectedStars = @"2";
                 first = @"1";
                 second = @"1";

             }
             else if ([event_rating isEqualToString:@"3"])
             {
                 [_firstStar setSelected:YES];
                 [_secondStar setSelected:YES];
                 [_thiredStar setSelected:YES];
                 [_fourthStar setSelected:NO];
                 [_fivethStar setSelected:NO];
                 
                 selectedStars = @"3";
                 first = @"1";
                 second = @"1";
                 third = @"1";

             }
             else if ([event_rating isEqualToString:@"4"])
             {
                 [_firstStar setSelected:YES];
                 [_secondStar setSelected:YES];
                 [_thiredStar setSelected:YES];
                 [_fourthStar setSelected:YES];
                 [_fivethStar setSelected:NO];
                 
                 selectedStars = @"4";
                 first = @"1";
                 second = @"1";
                 third = @"1";
                 four = @"1";

             }
             else if ([event_rating isEqualToString:@"5"])
             {
                 [_firstStar setSelected:YES];
                 [_secondStar setSelected:YES];
                 [_thiredStar setSelected:YES];
                 [_fourthStar setSelected:YES];
                 [_fivethStar setSelected:YES];
                 
                 selectedStars = @"5";
                 first = @"1";
                 second = @"1";
                 third = @"1";
                 four = @"1";
                 five = @"1";

             }
         }
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
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

- (IBAction)backBtn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EventReviewViewController *myNewVC = (EventReviewViewController *)[storyboard instantiateViewControllerWithIdentifier:@"EventReviewViewController"];
    [self.navigationController pushViewController:myNewVC animated:YES];
}
- (IBAction)firstStarBtn:(id)sender
{
    if ([first isEqualToString:@"0"])
    {
        [_firstStar setSelected:YES];
        first = @"1";
        selectedStars = @"1";
    }
    else
    {
        [_firstStar setSelected:NO];
        first = @"0";
        [_secondStar setSelected:NO];
        second = @"0";
        [_thiredStar setSelected:NO];
        third = @"0";
        [_fourthStar setSelected:NO];
        four = @"0";
        [_fivethStar setSelected:NO];
        five = @"0";
        selectedStars = @"0";
    }
}
- (IBAction)secondStarBtn:(id)sender
{
        if ([second isEqualToString:@"0"])
        {
            [_firstStar setSelected:YES];
            first = @"1";
            [_secondStar setSelected:YES];
            second = @"1";
            selectedStars = @"2";
        }
        else
        {
            [_secondStar setSelected:NO];
            second = @"0";
            [_thiredStar setSelected:NO];
            third = @"0";
            [_fourthStar setSelected:NO];
            four = @"0";
            [_fivethStar setSelected:NO];
            five = @"0";
            selectedStars = @"1";
        }
}
- (IBAction)thiredStarBtn:(id)sender
{
        if ([third isEqualToString:@"0"])
        {
            [_firstStar setSelected:YES];
            first = @"1";
            [_secondStar setSelected:YES];
            second = @"1";
            [_thiredStar setSelected:YES];
            third = @"1";
            selectedStars = @"3";
        }
        else
        {
            [_thiredStar setSelected:NO];
            third = @"0";
            [_fourthStar setSelected:NO];
            four = @"0";
            [_fivethStar setSelected:NO];
            five = @"0";
            selectedStars = @"2";
        }
}
- (IBAction)fourthStarBtn:(id)sender
{
        if ([four isEqualToString:@"0"])
        {
            [_firstStar setSelected:YES];
            first = @"1";
            [_secondStar setSelected:YES];
            second = @"1";
            [_thiredStar setSelected:YES];
            third = @"1";
            [_fourthStar setSelected:YES];
            four = @"1";
            selectedStars = @"4";
        }
        else
        {
            [_fourthStar setSelected:NO];
            four = @"0";
            [_fivethStar setSelected:NO];
            five = @"0";
            selectedStars = @"3";
        }
}
- (IBAction)fivethStarBtn:(id)sender
{
        if ([five isEqualToString:@"0"])
        {
            [_firstStar setSelected:YES];
            first = @"1";
            [_secondStar setSelected:YES];
            second = @"1";
            [_thiredStar setSelected:YES];
            third = @"1";
            [_fourthStar setSelected:YES];
            four= @"1";
            [_fivethStar setSelected:YES];
            five = @"1";
            selectedStars = @"5";
        }
        else
        {
            [_fivethStar setSelected:NO];
            five = @"0";
            selectedStars = @"4";
        }
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.commentTxtfiled)
    {
        [_commentTxtfiled resignFirstResponder];
    }
    return YES;
}
- (IBAction)submitBtn:(id)sender
{
    if ([selectedStars isEqualToString:@"0"])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@""
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
    else if ([self.commentTxtfiled.text isEqualToString:@""])
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Heyla"
                                   message:@""
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
    else if ([status isEqualToString:@"exist"])
    {
        [self UpdateEventReview];
    }
    else
    {
        [self AddEventReview];

    } 
}
-(void)AddEventReview
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:appDel.event_id forKey:@"event_id"];
    [parameters setObject:appDel.user_Id forKey:@"user_id"];
    [parameters setObject:selectedStars forKey:@"rating"];
    [parameters setObject:self.commentTxtfiled.text forKey:@"comments"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *addReview = @"apimain/addReview";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,addReview, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
         appDel.review_id = [responseObject objectForKey:@"review_id"];
         
         if ([msg isEqualToString:@"Review Added"] && [status isEqualToString:@"success"])
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
                                      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                      EventReviewViewController *myNewVC = (EventReviewViewController *)[storyboard instantiateViewControllerWithIdentifier:@"EventReviewViewController"];
                                      [self.navigationController pushViewController:myNewVC animated:YES];
                                  }];
             
             [alert addAction:ok];
             [self presentViewController:alert animated:YES completion:nil];
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
-(void)UpdateEventReview
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:_id forKey:@"review_id"];
    [parameters setObject:selectedStars forKey:@"rating"];
    [parameters setObject:self.commentTxtfiled.text forKey:@"comments"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *updateReview = @"apimain/updateReview";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,updateReview, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
         appDel.review_id = [responseObject objectForKey:@"review_id"];
         
         if ([msg isEqualToString:@"Review Added"] && [status isEqualToString:@"success"])
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
                                      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                      EventReviewViewController *myNewVC = (EventReviewViewController *)[storyboard instantiateViewControllerWithIdentifier:@"EventReviewViewController"];
                                      [self.navigationController pushViewController:myNewVC animated:YES];
                                  }];
             
             [alert addAction:ok];
             [self presentViewController:alert animated:YES completion:nil];
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
-(void)dismissKeyboard
{
    [_commentTxtfiled resignFirstResponder];
}
@end
