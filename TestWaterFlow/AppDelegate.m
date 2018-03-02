//
//  AppDelegate.m
//  TestWaterFlow
//
//  Created by 颜仁浩 on 2018/1/4.
//  Copyright © 2018年 颜仁浩. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <StoreKit/StoreKit.h>

@interface AppDelegate ()<SKStoreProductViewControllerDelegate> {
    UIView *_view;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navc;
    
    return YES;
}

@end
