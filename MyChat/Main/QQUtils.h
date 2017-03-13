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
+(NSDictionary *)getDefaultWithplistName:(NSString *)plistName dir:(NSString *)dir;
+(void)saveDefaultWithData:(NSDictionary *)data plistName:(NSString *)plistName dir:(NSString *)dir;
+(void)saveDefaultImageWithUrl:(NSString *)url imageName:(NSString *)imageName imagePath:(NSString *)imagePath;
+(BOOL) isFileExist:(NSString *)fileName dir:(NSString *)dir;
+(NSString *)getDefaultImageWithName:(NSString *)imageName imagePath:(NSString *)imagePath;
+(void)saveChattingRecord:(NSMutableArray *)array withWho:(NSString *)username dir:(NSString *)dir;
+(NSMutableArray *)getRecordWithName:(NSString *)username dir:(NSString *)dir;
+(void)createDir;
@end
