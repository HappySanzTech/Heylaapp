//
//  AppDelegate.h
//  Heylaapp
//
//  Created by HappySanz on 23/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <UserNotifications/UserNotifications.h>
#import "ViewController.h"
#import <Google/Analytics.h>
#import <Firebase/Firebase.h>

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) NSString *mobileNumber;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NSString *OTPNumber;
@property (strong, nonatomic) NSString *user_Id;
@property (strong, nonatomic) NSString *user_type;
@property (strong, nonatomic) NSString *selected_City;
@property (strong, nonatomic) NSString *selected_City_Latittude;
@property (strong, nonatomic) NSString *selected_City_Longitude;
@property (strong, nonatomic) NSString *selected_City_Id;
@property (strong, nonatomic) NSString *address_line_1;
@property (strong, nonatomic) NSString *address_line_2;
@property (strong, nonatomic) NSString *address_line_3;
@property (strong, nonatomic) NSString *birth_date;
@property (strong, nonatomic) NSString *city_id;
@property (strong, nonatomic) NSString *city_name;
@property (strong, nonatomic) NSString *country_id;
@property (strong, nonatomic) NSString *country_name;
@property (strong, nonatomic) NSString *email_id;
@property (strong, nonatomic) NSString *email_verify_status;
@property (strong, nonatomic) NSString *full_name;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *mobile_no;
@property (strong, nonatomic) NSString *newsletter_status;
@property (strong, nonatomic) NSString *occupation;
@property (strong, nonatomic) NSString *picture_url;
@property (strong, nonatomic) NSString *referal_code;
@property (strong, nonatomic) NSString *state_id;
@property (strong, nonatomic) NSString *state_name;
@property (strong, nonatomic) NSString *user_name;
@property (strong, nonatomic) NSString *user_role;
@property (strong, nonatomic) NSString *user_role_name;
@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSString *event_categoery_Ref;
@property (strong, nonatomic) NSString *event_Name;
@property (strong, nonatomic) NSString *event_Address;
@property (strong, nonatomic) NSString *event_StartTime;
@property (strong, nonatomic) NSString *event_EndTime;
@property (strong, nonatomic) NSString *event_StartDate;
@property (strong, nonatomic) NSString *event_EndDate;
@property (strong, nonatomic) NSString *event_EventLatitude;
@property (strong, nonatomic) NSString *event_EventLongitude;
@property (strong, nonatomic) NSString *event_id;
@property (strong, nonatomic) NSString *event_PrimaryContactNumber;
@property (strong, nonatomic) NSString *event_PrimaryContactPerson;
@property (strong, nonatomic) NSString *event_description;
@property (strong, nonatomic) NSString *event_picture;
@property (strong, nonatomic) NSString *event_popularity;
@property (strong, nonatomic) NSString *booking_status;
@property (strong, nonatomic) NSString *event_secondaryContactNumber;
@property (strong, nonatomic) NSString *planEvent_id;
@property (strong, nonatomic) NSString *plan_id;
@property (strong, nonatomic) NSString *plan_time_id;
@property (strong, nonatomic) NSString *seat_rate;
@property (strong, nonatomic) NSString *plan_name;
@property (strong, nonatomic) NSString *event_SelectedTime;
@property (strong, nonatomic) NSString *total_price;
@property (strong, nonatomic) NSString *seat_count;
@property (strong, nonatomic) NSString *bookingdate;
@property (strong, nonatomic) NSString *selected_Event_time;
@property (strong, nonatomic) NSString *event_time_id;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *adv_today;
@property (strong, nonatomic) NSString *adv_tommorow;
@property (strong, nonatomic) NSString *adv_date;
@property (strong, nonatomic) NSString *adv_eventType;
@property (strong, nonatomic) NSString *adv_eventCategoery;
@property (strong, nonatomic) NSString *adv_preference;
@property (strong, nonatomic) NSString *adv_city;
@property (strong, nonatomic) NSString *adv_From;
@property (strong, nonatomic) NSString *adv_To;
@property (strong, nonatomic) NSString *order_id;
@property (strong, nonatomic) NSString *review_id;
@property (strong, nonatomic) NSString *event_Contact_email;
@property (strong, nonatomic) NSString *ticlet_seat_available;
@property (strong, nonatomic) NSString *user_currentLatitude;
@property (strong, nonatomic) NSString *user_currentLongitude;
@property (strong, nonatomic) NSString *event_type;
@property (strong, nonatomic) NSString *login_type;
@property (strong, nonatomic) NSString *wishlist_id;
@property (strong, nonatomic) NSString *reviewComments;
@property (strong, nonatomic) NSString *event_rating;
@property (strong, nonatomic) NSString *reviewList_id;
@property (strong, nonatomic) NSString *reviewUsername;
@property (strong, nonatomic) NSString *reviewEventName;
@property (strong, nonatomic) NSString *totalTickets;
@property (strong, nonatomic) NSString *total_amount_tickets;


@property (nonatomic, strong) UINavigationController *navController;
- (void)saveContext;


@end

