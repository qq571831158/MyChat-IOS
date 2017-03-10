//
//  QQUtils.m
//  MyChat
//
//  Created by Apple on 2017/3/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQUtils.h"

@implementation QQUtils

#pragma -mark 字典转化成json

+(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma -mark 获取沙盒数据
+(NSDictionary *)getDefaultUserNameWithplistname:(NSString *)plistName{
    // 1.获得沙盒根路径
    NSString *home = NSHomeDirectory();
    
    // 2.document路径
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    
    // 3.文件路径
    NSString *filepath = [docPath stringByAppendingPathComponent:plistName];
    
    // 4.读取数据
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:filepath];
    NSLog(@"%@", data);
    return data;
}

+(void)saveDefaultWithData:(NSDictionary *)data plistName:(NSString *)plistName{
    // 1.获得沙盒根路径
    NSString *home = NSHomeDirectory();
    // 2.document路径
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    
    NSString *filepath = [docPath stringByAppendingPathComponent:plistName];
    
    [data writeToFile:filepath atomically:YES];

}
@end
