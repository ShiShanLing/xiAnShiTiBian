//
//  MainControlVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/14.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MainControlVC.h"
#import "StoreHeadView.h"
#import "MainTouchTableTableView.h"
#import "MYSegmentView.h"
#import "MapStoreListVC.h"
#import "MapStoreTableView.h"
#define headViewHeight          kScreen_widht

@interface MainControlVC ()<UITableViewDelegate,UITableViewDataSource>
/**
 *
 */
@property (nonatomic, strong)MapStoreTableView *tableView;
@end

@implementation MainControlVC
- (MapStoreTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MapStoreTableView alloc] initWithFrame:CGRectMake(0, 100, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return  _tableView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter * BanSliding = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [BanSliding addObserver:self selector:@selector(noticeBanSliding:) name:@"BanSliding" object:nil];
    NSNotificationCenter * allowSliding = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [allowSliding addObserver:self selector:@selector(noticeAllowSliding:) name:@"allowSliding" object:nil];
    
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"店铺界面";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)noticeBanSliding:(NSNotificationCenter *)center{
    
    self.tableView.scrollEnabled = NO;
    
}
- (void)noticeAllowSliding:(NSNotificationCenter *)center{
    
    self.tableView.scrollEnabled = YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tableView:didSelectRowAtIndexPath:");
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat contentY = scrollView.contentOffset.y;
    
    CGFloat Y = scrollView.frame.origin.y;
    if (Y <= 0 && contentY< 0) {
        NSNotification * notice = [NSNotification notificationWithName:@"BanSliding" object:nil userInfo:@{@"1":@"关闭"}];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
    if (Y >= 0 && contentY< 0) {
        
        NSNotification * notice = [NSNotification notificationWithName:@"BanSliding" object:nil userInfo:@{@"1":@"关闭"}];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
    NSLog(@"Y%f contentY%f",Y,contentY);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 0, kScreen_widht, 400);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 100;
}




@end
