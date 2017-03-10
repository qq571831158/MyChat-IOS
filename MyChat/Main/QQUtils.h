//
//  QQUtils.h
//  MyChat
//
//  Created by Apple on 2017/3/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQUtils : NSObject
+(NSString*)dictionaryToJson:(NSDictionary *)dic;
+(NSDictionary *)getDefaultUserNameWithplistname:(NSString *)plistName;
+(void)saveDefaultWithData:(NSDictionary *)data plistName:(NSString *)plistName;
+(NSString *)saveDefaultImageWithUrl:(NSString *)url imageName:(NSString *)imageName;
+(BOOL) isFileExist:(NSString *)fileName;
@end
