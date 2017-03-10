//
//  QQChatTableViewController.h
//  MyChat
//
//  Created by Apple on 2017/3/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRWebSocket.h"
#import "QQHomeViewModel.h"
@interface QQChatTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITextField *text;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QQHomeViewModel *model;
@property(nonatomic,strong) SRWebSocket *socket;
@end
