//
//  DriverNearOrdersVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverNearOrdersVC.h"
#import "CallcarOrderTVCell.h"
#import "DriverOrderEditorView.h"//订单类型选择view
#import "CallCarOderDetailsVC.h"
@interface DriverNearOrdersVC ()<UITableViewDelegate,DriverOrderEditorViewDelegate, UITableViewDataSource, CarChooseViewDelegate, CallcarOrderTVCellDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)DriverOrderEditorView *OrderChooseView;

/**
 *选择器的背景色
 */
@property (nonatomic, strong)UIView *backImageView;
/**
 *选择器
 */
@property (nonatomic, strong)CarChooseView *ChooseView;

@end

@implementation DriverNearOrdersVC  {

    int ChooseType;//选择的类型 0是周边订单 1是按照车型选择订单
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + kFit(48),kScreen_widht, kScreen_heigth-kFit(48)-64) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"附近订单";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = MColor(238, 238, 238);
    self.OrderChooseView = [[DriverOrderEditorView alloc] initWithFrame:CGRectMake(0, 64, kScreen_widht, kFit(48))];
    _OrderChooseView.delegate = self;
    [self.view addSubview:_OrderChooseView];

    [self.tableView registerClass:[CallcarOrderTVCell class] forCellReuseIdentifier:@"CallcarOrderTVCell"];
    [self.view addSubview:self.tableView];

}

- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CallcarOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallcarOrderTVCell" forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CallCarOderDetailsVC *VC = [[CallCarOderDetailsVC alloc] init];
    VC.stateIndex = 1;
    [self.navigationController pushViewController:VC animated:YES];

    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(225);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return kFit(10);
    }else {
        return 0.01;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth)];
    view.backgroundColor = MColor(238, 238, 238);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kFit(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth)];
    view.backgroundColor = MColor(238, 238, 238);
    return view;
}

#pragma mark CallcarOrderTVCellDelegate

- (void)handleReceiveOrderBtn {
    
    CallCarOderDetailsVC *VC = [[CallCarOderDetailsVC alloc] init];
    VC.stateIndex = 0;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)handleOrderDetailsBtn {
    
    [self showAlert:@"测试数据不允许接单谢谢您的合作,再见!"];
    
}

#pragma mark  DriverOrderEditorViewDelegate
//周围订单
- (void)handleRegionChooseBtn {
    ChooseType = 0;
    [self ChooseCarClickEvent:(NSMutableArray *)@[@"附近", @"全部"]];
}
//选择车型
- (void)handleCarTypeChooseBtn {
    ChooseType =1;
    [self ChooseCarClickEvent:(NSMutableArray *)@[@"小货车", @"大货车", @"小飞机", @"大飞机", @"小火车", @"大火车"]];
}
#pragma mark  创建选择器

//创建一个存在于视图最上层的UIViewController
- (UIViewController *)appRootViewController{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)ChooseCarClickEvent:(NSMutableArray *)dataArray{//
    //xia面是弹窗的初始化
    UIViewController *topVC = [self appRootViewController];
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.3f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
        tapGesture.numberOfTapsRequired=1;
        [self.backImageView addGestureRecognizer:tapGesture];
    }
    [topVC.view addSubview:self.backImageView];
    self.ChooseView = [[CarChooseView alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200))];
    _ChooseView.delegate = self;
    _ChooseView.DataArray = dataArray;
    [topVC.view addSubview:_ChooseView];
    
    [UIView animateWithDuration:0.3 animations:^{
        _ChooseView.frame = CGRectMake(0, kScreen_heigth-kFit(200), kScreen_widht, kFit(200));
    }];
}
-(void)hiddenView {
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _ChooseView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
}
/**
 *确定
 */
- (void)ChooseCar:(NSString *)car {
    
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _ChooseView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    if (ChooseType == 0) {
        [_OrderChooseView ControlsAssignment:car type:ChooseType];
    }else {
        [_OrderChooseView ControlsAssignment:car type:ChooseType];
    }
    [self.tableView reloadData];
}
/**
 *取消
 */
- (void)deselect {
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _ChooseView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
}

//系统提示的弹出窗
- (void)timerFireMethod:(NSTimer*)theTimer {//弹出框
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}


@end
