//
//  QQTabbarViewController.m
//  MyChat
//
//  Created by Apple on 2017/3/8.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQTabbarViewController.h"
#import "QQMeTableViewController.h"
#import "QQHomeViewController.h"
#import "QQFriendViewController.h"
#import "QQContactViewController.h"
#import "QQNavigationController.h"
@interface QQTabbarViewController ()

@end

@implementation QQTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QQHomeViewController *home = [[QQHomeViewController alloc]init];
    [self addChildVc:home title:@"微信" image:@"tabbar_mainframe" selectImage:@"tabbar_mainframeHL"];
    QQContactViewController *messageCenter =[[QQContactViewController alloc]init];
    [self addChildVc:messageCenter title:@"通讯录" image:@"tabbar_contacts" selectImage:@"tabbar_contactsHL"];
    QQFriendViewController *discover = [[QQFriendViewController alloc]init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectImage:@"tabbar_discover"];
    QQMeTableViewController *profile = [[QQMeTableViewController alloc]init];
    [self addChildVc:profile title:@"我" image:@"tabbar_me" selectImage:@"tabbar_meHL"];
    
}

-(void )addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectedImage
{
    //设置子控制器颜色图片
    //    childVc.tabBarItem.title = title;    设置tabbar标题
    //    childVc.navigationItem.title = title;  设置nav标题
    childVc.title = title;                  //同时设置tabbar和nav标题
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSMutableDictionary *textarr = [NSMutableDictionary dictionary];
    textarr[NSForegroundColorAttributeName] = [UIColor blackColor];
    NSMutableDictionary *selectedtextarr = [NSMutableDictionary dictionary];
    selectedtextarr[NSForegroundColorAttributeName] = [UIColor greenColor];
    [childVc.tabBarItem setTitleTextAttributes:textarr forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedtextarr forState:UIControlStateSelected];
    //childVc.view.backgroundColor = HWRandomColor ;
    QQNavigationController *nav = [[QQNavigationController alloc]initWithRootViewController:childVc];
    nav.navigationBar.barTintColor = [UIColor blackColor];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [self addChildViewController:nav];
}


@end
