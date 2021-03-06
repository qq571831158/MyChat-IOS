//
//  QQMeTableViewController.m
//  MyChat
//
//  Created by Apple on 2017/3/10.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQMeTableViewController.h"
#import "QQUtils.h"
@interface QQMeTableViewController ()

@end

@implementation QQMeTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [[UIStoryboard storyboardWithName:@"QQMeTableViewController" bundle:nil] instantiateInitialViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = [QQUtils getDefaultUserNameWithplistname:@"userinfo.plist"];
    self.username.text = dict[@"username"];
    NSString *url=[NSString stringWithFormat:@"%@", dict[@"user_picture"]];
    self.imageView.image = [[UIImage alloc]initWithContentsOfFile:url];
    self.nickname.text = dict[@"nickname"];
    self.imageView.layer.cornerRadius = 5;
    self.imageView.clipsToBounds = YES;
    self.tableView.tableFooterView = [UIView new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}


@end
