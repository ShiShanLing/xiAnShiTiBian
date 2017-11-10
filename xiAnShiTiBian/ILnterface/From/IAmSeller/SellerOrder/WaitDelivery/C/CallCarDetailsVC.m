//
//  CallCarDetailsVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "CallCarDetailsVC.h"
#import "LogisticsOrderTVCell.h"
#import "UnfoldOrderTVCell.h"
#import "GuestbookContentTVCell.h"
#import "AlreadyReceivingOrderTVCell.h"//司机已接单
#import "NoReceivingOrderTVCell.h"//司机未接单
@interface CallCarDetailsVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *DataArray;
@end

@implementation CallCarDetailsVC {

    int orderState;

}

- (NSMutableArray *)DataArray {
    if (!_DataArray) {
        _DataArray = [NSMutableArray array];
    }
    return _DataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    orderState = 0;
    NSMutableArray *dataArray = [NSMutableArray array];
        [dataArray addObject:@"0"];
    self.DataArray = [NSMutableArray arrayWithArray:dataArray];
    self.navigationItem.title = @"物流订单";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = [UIColor redColor];
    [self creatTableView];
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_tableView registerClass:[LogisticsOrderTVCell class] forCellReuseIdentifier:@"LogisticsOrderTVCell"];
    [_tableView registerClass:[UnfoldOrderTVCell class] forCellReuseIdentifier:@"UnfoldOrderTVCell"];
    [_tableView registerClass:[GuestbookContentTVCell class] forCellReuseIdentifier:@"GuestbookContentTVCell"];
    [_tableView registerClass:[AlreadyReceivingOrderTVCell class] forCellReuseIdentifier:@"AlreadyReceivingOrderTVCell"];
    [_tableView registerClass:[NoReceivingOrderTVCell class] forCellReuseIdentifier:@"NoReceivingOrderTVCell"];
    [self.view addSubview:_tableView];
}

- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _DataArray.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else {
    NSString *str = _DataArray[section-1];
    if ([str isEqualToString:@"0"]) {
        return 3;
    }else {
        return 12;
    }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (orderState == 0) {
            NoReceivingOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoReceivingOrderTVCell" forIndexPath:indexPath];
            return cell;
        }else {
        AlreadyReceivingOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlreadyReceivingOrderTVCell" forIndexPath:indexPath];
        return cell;
        }
    }else {
        int row;
    NSString *str = _DataArray[indexPath.section-1];
    if ([str isEqualToString:@"0"]) {
        row = 2;
    }else {
        row = 11;
    }
    if (indexPath.row == row) {
        UnfoldOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnfoldOrderTVCell" forIndexPath:indexPath];
        [cell ChangeState:row-3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 9 || indexPath.row == 10) {
        GuestbookContentTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuestbookContentTVCell"];
        cell.contentLabel.text = @"11111111111111111111111111111111111111111";
        return cell;
    }else{
        LogisticsOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogisticsOrderTVCell" forIndexPath:indexPath];
        [cell controlsAssignment:(int)indexPath.row dataArray:@[@[@"wd-wssj-wldd-djmz",@"wd-wssj-wldd-dh", @"wd-wssj-ckxq-mjmz", @"wd-wssj-wldd-dh", @"CCstartLocation", @"CCEndLocation", @"SelectModels", @"EstimateMoney"],@[@"用车时间",@"商家名字", @"商家电话", @"买家名字", @"买家电话", @"始发地", @"目的地", @"车辆选择", @"预估价钱"]]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return kFit(179);
    }else {
    
    if (indexPath.row == 9 || indexPath.row == 10) {
        return [self cellHeightForIndexPath:indexPath cellContentViewWidth:kScreen_widht tableView:tableView];
    }else {
        return kFit(47);
        }
    }
}
//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (orderState == 0) {
        orderState =1;
    }else {
        orderState =0;
    }
    
    
    if (indexPath.row == 2 || indexPath.row == 11) {
        
        NSString *stateStr = _DataArray[indexPath.section-1];
    if ([stateStr isEqualToString:@"0"]) {
        _DataArray[indexPath.section-1] = @"1";
    }
    
    if ([stateStr isEqualToString:@"1"]) {
        _DataArray[indexPath.section-1] = @"0";
    }
    }
    [self.tableView reloadData];
    
}



@end
