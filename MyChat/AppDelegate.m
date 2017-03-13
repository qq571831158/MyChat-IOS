//
//  AppDelegate.m
//  MyChat
//
//  Created by Apple on 2017/3/7.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "QQTabbarViewController.h"
#import "IQKeyboardManager.h"
#import "QQLoginViewController.h"
#import "QQUtils.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;//这个是点击空白区域键盘收缩的开关
    manager.enableAutoToolbar = NO;//这个是它自带键盘工具条开关
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [QQUtils createDir];
    //2.显示窗口
    [self.window  makeKeyAndVisible];
    
    //3.设置根控制器
    if([QQUtils getDefaultWithplistName:@"userinfo.plist" dir:@"userinfo"]){
        self.window.rootViewController = [[QQTabbarViewController alloc]init];
    }
    else{
        self.window.rootViewController = [[QQLoginViewController alloc]init];
    }
    

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RECEIVE_MESSAGE"
                                                        object:nil];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enter"
                                                        object:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
