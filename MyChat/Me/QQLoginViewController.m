//
//  QQMeViewController.m
//  MyChat
//
//  Created by Apple on 2017/3/8.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQLoginViewController.h"
#import "AFNetworking.h"
#import "QQUserinfoModel.h"
#import "MJExtension.h"
#import "QQTabbarViewController.h"
@interface QQLoginViewController ()

@end

@implementation QQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)login:(id)sender{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"username"] = self.username.text;
    paras[@"password"]= self.password.text;
    NSLog(@"%@",paras);
    [mgr POST:@"http://182.254.152.99:8080/MyChat1/user/login" parameters:paras success:^(AFHTTPRequestOperation
                                                                             *operation , NSDictionary  *responseObject){
        NSString *code = [responseObject valueForKey:@"code"];
        NSString *message = [responseObject valueForKey:@"message"];
        if ([code isEqualToString:@"S01"]) {
            NSDictionary *dict = responseObject[@"contents"];
            NSString *imageUrl = [self saveDefaultImageWithUrl:dict[@"user_picture"]];
            QQUserinfoModel *model = [QQUserinfoModel initWithDict:dict imageUrl:imageUrl];
            NSDictionary *userinfo = model.keyValues;
            [self saveDefaultWithData:userinfo plistName:@"userinfo.plist"];
            QQTabbarViewController *tab = [[QQTabbarViewController alloc]init];
            [self presentViewController:tab animated:YES completion:nil];
            
        }
        else{
            NSLog(@"%@",message);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}
-(NSString *)saveDefaultImageWithUrl:(NSString *)url{
    UIImage *imgFromUrl =[[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    NSLog(@"%@",imgFromUrl);
    // 本地沙盒目录
    NSString *path = NSHomeDirectory();
    // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
    NSString *imageFilePath = [path stringByAppendingPathComponent:@"Documents"];
     NSString *filepath = [imageFilePath stringByAppendingPathComponent:@"my.jpg"];
    // 将取得的图片写入本地的沙盒中，其中0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
    BOOL succuss = [UIImageJPEGRepresentation(imgFromUrl, 1) writeToFile:filepath atomically:YES];
    if(succuss)
        NSLog(@"写入本地成功");
    return filepath;
}
-(void)saveDefaultWithData:(NSDictionary *)data plistName:(NSString *)plistName{
    // 1.获得沙盒根路径
    NSString *home = NSHomeDirectory();
    // 2.document路径
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    
    NSString *filepath = [docPath stringByAppendingPathComponent:plistName];
    
    [data writeToFile:filepath atomically:YES];
    
}

@end
