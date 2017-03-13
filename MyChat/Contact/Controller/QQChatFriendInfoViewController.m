//
//  QQChatFriendInfoViewController.m
//  MyChat
//
//  Created by Apple on 2017/3/11.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQChatFriendInfoViewController.h"
#import "QQChatTableViewController.h"
#import "QQUtils.h"
@implementation QQChatFriendInfoViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
   
    return [[UIStoryboard storyboardWithName:@"QQChatFriendInfoViewController" bundle:nil] instantiateInitialViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delaysContentTouches = NO;
    for (id obj in self.tableView.subviews)
    {
        if ([NSStringFromClass([obj class]) isEqualToString:@"UITableViewCellScrollView"])
            
        {
            UIScrollView *scroll = (UIScrollView *) obj;
            
            scroll.delaysContentTouches =NO;
            break;
            
        }
    }
    self.imageView.layer.cornerRadius = 5;
    self.imageView.clipsToBounds = YES;
    NSString *user_picture = [QQUtils getDefaultImageWithName:self.friend.username imagePath:@"friendinfo"];
    NSString *url=[NSString stringWithFormat:@"%@.jpg",user_picture];
    self.imageView.image = [[UIImage alloc]initWithContentsOfFile:url];
    self.nameLabel.text = self.friend.nickname;
    self.nicknameLabel.text = self.friend.nickname;
    self.usernameLabel.text = self.friend.username;
    self.tableView.tableFooterView = [UIView new];
}
- (void)sendMessage {
    QQChatTableViewController *chat = [[QQChatTableViewController alloc]init];
    chat.friend = self.friend;
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
}


- (IBAction)sendVideo {
    NSLog(@"视频聊天");
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==3) {
        if (indexPath.row ==0) {
            [self sendMessage];
        }
        else{
            [self sendVideo];
        }
    }
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
