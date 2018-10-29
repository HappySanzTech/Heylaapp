//
//  SelectCategoeryViewController.m
//  Heylaapp
//
//  Created by HappySanz on 14/11/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "SelectCategoeryViewController.h"
#import "SideMenuMainViewController.h"

@interface SelectCategoeryViewController ()
{
    AppDelegate *appDel;
    NSMutableArray *category_id;
    NSMutableArray *category_name;
    NSMutableArray *category_pic;
    NSMutableArray *user_preference;
    NSMutableArray *selectedValue;
    NSString *selectallFlag;
    NSString *setValue;
    NSString *imageOne;
    NSString *imageTwo;
    NSUInteger size;
}
@end

@implementation SelectCategoeryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    category_id = [[NSMutableArray alloc]init];
    category_name = [[NSMutableArray alloc]init];
    category_pic = [[NSMutableArray alloc]init];
    user_preference = [[NSMutableArray alloc]init];
    selectedValue = [[NSMutableArray alloc]init];
    _getStart.layer.cornerRadius = 8;
    _getStart.clipsToBounds = YES;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
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
    self.collectionView.allowsMultipleSelection = YES;
    [self User];
    setValue= @"2";
}
-(void)User
{
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_id"];
    NSString *strUser_type = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_type"];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:user_id forKey:@"user_id"];
    [parameters setObject:strUser_type forKey:@"user_type"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSString *addWishlistMaster = @"apimain/userPreference";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,addWishlistMaster, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Categories"] && [status isEqualToString:@"success"])
         {
             NSArray *Categories = [responseObject objectForKey:@"Categories"];
             self->size = [Categories count];
             
             [self->category_id removeAllObjects];
             [self->category_name removeAllObjects];
             [self->category_pic removeAllObjects];
             [self->user_preference removeAllObjects];
             [self->selectedValue removeAllObjects];
             
             for (int i = 0; i < [Categories count]; i++)
             {
                 NSDictionary *dict = [Categories objectAtIndex:i];
                 NSString *strCategory_id = [dict objectForKey:@"category_id"];
                 NSString *strCategory_name = [dict objectForKey:@"category_name"];
                 NSString *strCategory_pic = [dict objectForKey:@"category_pic"];
                 NSString *strUser_preference = [dict objectForKey:@"user_preference"];
                 
                 [self->category_id addObject:strCategory_id];
                 [self->category_name addObject:strCategory_name];
                 [self->category_pic addObject:strCategory_pic];
                 [self->user_preference addObject:strUser_preference];
             }
             [[NSUserDefaults standardUserDefaults]setObject:self->category_name forKey:@"preferenceName_Array"];
             [self.collectionView reloadData];
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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [category_name count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCategoeryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.borderWidth = 1.0f;
    cell.layer.borderColor=[UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1.0].CGColor;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    if ([setValue isEqualToString:@"1"])
    {
        cell.cellLabel.text = [category_name objectAtIndex:indexPath.row];
        NSString *imageUrl = [category_pic objectAtIndex:indexPath.row];
        __weak SelectCategoeryCollectionViewCell *weakCell = cell;
        UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
        [cell.image_View setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
         {
             weakCell.image_View.image = image;

         } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
             
             NSLog(@"%@",error);
             
         }];
        self.selectAllImageView.image = [UIImage imageNamed:@"white checkbox"];
        cell.checkbox_ImageView.image = [UIImage imageNamed:@"checkbox"];
        [selectedValue removeAllObjects];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    else if ([setValue isEqualToString:@"0"])
    {
        cell.cellLabel.text = [category_name objectAtIndex:indexPath.row];
        NSString *imageUrl = [category_pic objectAtIndex:indexPath.row];
        __weak SelectCategoeryCollectionViewCell *weakCell = cell;
        UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
        [cell.image_View setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
         {
             weakCell.image_View.image = image;
//             weakCell.image_View.frame = CGRectMake(44, 35, 80, 80);

         } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
             
             NSLog(@"%@",error);
             
         }];
        NSString *strcategoery_id = [category_id objectAtIndex:indexPath.row];
        [selectedValue addObject:strcategoery_id];
        self.selectAllImageView.image = [UIImage imageNamed:@"white checkbox tick"];
        cell.checkbox_ImageView.image = [UIImage imageNamed:@"checkboxselected"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }
    else
    {
        if ([category_name count] == [category_id count])
        {            
            cell.cellLabel.text = [category_name objectAtIndex:indexPath.row];
            NSString *imageUrl = [category_pic objectAtIndex:indexPath.row];
            __weak SelectCategoeryCollectionViewCell *weakCell = cell;
            UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:imageUrl]];
            [cell.image_View setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image)
             {
                 weakCell.image_View.image = image;
//                 weakCell.image_View.frame = CGRectMake(44, 35, 80, 80);

             } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                 
                 NSLog(@"%@",error);
                 
             }];
            
            NSString *str_userPreference = [user_preference objectAtIndex:indexPath.row];
            if ([str_userPreference isEqualToString:@"Y"])
            {
                cell.checkbox_ImageView.image = [UIImage imageNamed:@"checkboxselected"];
                NSString *Str_selecetedValues = [category_id objectAtIndex:indexPath.row];
                [selectedValue addObject:Str_selecetedValues];
                
            }
            else
            {
                cell.checkbox_ImageView.image = [UIImage imageNamed:@"checkbox"];
                self.selectAllImageView.image = [UIImage imageNamed:@"white checkbox"];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        }
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCategoeryCollectionViewCell *cell = (SelectCategoeryCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell.checkbox_ImageView. image isEqual:[UIImage imageNamed:@"checkboxselected"]])
    {
        cell.checkbox_ImageView.image = [UIImage imageNamed:@"checkbox"];
        NSString *index = [category_id objectAtIndex:indexPath.row];
        [selectedValue removeObject:index];
        self.selectAllImageView.image = [UIImage imageNamed:@"white checkbox"];
    }
    else
    {
        cell.checkbox_ImageView.image = [UIImage imageNamed:@"checkboxselected"];
        NSString *index = [category_id objectAtIndex:indexPath.row];
        [selectedValue addObject:index];
    }
    
    if ([selectedValue count] == [category_id count])
    {
        self.selectAllImageView.image = [UIImage imageNamed:@"white checkbox tick"];

    }
   
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectCategoeryCollectionViewCell *cell = (SelectCategoeryCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];

    if ([cell.checkbox_ImageView. image isEqual:[UIImage imageNamed:@"checkbox"]])
    {
        cell.checkbox_ImageView.image = [UIImage imageNamed:@"checkboxselected"];
        NSString *index = [category_id objectAtIndex:indexPath.row];
        [selectedValue addObject:index];
        if ([selectedValue count] == [category_id count])
        {
            self.selectAllImageView.image = [UIImage imageNamed:@"white checkbox tick"];
            
        }
        else
        {
            self.selectAllImageView.image = [UIImage imageNamed:@"white checkbox"];

        }
    }
    else
    {
        cell.checkbox_ImageView.image = [UIImage imageNamed:@"checkbox"];
        cell.checkbox_ImageView.image = [UIImage imageNamed:@"checkbox"];
        NSString *index = [category_id objectAtIndex:indexPath.row];
        [selectedValue removeObject:index];
        self.selectAllImageView.image = [UIImage imageNamed:@"white checkbox"];
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0,0,0,0);

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            return CGSizeMake((collectionView.frame.size.width/3), 248);
        }
        else
        {
            return CGSizeMake((collectionView.frame.size.width/3), 128);

        }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return -1;
}
- (IBAction)backBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)selectAllBtn:(id)sender
{
    if ([self.selectAllImageView.image isEqual:[UIImage imageNamed:@"white checkbox tick"]])
    {
        setValue = @"1";
        [self.collectionView reloadData];

    }
    else
    {
        setValue = @"0";
        [self.collectionView reloadData];
    }

}
- (IBAction)getStartBtn:(id)sender
{
        if ([selectedValue count] < 1)
        {
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Heyla"
                                       message:@"Please select any One"
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
            [self serviceCall];
        }
}
-(void)serviceCall
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSString *categoryValue;
    if ([setValue isEqualToString:@"0"])
    {
        NSArray *arr = [NSArray arrayWithArray:selectedValue];
        categoryValue = [arr componentsJoinedByString:@","];
    }
    else
    {
        NSArray *arr = [NSArray arrayWithArray:selectedValue];
        categoryValue = [arr componentsJoinedByString:@","];
    }


    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"stat_user_id"];
    if ([appDel.user_type isEqualToString:@"2"])
    {
        [parameters setObject:user_id forKey:@"user_id"];
        [parameters setObject:@"2" forKey:@"user_type"];
        [parameters setObject:categoryValue forKey:@"category_ids"];
    }
    else
    {
        [parameters setObject:user_id forKey:@"user_id"];
        [parameters setObject:@"1" forKey:@"user_type"];
        [parameters setObject:categoryValue forKey:@"category_ids"];
    }
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *addWishlistMaster = @"apimain/updatePreference";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,addWishlistMaster, nil];
    NSString *api = [NSString pathWithComponents:components];

    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {

         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];

         if ([msg isEqualToString:@"Preference Updated"] && [status isEqualToString:@"success"])
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
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}
@end
