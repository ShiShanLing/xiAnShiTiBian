//
//  CallCarOrderVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "CallCarOrderVC.h"
#import "LogisticsOrderTVCell.h"
#import "UnfoldOrderTVCell.h"
#import "GuestbookContentTVCell.h"
@interface CallCarOrderVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *DataArray;
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@property (nonatomic, strong)AppDelegate *delegate;
@property (readonly, strong, nonatomic)NSManagedObjectContext *managedObjectContext;

@end

@implementation CallCarOrderVC
- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedContext = delegate.managedObjectContext;
    }
    return _managedContext;
}

- (AppDelegate *)delegate {
    if (!_delegate) {
        _delegate = [[AppDelegate alloc] init];
    }
    return _delegate;
}

- (NSMutableArray *)DataArray {
    if (!_DataArray) {
        _DataArray = [NSMutableArray array];
    }
    return _DataArray;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [self performSelector:@selector(delayMethod)];
    
}
- (void)viewWillAppear:(BOOL)animated {

    [self RequestOrderListData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流订单";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = [UIColor redColor];
    [self creatTableView];
}

- (void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[LogisticsOrderTVCell class] forCellReuseIdentifier:@"LogisticsOrderTVCell"];
    [_tableView registerClass:[UnfoldOrderTVCell class] forCellReuseIdentifier:@"UnfoldOrderTVCell"];
    [_tableView registerClass:[GuestbookContentTVCell class] forCellReuseIdentifier:@"GuestbookContentTVCell"];
    [self.view addSubview:_tableView];
    
}
//显示网络加载指示器
- (void)indeterminateExample {
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
    
}
//隐藏网络加载指示器
- (void)delayMethod{
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
    
}
//字典转字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//请求接口
- (void)RequestOrderListData {
    
    [self performSelector:@selector(indeterminateExample)];
    
    NSString *url_Str = [NSString stringWithFormat:@"%@/cartask/api/findCarTasksByStoreId", kSHY_100];
    //买家自提
    //商家叫车
    NSDictionary *url_Dic = @{@"storeId":[UserDataSingleton mainSingleton].storeID};
    __block CallCarOrderVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:url_Str parameters:url_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSString *resultsStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        NSLog(@"responseObject%@",responseObject);
        if ([resultsStr isEqualToString:@"1"]) {
            //[VC showAlert:responseObject[@"msg"]];
            [VC AnalyticalSellerOrderListData:responseObject[@"data"]];
        }else {
            [VC showAlert:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self performSelector:@selector(delayMethod)];
        
        [VC showAlert:@"请求失败请重试" time:1.0];
    }];
}
//解析数据 -- 封装model
- (void)AnalyticalSellerOrderListData:(NSArray *)dataArray {
    [self.DataArray removeAllObjects];
    [self managedContext];
    for (NSDictionary *callCarOrderDic in dataArray) {
     
        NSEntityDescription *des = [NSEntityDescription entityForName:@"DriverCarOrderModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        DriverCarOrderModel *callCarOrderModel = [[DriverCarOrderModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        for (NSString *key in callCarOrderDic) {
            [callCarOrderModel setValue:callCarOrderDic[key] forKey:key];
        }
        [self.DataArray addObject:callCarOrderModel];
    }
    NSLog(@"DataArray%@", _DataArray);
    [self.tableView reloadData];
}
//返回上一界面
- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _DataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DriverCarOrderModel *orderListModel = self.DataArray[section];
    if (!orderListModel.beSelected) {
        return 3;
    }else {
        return 12;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int row ;
    DriverCarOrderModel *orderListModel = self.DataArray[indexPath.section];
    if (!orderListModel.beSelected) {
        row = 2;
    }else {
        row = 11;
    }
    if (indexPath.row == row) {
        UnfoldOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnfoldOrderTVCell" forIndexPath:indexPath];
        if ([orderListModel.state isEqualToString:@"1"]) {
            cell.stateLabel.text = @"订单发布失败";
        }else if ([orderListModel.state isEqualToString:@"2"]){
            cell.stateLabel.text = @"司机已接单";
            [cell.stateBtn setImage:[UIImage imageNamed:@"fwb"] forState:(UIControlStateNormal)];
        }else if ([orderListModel.state isEqualToString:@"3"]){
            cell.stateLabel.text = @"车主已经送达";
            [cell.stateBtn setImage:[UIImage imageNamed:@"fwb"] forState:(UIControlStateNormal)];
        }else if ([orderListModel.state isEqualToString:@"4"]) {
            cell.stateLabel.text = @"买家已收货";
            [cell.stateBtn setImage:[UIImage imageNamed:@"fwb"] forState:(UIControlStateNormal)];
        }
        [cell ChangeState:row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 9 || indexPath.row == 10) {
        GuestbookContentTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuestbookContentTVCell"];
        cell.contentLabel.text = orderListModel.leaveMessage;
        return cell;
    }else{
        LogisticsOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogisticsOrderTVCell" forIndexPath:indexPath];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *currentDateStr = [dateFormatter stringFromDate: orderListModel.createTime];
    [cell controlsAssignment:(int)indexPath.row dataArray:@[@[@"wd-wssj-wldd-ddbh",@"wd-wssj-wldd-djmz",@"wd-wssj-wldd-dh", @"wd-wssj-ckxq-mjmz", @"wd-wssj-wldd-dh", @"CCstartLocation", @"CCEndLocation", @"SelectModels", @"EstimateMoney"],@[@"订单号",@"商家名字", @"商家电话", @"买家名字", @"买家电话", @"始发地", @"目的地", @"叫车时间", @"预估价钱"],@[orderListModel.orderId,orderListModel.storeName, orderListModel.storeTel, orderListModel.buyerName, orderListModel.buyerMobile, orderListModel.daddress, orderListModel.address, currentDateStr, orderListModel.transportCharge]]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = orderListModel;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 9 || indexPath.row == 10) {
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:kScreen_widht tableView:tableView];
    }else {
        return kFit(47);
    }
}
//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DriverCarOrderModel *orderListModel = self.DataArray[indexPath.section];
    if (!orderListModel.beSelected) {
        orderListModel.beSelected = YES;
    }else {
        orderListModel.beSelected = NO;
    }
    self.DataArray[indexPath.section] = orderListModel;
    
    [self.tableView reloadData];

}



//页脚
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth)];
    view.backgroundColor = MColor(238, 238, 238);
    return view;
}
//页眉
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth)];
    view.backgroundColor = MColor(238, 238, 238);
    return view;

}
//页脚高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kFit(10);
}
//页眉高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return kFit(10);
    }else {
    
        return 0.01;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
