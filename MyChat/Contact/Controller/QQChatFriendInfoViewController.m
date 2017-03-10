//
//  QQChatFriendInfoViewController.m
//  MyChat
//
//  Created by Apple on 2017/3/11.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQChatFriendInfoViewController.h"
#import "QQChatTableViewController.h"
@implementation QQChatFriendInfoViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
   
    return [[UIStoryboard storyboardWithName:@"QQChatFriendInfoViewController" bundle:nil] instantiateInitialViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.delaysContentTouches = NO;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.clipsToBounds = YES;
    self.imageView.image = [[UIImage alloc]initWithContentsOfFile:self.friend.user_picture];
    self.nameLabel.text = self.friend.nickname;
    self.nicknameLabel.text = self.friend.nickname;
    self.usernameLabel.text = self.friend.username;
    self.tableView.tableFooterView = [UIView new];
}
- (IBAction)sendMessage:(id)sender {
    NSLog(@"执行了该方法");
    QQChatTableViewController *chat = [[QQChatTableViewController alloc]init];
    chat.friend = self.friend;
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
}

- (IBAction)btn:(id)sender {
    NSLog(@"被点击了");
}

- (IBAction)sendVideo:(id)sender {
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
@end
