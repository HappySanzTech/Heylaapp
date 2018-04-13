//
//  MenuViewController.m
//  Heylaapp
//
//  Created by HappySanz on 20/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "MenuViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface MenuViewController ()
{
    AppDelegate *appDel;
}
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.imageView.layer.cornerRadius = 50;
    self.imageView.clipsToBounds = YES;
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"fullName"];
    NSLog(@"%@",appDel.login_type);
    if ([appDel.login_type isEqualToString:@"FB"])
    {
        NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:@"picture_Url"];
        UIImage *image = [UIImage imageWithData:data];
        self.imageView.image = image;
       
        UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, [UIScreen mainScreen].scale);
        
        // Add a clip before drawing anything, in the shape of an rounded rect
        [[UIBezierPath bezierPathWithRoundedRect:self.imageView.bounds
                                    cornerRadius:50.0] addClip];
        // Draw your image
        [image drawInRect:self.imageView.bounds];
        
        // Get the image, here setting the UIImageView image
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
    }
    else
    {
        __weak MenuViewController *menu = self;
        UIImage *placeholderImage = [UIImage imageNamed:@"profile.png"];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"picture_Url"]]];
        [self.imageView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
         {
             menu.imageView.image = image;
            
             // Begin a new image that will be the new image with the rounded corners
             // (here with the size of an UIImageView)
             UIGraphicsBeginImageContextWithOptions(menu.imageView.bounds.size, NO, [UIScreen mainScreen].scale);
             
             // Add a clip before drawing anything, in the shape of an rounded rect
             [[UIBezierPath bezierPathWithRoundedRect:menu.imageView.bounds
                                         cornerRadius:50.0] addClip];
             // Draw your image
             [image drawInRect:menu.imageView.bounds];
             
             // Get the image, here setting the UIImageView image
             menu.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
             
             // Lets forget about that we were drawing
             UIGraphicsEndImageContext();
         } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
             
             NSLog(@"%@",error);
             
         }];
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

- (IBAction)signOutBtn:(id)sender
{
    appDel.user_name = @"";
    appDel.picture_url =@"";
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"stat_user_type"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"stat_user_id"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
    [[NSUserDefaults standardUserDefaults]setObject:@"signOut" forKey:@"status"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"picture_Url"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"statemail_id"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"statemobile_no"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"fullName"];
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
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"country_id_key"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"state_id_key"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"city_id_key"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"new_Letter_Key"];
    [self performSegueWithIdentifier:@"menu_signOut" sender:self];
}

- (IBAction)settingsBtn:(id)sender
{
   // [self performSegueWithIdentifier:@"to_settings" sender:self];
}

- (IBAction)notificationBellBtn:(id)sender
{
    
}
- (IBAction)bookingBtn:(id)sender
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
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"bookingHistory" sender:self];

    }
}

- (IBAction)categoeryBtn:(id)sender
{
    [self performSegueWithIdentifier:@"menu_categoery" sender:self];

}

- (IBAction)changeCityBtn:(id)sender
{
    [self performSegueWithIdentifier:@"menu_city" sender:self];
}

- (IBAction)whishListBtn:(id)sender
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"%@",appDel.user_type);
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
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"to_whishlist" sender:self];

    }
}

- (IBAction)shareBtn:(id)sender
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;

    NSString *theMessage = @"Hey! Get the Heyla app and win some exciting rewards.";
    NSString *strURL=[NSString stringWithFormat:@"https://itunes.apple.com/us/app/heyla/id1328232644?ls=1&mt=8"];
    NSURL *urlReq = [NSURL URLWithString:strURL];
    NSArray *items = @[theMessage,urlReq];

    // build an activity view controller
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    // and present it
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [self presentActivityController:controller];

    [MBProgressHUD hideHUDForView:self.view animated:YES];

}
- (void)presentActivityController:(UIActivityViewController *)controller
{
    // for iPad: make the presentation a Popover
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];

    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.leftBarButtonItem;

    // access the completion handler
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        } else {
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }

        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
}
- (IBAction)aboutUsBtn:(id)sender
{
    
}

- (IBAction)rateAppBtn:(id)sender
{
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)profImgBtn:(id)sender
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"%@",appDel.user_type);
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
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
    [self performSegueWithIdentifier:@"to_profile" sender:self];
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
