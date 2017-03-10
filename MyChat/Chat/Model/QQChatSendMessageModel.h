//
//  QQChatSendMessageModel.h
//  MyChat
//
//  Created by Apple on 2017/3/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQChatSendMessageModel : NSObject
@property (nonatomic, strong) NSString *fromUser;
@property (nonatomic, strong) NSString *toUser;
@property (nonatomic, strong) NSString *message;
@end
