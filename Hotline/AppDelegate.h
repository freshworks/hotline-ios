//
//  AppDelegate.h
//  Hotline
//
//  Copyright © 2016 Freshdesk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIImage *pickedImage;

@end

