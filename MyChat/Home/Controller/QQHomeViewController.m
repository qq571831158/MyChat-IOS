//
//  QQHomeViewController.m
//  MyChat
//
//  Created by Apple on 2017/3/8.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQHomeViewController.h"
#import "QQHomeTableViewCell.h"
#import "SDAnalogDataGenerator.h"
#import "QQChatTableViewController.h"
@interface QQHomeViewController ()

@end

@implementation QQHomeViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = [QQHomeTableViewCell fixedHeight];
    [self setupDataWithCount:10];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (void)setupDataWithCount:(NSInteger)count
{
    for (int i = 0; i < count; i++) {
        QQHomeViewModel *model = [QQHomeViewModel new];
        model.imageName = [SDAnalogDataGenerator randomIconImageName];
        model.name = [SDAnalogDataGenerator randomName];
        model.message = [SDAnalogDataGenerator randomMessage];
        [self.dataArray addObject:model];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"status";
    QQHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[QQHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
        cell.model = self.dataArray[indexPath.row];
    return cell;
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QQHomeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    QQChatTableViewController *chat = [[QQChatTableViewController alloc]init];
    chat.model = cell.model;
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
}


@end
