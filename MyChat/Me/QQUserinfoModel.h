//
//  QQUserinfoModel.h
//  MyChat
//
//  Created by Apple on 2017/3/10.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQUserinfoModel : NSObject
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *user_picture;
@property (nonatomic, strong) NSString *sessionID;
+(instancetype)initWithDict:(NSDictionary *)dict imageUrl:(NSString *)url;
@end
