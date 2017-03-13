//
//  QQContactViewController.m
//  MyChat
//
//  Created by Apple on 2017/3/8.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQContactViewController.h"
#import "ContactViewCell.h"
#import "ChatViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "QQFriendModel.h"
#import "QQChatFriendInfoViewController.h"
#import "QQUtils.h"
@interface QQContactViewController ()
@property(nonatomic,strong)NSArray *friendArray;
@property(nonatomic,strong)NSArray *array;
@end

@implementation QQContactViewController
-(NSArray *)friendArray{
    if(!_friendArray){
        self.friendArray = [NSArray array];
    }
    return _friendArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"contacts_add_friend" highlightedImage:@"contacts_add_friend"];
    if(![QQUtils isFileExist:@"friendinfo.txt" dir:@"friendinfo"]){
            [self setupRefresh];
        //[self getFriendInfo];
    }
    else{
            self.array = [QQUtils getRecordWithName:@"friendinfo.txt" dir:@"friendinfo"];
            [self.tableView reloadData];
    }
    self.tableView.rowHeight = [ContactViewCell fixedHeight];
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
}

-(void)more{
    NSLog(@"右上角被点击");
}

-(void)setupRefresh{
    //1添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(getFriendInfo:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    //2.进入刷新状态(只转圈，不会触发事件)
    [control beginRefreshing];
    
    [self getFriendInfo:control];
    
}

-(void)getFriendInfo:(UIRefreshControl *)control{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    NSDictionary *userinfo = [QQUtils getDefaultWithplistName:@"userinfo.plist" dir:@"userinfo"];
    paras[@"username"] = userinfo[@"username"];
    NSString *url = @"http://182.254.152.99:8080/MyChat1/user/friend";
//    NSString *url = @"http://localhost:8080/user/friend";
    [mgr GET:url parameters:paras success:^(AFHTTPRequestOperation *operation , NSDictionary *responseObject){
        NSArray *resultArray = responseObject[@"contents"];
        self.friendArray = [QQFriendModel objectArrayWithKeyValuesArray:resultArray];
        for (int i=0; i<self.friendArray.count; i++) {
            QQFriendModel *friend = self.friendArray[i];
            NSString *imageName = [NSString stringWithFormat:@"%@.jpg",friend.username];
            [QQUtils saveDefaultImageWithUrl:friend.user_picture imageName:imageName imagePath:@"friendinfo"];
        }
        [QQUtils saveChattingRecord:self.friendArray withWho:@"friendinfo.txt" dir:@"friendinfo"];
        self.array = [QQUtils getRecordWithName:@"friendinfo.txt" dir:@"friendinfo"];
        [self.tableView reloadData];
        [control endRefreshing];
    }failure:^(AFHTTPRequestOperation *operation ,NSError *error){
       [control endRefreshing];
        NSLog(@"%@",error);
    }];

}
#pragma mark -Tableview Data Source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QQFriendModel *friend = self.array[indexPath.row];
    static NSString *ID = @"QQContacts";
    ContactViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ContactViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSString *user_picture = [QQUtils getDefaultImageWithName:friend.username imagePath:@"friendinfo"];
    NSString *url=[NSString stringWithFormat:@"%@.jpg",user_picture];
    cell.iconImageView.image = [[UIImage alloc]initWithContentsOfFile:url];
    cell.nameLabel.text = friend.nickname;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QQFriendModel *friend = self.array[indexPath.row];
    QQChatFriendInfoViewController *chat = [[QQChatFriendInfoViewController alloc]init];
    chat.friend = friend;
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
}
@end
