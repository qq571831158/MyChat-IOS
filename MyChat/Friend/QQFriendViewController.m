//
//  QQFriendViewController.m
//  MyChat
//
//  Created by Apple on 2017/3/8.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQFriendViewController.h"
#import "QQUtils.h"
@interface QQFriendViewController ()
@property(nonatomic,strong)UILabel *username;
@end

@implementation QQFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *dict = [QQUtils getDefaultUserNameWithplistname:@"userinfo.plist"];
    NSLog(@"从沙盒取得的数据%@",dict);
    _username = [[UILabel alloc]init];
    _username.frame = CGRectMake(100, 300, 100, 20);
    _username.backgroundColor = [UIColor blueColor];
    self.username.text = dict[@"username"];
    [self.view addSubview:_username];
    NSString *aPath3=[NSString stringWithFormat:@"%@", dict[@"user_picture"]];
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
    NSLog(@"%@",imgFromUrl3);
    UIImageView* imageView3=[[UIImageView alloc]initWithImage:imgFromUrl3];
    imageView3.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:imageView3];
}


@end
