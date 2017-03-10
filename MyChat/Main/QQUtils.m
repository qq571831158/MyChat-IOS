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

+(NSString *)saveDefaultImageWithUrl:(NSString *)url imageName:(NSString *)imageName{
        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        // 本地沙盒目录
        NSString *path = NSHomeDirectory();
        // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
        NSString *imageFilePath = [path stringByAppendingPathComponent:@"Documents"];
        NSString *filepath = [imageFilePath stringByAppendingPathComponent:imageName];
        if(![QQUtils isFileExist:imageName]){
        // 将取得的图片写入本地的沙盒中，其中0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
        BOOL succuss = [UIImageJPEGRepresentation(imgFromUrl, 1) writeToFile:filepath atomically:YES];
        if(succuss)
            NSLog(@"写入本地成功");
    }
        return filepath;
}

+(BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}
@end
