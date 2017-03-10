//
//  QQChatTableViewController.m
//  MyChat
//
//  Created by Apple on 2017/3/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQChatTableViewController.h"
#import "QQChatTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "QQChatSendMessageModel.h"
#import "MJExtension.h"
#import "QQUtils.h"
#define SDColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
@interface QQChatTableViewController ()

@end

@implementation QQChatTableViewController

//- (void)viewWillAppear:(BOOL)animated{
//    
//    self.tabBarController.tabBar.hidden = YES;
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    
//    self.tabBarController.tabBar.hidden = NO;
//    
//}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setView];
    self.title = self.friend.nickname;
//    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/websocket/cheng"];
    NSURL *url = [NSURL URLWithString:@"http://182.254.152.99:8080/MyChat1/websocket/cheng"];
    _socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:url]];
    _socket.delegate = self;
    [_socket open];
}
-(void)setView{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, 375, 620);
//    CGFloat rgb = 240;
//    _tableView.backgroundColor = SDColor(rgb, rgb, rgb, 1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _text = [[UITextField alloc]init];
    _text.borderStyle = UITextBorderStyleRoundedRect;//设置边框样式，只有设置了才会显示边框样式
    _text.clearButtonMode = UITextFieldViewModeAlways;//输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    _text.returnKeyType = UIReturnKeySend;
    _text.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_text];
    _text.delegate = self;
    _text.sd_layout.topSpaceToView(_tableView,0)
    .bottomSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view, 0);

}
-(void)loadData:(NSString *)message{
    QQChatModel *model = [QQChatModel new];
    model.messageType = 1;
    model.text = message;
    model.iconName =@"1.jpg";
//    model.imageName = @"test0.jpg";
    [self.dataArray addObject:model];
    [self.tableView reloadData];
}

-(void)sendData:(NSString *)message{
    QQChatModel *model = [QQChatModel new];
    model.messageType = 0;
    model.text = message;
    model.iconName =@"2.jpg";
//    model.imageName = @"test2.jpg";
    [self.dataArray addObject:model];
    [self.tableView reloadData];
    QQChatSendMessageModel *sendMsg = [QQChatSendMessageModel new];
    sendMsg.toUser = @"piaoxuehua";
    sendMsg.fromUser = @"cheng";
    sendMsg.message = message;
    NSDictionary *dict = sendMsg.keyValues;
    [_socket send:[QQUtils dictionaryToJson:dict]];

}
#pragma -mark tableView datasoure
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"chatContents";
    QQChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[QQChatTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
      cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma -mark 键盘点击事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_text resignFirstResponder];
    NSString *input = self.text.text;
    [self sendData:input];
    _text.text = @"";
    return YES;
}

#pragma -mark SRWebSocket代理方法
-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"连接成功，可以登录");
}

-(void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"连接失败");
    
}
-(void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    [_socket send:@"断开"];
    NSLog(@"连接断开，情况socket");
}
-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"RECEIVE_MESSAGE"
//object:message];
    [self loadData:[NSString stringWithFormat:@"%@",message]];
    NSLog(@"%@",message);
}



@end
