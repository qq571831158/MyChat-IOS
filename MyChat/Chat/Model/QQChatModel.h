//
//  QQChatModel.h
//  MyChat
//
//  Created by Apple on 2017/3/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    SDMessageTypeSendToOthers,
    SDMessageTypeSendToMe
} SDMessageType;
@interface QQChatModel : NSObject
@property (nonatomic, assign) SDMessageType messageType;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *imageName;

@end
