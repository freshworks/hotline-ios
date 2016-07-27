//
//  AppDelegate.m
//  Hotline
//
//  Copyright © 2016 Freshdesk. All rights reserved.
//

#import "AppDelegate.h"
#import "Hotline.h"

@interface AppDelegate ()

@property (nonatomic, strong)UIViewController *rootController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self hotlineIntegration];
    [self registerAppForNotifications];
    if ([[Hotline sharedInstance]isHotlineNotification:launchOptions]) {
        [[Hotline sharedInstance]handleRemoteNotification:launchOptions andAppstate:application.applicationState];
    }
    
    NSLog(@"launchoptions :%@", launchOptions);
    return YES;
}

-(void)hotlineIntegration{
    // Setup Hotline
    // Access your App Id and App Key from https://web.hotline.io/settings/apisdk
    
    HotlineConfig *config = [[HotlineConfig alloc]initWithAppID:@"<#<APP ID>#>" andAppKey:@"<#<APP KEY>#>"];
    config.voiceMessagingEnabled = YES;
    config.pictureMessagingEnabled = YES;
    
    // Initialize Hotline
    [[Hotline sharedInstance]initWithConfig:config];
    
    // Setup user info
    HotlineUser *user = [HotlineUser sharedInstance];
    user.name = @"John Doe";
    user.email = @"john@example.com";
    user.phoneCountryCode = @"+91";
    user.phoneNumber = @"1232343231";
    
    [[Hotline sharedInstance] updateUser:user];
    
    //Update user properties with custom key
    [[Hotline sharedInstance] updateUserProperties:@{
                                                     @"paid_user" : @"yes",
                                                     @"plan" : @"blossom" }];
    
    NSLog(@"Unread messages count :%d", (int)[[Hotline sharedInstance]unreadCount]);
    
    //Check unread messages for the user
    [[Hotline sharedInstance]unreadCountWithCompletion:^(NSInteger count) {
        NSLog(@"Unread count (Async) : %d", (int)count);
    }];
}

-(void)registerAppForNotifications{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeNewsstandContentAvailability| UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSLog(@"Registered Device Token  %@", devToken);
    NSLog(@"is app registered for notifications :: %d" , [[UIApplication sharedApplication] isRegisteredForRemoteNotifications]);
    [[Hotline sharedInstance] updateDeviceToken:devToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Failed to register remote notification  %@", error);
}

- (void) application:(UIApplication *)app didReceiveRemoteNotification:(NSDictionary *)info{
    if ([[Hotline sharedInstance]isHotlineNotification:info]) {
        [[Hotline sharedInstance]handleRemoteNotification:info andAppstate:app.applicationState];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    NSInteger unreadCount = [[Hotline sharedInstance]unreadCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:unreadCount];
}

/*
 Sample URLs to test Deep link
 hotline://?launch=chatScreen
 */
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.scheme isEqualToString:@"hotline"]) {
        if ([url.query isEqualToString:@"launch=chatScreen"]) {
            NSLog(@"Lauch chat screen");
        }
    }
    return YES;
}

@end