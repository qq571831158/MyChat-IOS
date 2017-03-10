//
//  QQChatTableViewCell.h
//  MyChat
//
//  Created by Apple on 2017/3/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQChatModel.h"
#import "MLEmojiLabel.h"
@interface QQChatTableViewCell : UITableViewCell
@property (nonatomic, strong)QQChatModel  *model;

@property (nonatomic, copy) void (^didSelectLinkTextOperationBlock)(NSString *link, MLEmojiLabelLinkType type);
@end
