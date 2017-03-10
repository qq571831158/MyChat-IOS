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
@interface QQContactViewController ()
@property(nonatomic,strong)NSArray *friendArray;
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
    [self setupRefresh];
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
    paras[@"username"] =@"cheng";
    [mgr GET:@"http://182.254.152.99:8080/MyChat1/user/friend" parameters:paras success:^(AFHTTPRequestOperation *operation , NSDictionary *responseObject){
        NSArray *resultArray = responseObject[@"contents"];
        self.friendArray = [QQFriendModel objectArrayWithKeyValuesArray:resultArray];
        [self.tableView reloadData];
        [control endRefreshing];
    }failure:^(AFHTTPRequestOperation *operation ,NSError *error){
       [control endRefreshing];
        NSLog(@"%@",error);
    }];

}
#pragma mark -Tableview Data Source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QQFriendModel *friend = self.friendArray[indexPath.row];
    static NSString *ID = @"QQContacts";
    ContactViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ContactViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.iconImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:friend.user_picture]]];
    cell.nameLabel.text = friend.nickname;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QQFriendModel *friend = self.friendArray[indexPath.row];
    ChatViewController *chat = [[ChatViewController alloc]init];
    chat.name = friend.nickname;
    [self.navigationController pushViewController:chat animated:YES];
}
@end
