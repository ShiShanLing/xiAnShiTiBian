//
//  MyDriverVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/10.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MyDriverVC.h"
#import "DriverStateTVCell.h"//司机信息展示
#import "DriverHistoryOrderTVCell.h"
#import "CallcarOrderTVCell.h"
#import "DriverDataShowVC.h"//司机信息展示界面
#import "DriverHistoryOrdersVC.h"
#import "DriverNearOrdersVC.h"
#import "CallCarOderDetailsVC.h"

#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3
static CLLocationCoordinate2D location2D;
static BOOL AllowPositioning;
@interface MyDriverVC ()<UITableViewDelegate, UITableViewDataSource, DriverStateTVCellDelegate, CallcarOrderTVCellDelegate,AMapLocationManagerDelegate>

/**
 *司机资料model
 */
@property (nonatomic, strong)DriverDataModel *driverDataModel;
/**
 *存储司机资料的数组
 */
@property (nonatomic, strong)NSMutableArray *driverDataArray;
/**
 *存储附近订单的数组
 */
@property (nonatomic, strong)NSMutableArray *OrderArray;
/**
 *
 */
@property (nonatomic, strong)UITableView *tableView;
//定位
@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation MyDriverVC

- (NSMutableArray *)OrderArray {
    if (!_OrderArray) {
        _OrderArray = [NSMutableArray array];
    }
    return _OrderArray;
}

- (NSMutableArray *)driverDataArray {
    if (!_driverDataArray) {
        _driverDataArray = [NSMutableArray array];
    }
    return _driverDataArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreen_widht, kScreen_heigth-64) style:(UITableViewStyleGrouped)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self performSelector:@selector(delayMethod)];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:NO];
    [self requestDriverData];
    [self configLocationManager];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我是司机";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = MColor(238, 238, 238);
    [self createTableView];
}

- (void)configLocationManager {
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
    
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];

    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }else if (error != nil
                  && (error.code == AMapLocationErrorReGeocodeFailed
                      || error.code == AMapLocationErrorTimeOut
                      || error.code == AMapLocationErrorCannotFindHost
                      || error.code == AMapLocationErrorBadURL
                      || error.code == AMapLocationErrorNotConnectedToInternet
                      || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation){
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }else{
            [self requestNearCarOrderData:location.coordinate];
        }
    }];
    
    
}

/**
 *请求司机数据
 */
- (void)requestDriverData{
    [self performSelector:@selector(indeterminateExample)];
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/carowner/api/diverMessage",kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"memberId"] = [UserDataSingleton mainSingleton].userID;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block MyDriverVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        [VC performSelector:@selector(delayMethod)];
        if ([resultStr isEqualToString:@"1"]) {
            NSDictionary *DicData = responseObject[@"data"][0];
            [VC parsingDriverData:DicData];
        }else {
            [VC showAlert:@"获取失败,请重试"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"数据请求失败,请重试!" time:1.0];
        [VC delayMethod];
    }];
}
/**
 *解析司机数据
 */
- (void)parsingDriverData:(NSDictionary *)driverData {
    [self.driverDataArray removeAllObjects];
    [self managedContext];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"DriverDataModel" inManagedObjectContext:self.managedContext];
    //根据描述 创建实体对象
    DriverDataModel *driverModel = [[DriverDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
    for (NSString *key in driverData) {
        [driverModel setValue:driverData[key] forKey:key];
    }
    [self.driverDataArray addObject:driverModel];
    self.driverDataModel = driverModel;
    [self.tableView reloadData];
}




/**
 *请求附近叫车订单
 */
- (void)requestNearCarOrderData:(CLLocationCoordinate2D)location {
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/findCarTasks", kSHY_100];
    
    NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
    URL_DIC[@"longitude"] = [NSString stringWithFormat:@"%f", location.longitude];
    URL_DIC[@"latitude"] = [NSString stringWithFormat:@"%f", location.latitude];
    URL_DIC[@"count"] = @"10";
    NSLog(@"URL_DIC%@", URL_DIC);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block MyDriverVC *VC = self;
    [session POST:URL_Str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求附近叫车订单%@", responseObject);
        [VC performSelector:@selector(delayMethod)];
        NSString *resultStr = [NSString stringWithFormat:@"%@",responseObject[@"result"]];
        if ([resultStr isEqualToString:@"0"]) {
            [VC showAlert:@"获取订单失败请重试"];
        }else if([resultStr isEqualToString:@"2"]){
            [VC showAlert:@"暂时没有订单"];
        }else{
            [VC parsingNearCarOrderData:responseObject[@"data"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"订单信息获取失败,请稍后重试!"];
    }];
}
/**
 *解析附近叫车订单
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

- (void)createTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [_tableView registerClass:[DriverStateTVCell class] forCellReuseIdentifier:@"DriverStateTVCell"];
    [_tableView registerClass:[DriverHistoryOrderTVCell class] forCellReuseIdentifier:@"DriverHistoryOrderTVCell"];
    [_tableView registerClass:[CallcarOrderTVCell class] forCellReuseIdentifier:@"CallcarOrderTVCell"];
    [self.view addSubview:_tableView];
}

//返回上一界面
- (void)handleReturn {
    UINavigationController *navigationVC = self.navigationController;
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    //遍历导航控制器中的控制器
    for (UIViewController *vc in navigationVC.viewControllers) {
        if ([vc isKindOfClass:[MyViewController class]]) {
            [viewControllers addObject:vc];
            break;
        }
    }
    //把控制器重新添加到导航控制器
    [navigationVC setViewControllers:viewControllers animated:YES];
    [navigationVC popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

        if (self.driverDataArray.count == 0) {
            
            return 0;
        } else {
            
            return 3;
        }
  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if(section == 1) {
        return 1;
    }else {
        return _OrderArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DriverStateTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DriverStateTVCell" forIndexPath:indexPath];
        if (self.driverDataArray.count == 0) {
            
        }else {
            cell.model = self.driverDataArray[0];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 1){
        DriverHistoryOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DriverHistoryOrderTVCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
            cell.titleLabel.text = @"历史订单";
        return cell;
    }else {
        CallcarOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallcarOrderTVCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        if (self.OrderArray.count == 0) {
        }else {
            cell.model = self.OrderArray[indexPath.row];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DriverDataShowVC *VC = [[DriverDataShowVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //跳转至附近订单
            DriverNearOrdersVC *VC = [[DriverNearOrdersVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        if (indexPath.row == 1) {
            //跳转至历史订单
            DriverHistoryOrdersVC *VC = [[DriverHistoryOrdersVC alloc] init];
            VC.driverId = self.driverDataModel.carOwnerId;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else {
        DriverCarOrderModel *model = self.OrderArray[indexPath.row];
        CallCarOderDetailsVC *VC = [[CallCarOderDetailsVC alloc] init];
        VC.stateIndex = 0;
        VC.carOwnerId = self.driverDataModel.carOwnerId;;
        VC.dricerOrderId = model.dricerOrderId;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kFit(150);
    }else if(indexPath.section == 1){
        return kFit(47);
    }else {
        return kFit(225);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, 20)];
    view.backgroundColor = MColor(238, 238, 238);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, 20)];
    view.backgroundColor = MColor(238, 238, 238);
    return view;
}

#pragma mark  CallcarOrderTVCellDelegate
//接单按钮
- (void)handleReceiveOrderBtn:(UIButton *)sender {
    [self performSelector:@selector(indeterminateExample)];
    DriverCarOrderModel *model = self.OrderArray[sender.tag];
    NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/grabOrder", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"id"] = model.dricerOrderId;
    URL_Dic[@"carOwnerId"] = _driverDataModel.carOwnerId;
    __block MyDriverVC *VC = self;
    NSLog(@"URL_Dic%@   URL_Str%@",URL_Dic, URL_Str);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
    //    NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
     //   NSLog(@"responseObject%@", responseObject);
        if ([resultStr isEqualToString:@"1"]) {
            [VC.OrderArray removeObjectAtIndex:sender.tag];
            [VC.tableView reloadData];
            [VC showAlert:responseObject[@"msg"]];
        }else {
            if ([responseObject[@"msg"] isEqualToString:@"抢单失败，存在未完结订单"]) {
                UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"抢单失败，存在未完结订单" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"去查看" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                    CallCarOderDetailsVC *DetailsVC = [[CallCarOderDetailsVC alloc] init];
                    DetailsVC.carOwnerId = VC.driverDataModel.carOwnerId;
                    //NSLog(@"handleCheckOrderBtn%@", self.driverDataModel.carOwnerId);
                    DetailsVC.location2D = location2D;
                    DetailsVC.stateIndex = 1;
                    [self.navigationController pushViewController:DetailsVC animated:YES];
                }];
                
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                }];
                // 3.将“取消”和“确定”按钮加入到弹框控制器中
                [alertV addAction:cancle];
                [alertV addAction:confirm];
                // 4.控制器 展示弹框控件，完成时不做操作
                [self presentViewController:alertV animated:YES completion:^{
                    nil;
                }];

            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"数据请求失败请重试"];
    }];
}
//订单详情
- (void)handleOrderDetailsBtn:(UIButton *)sender {

    
}
#pragma mark DriverStateTVCellDelegate
/**
 *下线按钮
 */
- (void)handleOfflineBtn {
    
}
/**
 *查看那正在进行的订单
 */
- (void)handleCheckOrderBtn {
    CallCarOderDetailsVC *VC = [[CallCarOderDetailsVC alloc] init];
    VC.carOwnerId = self.driverDataModel.carOwnerId;
    NSLog(@"handleCheckOrderBtn%@", self.driverDataModel.carOwnerId);
    VC.location2D = location2D;
    VC.stateIndex = 1;
    [self.navigationController pushViewController:VC animated:YES];

}

//系统提示的弹出窗
- (void)timerFireMethod:(NSTimer*)theTimer {//弹出框
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:2 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    
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






@end
