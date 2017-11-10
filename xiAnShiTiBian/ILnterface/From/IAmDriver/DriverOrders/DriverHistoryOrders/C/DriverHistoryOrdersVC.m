
//
//  DriverHistoryOrdersVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverHistoryOrdersVC.h"
#import "CallcarOrderTVCell.h"
#import "CallCarOderDetailsVC.h"

@interface DriverHistoryOrdersVC ()<UITableViewDelegate, UITableViewDataSource, CallcarOrderTVCellDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *OrderArray;

@end

@implementation DriverHistoryOrdersVC

- (NSMutableArray *)OrderArray {
    if (!_OrderArray) {
        _OrderArray = [NSMutableArray array];
    }
    return _OrderArray;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0,kScreen_widht, kScreen_heigth) style:(UITableViewStyleGrouped)];
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
    [self findHistoryCarTaskByCarOwnerId];
    self.navigationItem.title = @"历史订单";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = MColor(238, 238, 238);
    [self.tableView registerClass:[CallcarOrderTVCell class] forCellReuseIdentifier:@"CallcarOrderTVCell"];
    [self.view addSubview:self.tableView];
    
}
//获取历史订单列表
- (void)findHistoryCarTaskByCarOwnerId {
    [self performSelector:@selector(indeterminateExample)];
    NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/findHistoryCarTaskByCarOwnerId",kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"carOwnerId"] = self.driverId;
    AFHTTPSessionManager *session  = [AFHTTPSessionManager manager];
    __block DriverHistoryOrdersVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [VC performSelector:@selector(delayMethod)];
        NSString *resultStr = [NSString stringWithFormat:@"%@",responseObject[@"result"]];
        if ([resultStr isEqualToString:@"0"]) {
            [VC showAlert:@"获取订单失败请重试"];
        }else if([resultStr isEqualToString:@"2"]){
            [VC showAlert:@"暂时没有订单"];
        }else{
            [VC showAlert:responseObject[@"msg"]];
            [VC parsingNearCarOrderData:responseObject[@"data"]];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC delayMethod];
        [VC showAlert:@"请求失败请重试" time:1.0];
    }];

}

/**
 *解析历史叫车订单
 */
- (void)parsingNearCarOrderData:(NSArray *)orderArr {
    [self.OrderArray removeAllObjects];
    for (NSDictionary *orderDic in orderArr) {
        
        NSEntityDescription *des = [NSEntityDescription entityForName:@"DriverCarOrderModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        DriverCarOrderModel *driverOrderModel = [[DriverCarOrderModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        for (NSString *key in orderDic) {
            [driverOrderModel setValue:orderDic[key] forKey:key];
        }
        [self.OrderArray addObject:driverOrderModel];
    }
    NSLog(@"OrderArray%@", _OrderArray);
    [self.tableView reloadData];
}

- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.OrderArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CallcarOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallcarOrderTVCell" forIndexPath:indexPath];
    [cell completedOrder];
    cell.model = self.OrderArray[indexPath.section];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CallCarOderDetailsVC *VC = [[CallCarOderDetailsVC alloc] init];
    
    VC.stateIndex = 2;
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
//系统提示的弹出窗
- (void)timerFireMethod:(NSTimer*)theTimer {//弹出框
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}

//网络加载指示器
- (void)indeterminateExample {
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
    
}

- (void)delayMethod{
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
    
}
@end
