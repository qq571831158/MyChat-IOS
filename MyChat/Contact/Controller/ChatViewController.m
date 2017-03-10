//
//  ChatViewController.m
//  MyChat
//
//  Created by Apple on 2017/3/8.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ChatViewController.h"
#import "UIBarButtonItem+Extension.h"
@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.name;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"contacts_add_friend" highlightedImage:@"contacts_add_friend"];
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 0, 375, 570);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.tableView];
    self.textInput = [[UITextField alloc]init];
    _textInput.frame = CGRectMake(0,570,375,67);
    _textInput.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textInput];
}

-(void)more{
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"message";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"sada";
    return cell;
}


@end
