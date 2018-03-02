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
#import <AFNetworking.h>

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
    
    [self check_update];
    
    return YES;
}


- (void)check_update {
    NSString *appID = @"444934666";
    
    NSString *checkURL = [NSString stringWithFormat:@"%@%@", @"https://itunes.apple.com/lookup?id=", appID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:checkURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _view.userInteractionEnabled = YES;
        _view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.4];
        [self.window addSubview:_view];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 60, [UIScreen mainScreen].bounds.size.width - 60, [UIScreen mainScreen].bounds.size.height - 120)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:@"update2.png"];
        [_view addSubview:imageView];
        
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, [UIScreen mainScreen].bounds.size.width - 80, 120)];
        contentLabel.numberOfLines = 6;
        contentLabel.font = [UIFont systemFontOfSize:13];
        contentLabel.text = [[[responseObject objectForKey:@"results"] objectAtIndex:0] valueForKey:@"releaseNotes"];
        [imageView addSubview:contentLabel];
        
        UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        updateBtn.frame = CGRectMake((CGRectGetWidth(imageView.frame) - 120) / 2, CGRectGetMaxY(imageView.frame) - 110, 120, 40);
        [imageView addSubview:updateBtn];
        [updateBtn addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchUpInside];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)updateAction {
//    itms-apps://itunes.apple.com/cn/app/id1144816653?mt=8
    NSString *appID = @"444934666";
    NSString *url_string = [NSString stringWithFormat:@"%@%@%@", @"itms-apps://itunes.apple.com/cn/app/id", appID, @"?mt=8"];
    if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url_string]];
        [_view removeFromSuperview];
        _view = nil;
    } else {
        NSDictionary *dic = @{};
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url_string] options:dic completionHandler:^(BOOL success) {
                [_view removeFromSuperview];
                _view = nil;
            }];
        } else {
            // Fallback on earlier versions
        }
    }
}

@end
