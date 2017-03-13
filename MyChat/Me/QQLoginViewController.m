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
#import "QQUtils.h"
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
            NSString *username = [NSString stringWithFormat:@"%@.jpg",dict[@"username"]];
            [QQUtils saveDefaultImageWithUrl:dict[@"user_picture"] imageName:username imagePath:@"userinfo"];
            QQUserinfoModel *model = [QQUserinfoModel initWithDict:dict];
            NSDictionary *userinfo = model.keyValues;
            [QQUtils saveDefaultWithData:userinfo plistName:@"userinfo.plist" dir:@"userinfo"];
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




@end
