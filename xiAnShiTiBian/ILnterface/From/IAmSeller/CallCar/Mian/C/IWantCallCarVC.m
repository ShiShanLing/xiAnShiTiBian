//
//  IWantCallCarVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/21.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "IWantCallCarVC.h"
#import "CallCarTimeChooseTVCell.h"
#import "CallCarPositionTVCell.h"
#import "CallCarServiceTVCell.h"
#import "CallCarPriceTVCell.h"
#import "NextStepTVCell.h"
#import "CarChooseView.h"//车型选择
#import "ConfirmCallCarOrderVC.h"//确定叫车订单界面
#import "CallCarTimeChooseVC.h"//选择叫车时间界面

#import "SellerShipmentsAddVC.h"
#import "TodriverLeaveWordVC.h"//给司机留言界面
@interface IWantCallCarVC ()<UITableViewDelegate, UITableViewDataSource, CallCarTimeChooseVCDelegate, CarChooseViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
/**
 *汽车型号选择 Fahrzeugmodell
 */
@property (nonatomic, strong) CarChooseView *FPickerView;
/**
 *选择的当前车型str
 */
@property (nonatomic, strong)NSMutableDictionary *ChooseCarDic;

@property (nonatomic, strong)NSMutableArray *VehicleTypeArray;//模拟真实数据的车型
/**
 *车型选择时的背景色
 */
@property (nonatomic, strong)UIView *backImageView;
/**
 *叫车时间选择界面
 */
@property (nonatomic, strong)CallCarTimeChooseVC *CallCarTimeChooseView;
/**
 *存储叫车时间
 */
@property (nonatomic, strong)NSString *callCarTime;
/**
 *订单需不需要附加服务
 */
@property (nonatomic, strong)NSString *AdditionalServicesStr;
/**
 *给车主留言
 */
@property (nonatomic, strong)NSString *GiveCarAdvocateMessageStr;

@end

@implementation IWantCallCarVC


-(void)setModel:(SellerOrderListModel *)model {

    _model = model;
    [self.tableView reloadData];

}
- (NSMutableDictionary *)ChooseCarDic {
    if (!_ChooseCarDic) {
        _ChooseCarDic = [NSMutableDictionary dictionary];
    }
    return _ChooseCarDic;
}
- (NSMutableArray *)VehicleTypeArray {
    if (!_VehicleTypeArray) {
        _VehicleTypeArray = [NSMutableArray array];
    }
    return _VehicleTypeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.AdditionalServicesStr = @"不需要";
    self.navigationItem.title = @"叫车界面";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    [self createTableView];
}

- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UITableView 的方法


- (void)createTableView {
    
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[CallCarTimeChooseTVCell class] forCellReuseIdentifier:@"CallCarTimeChooseTVCell"];
    [_tableView registerClass:[CallCarPositionTVCell class] forCellReuseIdentifier:@"CallCarPositionTVCell"];
    [_tableView registerClass:[CallCarServiceTVCell class] forCellReuseIdentifier:@"CallCarServiceTVCell"];
    [_tableView registerClass:[CallCarPriceTVCell class] forCellReuseIdentifier:@"CallCarPriceTVCell"];
    [_tableView registerClass:[NextStepTVCell class] forCellReuseIdentifier:@"NextStepTVCell"];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 3 || section == 4||section == 0||section == 2) {
        return 1;
    }else {
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        CallCarTimeChooseTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallCarTimeChooseTVCell" forIndexPath:indexPath];
        [cell ControlsAssignment:_ChooseCarDic];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section ==1){
        CallCarPositionTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallCarPositionTVCell" forIndexPath:indexPath];
        NSArray *DataArray = @[@[@"CCstartLocation", [self buyersShippingAddress], [self buyersPhone]],@[@"CCEndLocation", [self defaultShippingAddress], [SellerDataSingleton mainSingleton].sellerDataModel.storeTel]];
        [cell ControlsAssignment:DataArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 2){
        CallCarServiceTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallCarServiceTVCell" forIndexPath:indexPath];
        
        [cell ControlsAssignment:self.GiveCarAdvocateMessageStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 3){
        CallCarPriceTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallCarPriceTVCell" forIndexPath:indexPath];
        [cell CallCarPrice:_model.shippingFee];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        NextStepTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NextStepTVCell" forIndexPath:indexPath];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (NSString *)buyersPhone {

    NSDictionary *addDic = _model.address;
    return  addDic[@"mobPhone"];
}

- (NSString *)buyersShippingAddress {
   
    NSDictionary *addDic = _model.address;
    NSString *addStr = [NSString stringWithFormat:@"%@ %@",addDic[@"areaInfo"], addDic[@"address"]];
    return addStr;
}
- (NSString *)defaultShippingAddress {
    NSString *Address = @" ";
    Address = [NSString stringWithFormat:@"%@ %@", [SellerDataSingleton mainSingleton].sellerDataModel.areaInfo, [SellerDataSingleton mainSingleton].sellerDataModel.storeAddress];
    
    return Address;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self indeterminateExample];
        NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/selectCarCost", kSHY_100];
        __block IWantCallCarVC *VC = self;
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session GET:URL_Str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"downloadProgress%@", downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [VC delayMethod];
            if ([[NSString stringWithFormat:@"%@", responseObject[@"result"] ] isEqualToString:@"1"]) {
                self.VehicleTypeArray = [NSMutableArray arrayWithArray:responseObject[@"data"]];
                [self ChooseCarClickEvent];
            }else {
                [VC showAlert:@"车辆信息获取失败,请重试"];
            }
            NSLog(@"responseObject%@", responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [VC delayMethod];
            [VC showAlert:@"网络超时请重试"];
        }];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            SellerShipmentsAddVC *VC = [[SellerShipmentsAddVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    if (indexPath.section == 2) {
            TodriverLeaveWordVC *VC = [[TodriverLeaveWordVC alloc] init];
        VC.leaveMessageBlock = ^(NSString *str) {
            NSLog(@"leaveMessageBlock%@", str);
            self.GiveCarAdvocateMessageStr = str;
        
        };
            [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.section == 4) {
        [self requestGenerateCallCarOrders];
    }
}
//生成叫车订单
- (void)requestGenerateCallCarOrders {
    [self performSelector:@selector(indeterminateExample)];
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/addCarTask", kSHY_100];
    NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
    URL_DIC[@"orderId"] = _model.orderId;
    URL_DIC[@"storeId"] = _model.storeId;
    URL_DIC[@"transportCharge"] = _model.orderAmount;
    if (self.GiveCarAdvocateMessageStr.length == 0) {
        URL_DIC[@"description"] = @" ";
    }else {
        URL_DIC[@"description"] = self.GiveCarAdvocateMessageStr;
    }
    NSLog(@"requestGenerateCallCarOrders%@",URL_DIC);
    __block IWantCallCarVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:URL_Str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
      //  [VC performSelector:@selector(delayMethod)];
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC showAlert:@"提交成功"];
            [VC.navigationController popViewControllerAnimated:YES];
        }else {
            [VC showAlert:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"网络链接失败"];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
           return kFit(47);
    }else if(indexPath.section == 1 ||indexPath.section == 3){
        return kFit(75);
    }else if(indexPath.section == 2){
        return kFit(47);
    }else {
        return kFit(100);
    }
}
//section头部间距
- (CGFloat)tableView:(UITableView* )tableView heightForHeaderInSection:(NSInteger)section {
    return kFit(0.1);//section头部高度
}
//section底部间距
- (CGFloat)tableView:(UITableView* )tableView heightForFooterInSection:(NSInteger)section {
    return kFit(10);
}
//section底部视图
- (UIView *)tableView:(UITableView* )tableView viewForFooterInSection:(NSInteger)section {
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark -- 下面是车辆选择的 方法

//创建一个存在于视图最上层的UIViewController
- (UIViewController *)appRootViewController{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)ChooseCarClickEvent{//
    
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
    
    self.FPickerView = [[CarChooseView alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200))];
    _FPickerView.delegate = self;
    _FPickerView.DataArray = self.VehicleTypeArray;
    [topVC.view addSubview:_FPickerView];
    
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth-kFit(200), kScreen_widht, kFit(200));
    }];
    
}
-(void)hiddenView {
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    [UIView animateWithDuration:0.3 animations:^{
        _CallCarTimeChooseView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
}
/**
 *确定
 */
- (void)ChooseCar:(NSDictionary *)carDic {
    
    self.ChooseCarDic = [NSMutableDictionary dictionaryWithDictionary:carDic];
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    [self.tableView reloadData];
}
/**
 *取消
 */
- (void)deselect {
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    [self.tableView reloadData];
}

#pragma mark -- 下面是叫车时间的选择方法
/*
- (void)ChooseTimeClickEvent {
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
    
    self.CallCarTimeChooseView = [[CallCarTimeChooseVC alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200))];
    _CallCarTimeChooseView.delegate = self;
    _CallCarTimeChooseView.DataArray = _FahrzeugmodellArray;
    [topVC.view addSubview:_CallCarTimeChooseView];
    
    [UIView animateWithDuration:0.3 animations:^{
        _CallCarTimeChooseView.frame = CGRectMake(0, kScreen_heigth-kFit(200), kScreen_widht, kFit(200));
    }];

}
 */
- (void)ChooseCallCarTime:(NSString *)car {

    _callCarTime = car;
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _CallCarTimeChooseView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    [self.tableView reloadData];
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


//网络加载指示器
- (void)indeterminateExample {
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
    
}

- (void)delayMethod{
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
    
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
