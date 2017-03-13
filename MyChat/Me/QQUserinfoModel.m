//
//  QQUserinfoModel.m
//  MyChat
//
//  Created by Apple on 2017/3/10.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQUserinfoModel.h"

@implementation QQUserinfoModel
+(instancetype)initWithDict:(NSDictionary *)dict{
    QQUserinfoModel *model = [[QQUserinfoModel alloc]init];
    model.username = dict[@"username"];
    model.sessionID = dict[@"sessionID"];
    model.nickname = dict[@"nickname"];
    model.user_picture = dict[@"user_picture"];
    return model;
}
@end
