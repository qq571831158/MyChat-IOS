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
#import "AFNetworking.h"
#import "QQUtils.h"
#define SDColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
@interface QQChatTableViewController ()
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSDictionary *userinfo;
@end

@implementation QQChatTableViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.friend.nickname;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"contacts_add_friend" highlightedImage:@"contacts_add_friend"];

    [self setView];
    [self loadUnReadMessage];
    [self setContent];
    [self initWebsocket];
    

}
-(void)more{
//    [self webSocket:_socket didCloseWithCode:1 reason:@"主动断臂" wasClean:YES];
        _socket.close;
}
-(void)loadUnReadMessage{
    _userinfo = [QQUtils getDefaultWithplistName:@"userinfo.plist" dir:@"userinfo"];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"username"] = _userinfo[@"username"];
    paras[@"sessionID"]= _userinfo[@"sessionID"];
    paras[@"fromUser"] = self.friend.username;
    NSLog(@"%@",paras);
    NSString *urlString = @"http://182.254.152.99:8080/MyChat1/message/getUnReadMessage";
//        NSString *urlString = @"http://localhost:8080/message/getUnReadMessage";
    [mgr POST:urlString parameters:paras success:^(AFHTTPRequestOperation
                                                                                          *operation , NSDictionary  *responseObject){
        NSLog(@"%@",responseObject);
        NSMutableArray *writeArray = [NSMutableArray array];
        NSMutableArray *readArray = [QQUtils getRecordWithName:[NSString stringWithFormat:@"%@.txt",self.friend.username]dir:@"chattingRecord"];
        [writeArray addObjectsFromArray:readArray];
        NSString *code = [responseObject valueForKey:@"code"];
        NSString *message = [responseObject valueForKey:@"message"];
        if ([code isEqualToString:@"S01"]) {
            [self updateStatus];
            NSArray *array = responseObject[@"contents"];
            for (int i=0; i<array.count; i++) {
                NSDictionary *dict = array[i];
                QQChatModel *model = [QQChatModel new];
                model.text = dict[@"message"];
                model.iconName = dict[@"fromUser"];
                model.messageType = @"1";
                [writeArray addObject:model];
            }
            [self saveChattingRecord:writeArray withWho:[NSString stringWithFormat:@"%@.txt",self.friend.username] dir:@"chattingRecord"];
            NSMutableArray *array2 = [QQUtils getRecordWithName:[NSString stringWithFormat:@"%@.txt",self.friend.username] dir:@"chattingRecord"];
            [self.dataArray addObjectsFromArray:array2];
            [self.tableView reloadData];
        }
        else{
            NSLog(@"%@",message);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];

}
-(void)updateStatus{
    _userinfo = [QQUtils getDefaultWithplistName:@"userinfo.plist" dir:@"userinfo"];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"username"] = _userinfo[@"username"];
    paras[@"sessionID"]= _userinfo[@"sessionID"];
    paras[@"fromUser"] = self.friend.username;
    NSLog(@"%@",paras);
        NSString *urlString = @"http://182.254.152.99:8080/MyChat1/message/getUnReadMessage";
//    NSString *urlString = @"http://localhost:8080/message/updateStatus";
    [mgr POST:urlString parameters:paras success:^(AFHTTPRequestOperation
                                                   *operation , NSDictionary  *responseObject){
        NSString *code = [responseObject valueForKey:@"code"];
        NSString *message = [responseObject valueForKey:@"message"];
        if ([code isEqualToString:@"S01"]) {
            NSLog(@"更新成功");
        }
        else{
            NSLog(@"%@",message);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}
-(void)setContent{
    NSMutableArray *array = [QQUtils getRecordWithName:[NSString stringWithFormat:@"%@.txt",self.friend.username]dir:@"chattingRecord"];
    
    if (array.count) {
        [self.dataArray addObjectsFromArray:array];
//        NSLog(@"%@",)
        [self.tableView reloadData];
        [self reloadAfterMessage:YES];
    }
    
}
- (void)initWebsocket{
     _userinfo = [QQUtils getDefaultWithplistName:@"userinfo.plist" dir:@"userinfo"];
    _userName = _userinfo[@"username"];
//        NSString *urlString = [NSString stringWithFormat:@"http://localhost:8080/websocket/%@",_userName];
    NSString *urlString = [NSString stringWithFormat:@"http://182.254.152.99:8080/MyChat1/websocket/%@",_userName];
    NSURL *url = [NSURL URLWithString:urlString];
    _socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:url]];
    _socket.delegate = self;
    [_socket open];
}
-(void)setView{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, 375, 620);
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
    model.messageType = @"1";
    model.text = message;
    model.iconName = self.friend.username;
    [self.dataArray addObject:model];
    [self.tableView reloadData];
    [self saveChattingRecord:self.dataArray withWho:[NSString stringWithFormat:@"%@.txt",self.friend.username] dir:@"chattingRecord"];
}


-(void)sendData:(NSString *)message{
//    NSMutableArray *array2 = [QQUtils getRecordWithName:[NSString stringWithFormat:@"%@.txt",self.friend.username] dir:@"chattingRecord"];
//    [self.dataArray addObjectsFromArray:array2];
    QQChatModel *model = [QQChatModel new];
    model.messageType = @"0";
    model.text = message;
    model.iconName = _userName;
    [self.dataArray addObject:model];
    [self.tableView reloadData];
    [self reloadAfterMessage:YES];
    [self saveChattingRecord:self.dataArray withWho:[NSString stringWithFormat:@"%@.txt",self.friend.username] dir:@"chattingRecord"];
    QQChatSendMessageModel *sendMsg = [QQChatSendMessageModel new];
    sendMsg.toUser = self.friend.username;
    sendMsg.fromUser = _userName;
    sendMsg.message = message;
    NSDictionary *dict = sendMsg.keyValues;
    [_socket send:[QQUtils dictionaryToJson:dict]];

}
#pragma -mark tableView datasoure
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)self.dataArray.count);
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
    [self loadData:[NSString stringWithFormat:@"%@",message]];
    [self reloadAfterMessage:YES];
    NSLog(@"%@",message);
}

- (void)reloadAfterMessage:(BOOL)show {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.self.dataArray.count > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:show];
        }
    });
}

-(void)saveChattingRecord:(NSMutableArray *)array withWho:(NSString *)username dir:(NSString *)dir{
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


@end
