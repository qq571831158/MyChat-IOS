//
//  QQUtils.m
//  MyChat
//
//  Created by Apple on 2017/3/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQUtils.h"
#import "QQChatModel.h"
@implementation QQUtils

#pragma -mark 字典转化成json

+(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma -mark 获取沙盒数据
+(NSDictionary *)getDefaultWithplistName:(NSString *)plistName dir:(NSString *)dir{
    // 1.获得沙盒根路径
    NSString *home = NSHomeDirectory();
    
    // 2.document路径
    NSString *docPath = [home stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",dir]];
    
    // 3.文件路径
    NSString *filepath = [docPath stringByAppendingPathComponent:plistName];
    
    // 4.读取数据
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:filepath];
    NSLog(@"%@", data);
    return data;
}

+(NSString *)getDefaultImageWithName:(NSString *)imageName imagePath:(NSString *)imagePath{
    // 1.获得沙盒根路径
    NSString *home = NSHomeDirectory();
    
    // 2.document路径
    NSString *docPath = [home stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",imagePath]];
    
    // 3.文件路径
    NSString *filepath = [docPath stringByAppendingPathComponent:imageName];

    return filepath;
    
}

+(void)saveDefaultWithData:(NSDictionary *)data plistName:(NSString *)plistName dir:(NSString *)dir{
    // 1.获得沙盒根路径
    NSString *home = NSHomeDirectory();
    // 2.document路径
    NSString *docPath = [home stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",dir]];
    
    NSString *filepath = [docPath stringByAppendingPathComponent:plistName];
    
    [data writeToFile:filepath atomically:YES];
    
}

+(void)saveChattingRecord:(NSMutableArray *)array withWho:(NSString *)username dir:(NSString *)dir{
    //写入到沙盒
    if (![self isFileExist:[NSString stringWithFormat:@"%@",username] dir:dir]) {
        NSArray *path =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *fileName = [path.firstObject stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",dir,username]];
        NSLog(@"%@",fileName);
        BOOL success = [NSKeyedArchiver archiveRootObject:array toFile:fileName];
        if(success){
            NSLog(@"归档成功");
        }
        else{
            NSLog(@"归档失败");
        }

    }
}

+(NSMutableArray *)getRecordWithName:(NSString *)username dir:(NSString *)dir{
    NSMutableArray *array = [NSMutableArray array];
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *newFilePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",dir,username]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:newFilePath]){
        array = [NSKeyedUnarchiver unarchiveObjectWithFile:newFilePath];
    }
    else{
        NSLog(@"暂无记录");
    }
    return array;
}

+(void)saveDefaultImageWithUrl:(NSString *)url imageName:(NSString *)imageName imagePath:(NSString *)imagePath{
        UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        // 本地沙盒目录
        NSString *path = NSHomeDirectory();
        // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
        NSString *imageFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",imagePath]];
        NSString *filepath = [imageFilePath stringByAppendingPathComponent:imageName];
        if(![QQUtils isFileExist:imageName dir:imagePath]){
        // 将取得的图片写入本地的沙盒中，其中0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
        BOOL succuss = [UIImageJPEGRepresentation(imgFromUrl, 1) writeToFile:filepath atomically:YES];
        if(succuss)
            NSLog(@"写入本地成功");
    }
}

+(BOOL) isFileExist:(NSString *)fileName dir:(NSString *)dir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",dir,fileName]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}
+(void)createDir{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/userinfo", pathDocuments];
    NSString *createDir = [NSString stringWithFormat:@"%@/friendinfo", pathDocuments];
    NSString *chattingRecord = [NSString stringWithFormat:@"%@/chattingRecord", pathDocuments];
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createDirectoryAtPath:createDir withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createDirectoryAtPath:chattingRecord withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"FileDir is exists.");
    }
}
@end
