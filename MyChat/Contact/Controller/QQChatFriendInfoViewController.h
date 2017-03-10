//
//  QQChatFriendInfoViewController.h
//  MyChat
//
//  Created by Apple on 2017/3/11.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QQFriendModel.h"
@interface QQChatFriendInfoViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (nonatomic, strong)QQFriendModel *friend;
- (IBAction)sendMessage:(id)sender;
- (IBAction)btn:(id)sender;

- (IBAction)sendVideo:(id)sender;
@end
