//
//  QQFriendModel.h
//  MyChat
//
//  Created by Apple on 2017/3/8.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQFriendModel : NSObject
/** 好友用户名 */
@property (nonatomic, copy) NSString *username;
/** 好友图片 */
@property (nonatomic, copy) NSString *user_picture;
/** 好友昵称 */
@property(nonatomic,copy) NSString * nickname;

@end
