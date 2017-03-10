//
//  QQHomeTableViewCell.h
//  MyChat
//
//  Created by Apple on 2017/3/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQHomeViewModel.h"
@interface QQHomeTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) QQHomeViewModel *model;

+ (CGFloat)fixedHeight;
@end
