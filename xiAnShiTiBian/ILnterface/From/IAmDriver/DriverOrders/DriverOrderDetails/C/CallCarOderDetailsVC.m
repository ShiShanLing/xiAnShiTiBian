//
//  CallCarOderDetailsVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/23.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "CallCarOderDetailsVC.h"
#import "LogisticsOrderTVCell.h"
#import "GuestbookContentTVCell.h"
#import "DriverTheROTVCell.h"   //正在运行的订单状态显示cell
#import "DriverHRDTVCell.h"     //历史订单状态显示cell
#import "NoAcceptOrderTVCell.h" //未被司机接收的订单
#import "MyDriverVC.h"
@interface CallCarOderDetailsVC ()<UITableViewDelegate, UITableViewDataSource, DriverTheROTVCellDelegate,AMapNaviCompositeManagerDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *orderArray;

@property (nonatomic, strong) AMapNaviCompositeManager *compositeManager;
@end

@implementation CallCarOderDetailsVC
- (AMapNaviCompositeManager *)compositeManager {
    if (!_compositeManager) {
        _compositeManager = [[AMapNaviCompositeManager alloc] init];  // 初始化
        _compositeManager.delegate = self;  // 如果需要使用AMapNaviCompositeManagerDelegate的相关回调（如自定义语音、获取实时位置等），需要设置delegate
    }
    return _compositeManager;
}
- (NSMutableArray *)orderArray {
    if (!_orderArray) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0,kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
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
    
    if (self.stateIndex == 1) {
        self.navigationItem.title = @"正在运行的订单";
        [self requestNearCarOrderData];
    }else {
        self.navigationItem.title = @"历史订单";
        [self requestNearCarOrderData];
    }
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = MColor(238, 238, 238);
    
    [self.tableView registerClass:[LogisticsOrderTVCell class] forCellReuseIdentifier:@"LogisticsOrderTVCell"];
    [_tableView registerClass:[GuestbookContentTVCell class] forCellReuseIdentifier:@"GuestbookContentTVCell"];
    [_tableView registerClass:[DriverTheROTVCell class] forCellReuseIdentifier:@"DriverTheROTVCell"];
    [_tableView registerClass:[DriverHRDTVCell class] forCellReuseIdentifier:@"DriverHRDTVCell"];
    [_tableView registerClass:[NoAcceptOrderTVCell class] forCellReuseIdentifier:@"NoAcceptOrderTVCell"];
    [self.view addSubview:self.tableView];
}

/**
 *请求正在进行的订单
 */
- (void)requestNearCarOrderData {
    
    [self performSelector:@selector(indeterminateExample)];
    NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
    NSString *URL_Str;
    if (_stateIndex == 1) {
        URL_Str = [NSString stringWithFormat:@"%@/cartask/api/findRunningCarTask", kSHY_100];
        URL_DIC[@"carOwnerId"] = self.carOwnerId;
    }else {
        URL_Str = [NSString stringWithFormat:@"%@/cartask/api/findCarTasksById", kSHY_100];
        URL_DIC[@"carTaskId"] = self.dricerOrderId;
    }
    
    NSLog(@"URL_DIC%@ ---URL_Str%@",URL_DIC , URL_Str);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block CallCarOderDetailsVC *VC = self;
    [session POST:URL_Str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        
        NSString *resultStr = [NSString stringWithFormat:@"%@",responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            
            [VC parsingNearCarOrderData:responseObject];
        }else {
            [VC showAlert:@"获取失败,请重试!"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"请求失败请重试" time:1.0];
    }];
}
/**
 *解析正在进行的订单n
 */
- (void)parsingNearCarOrderData:(NSDictionary *)orderDIc {
    NSArray *orderArr = orderDIc[@"data"];
    [self.orderArray removeAllObjects];
    if (orderArr.count == 0) {
        [self showAlert:orderDIc[@"msg"] time:1.0];
        return;
    }
    for (NSDictionary *orderDic in orderArr) {
        
        NSEntityDescription *des = [NSEntityDescription entityForName:@"DriverCarOrderDetailsModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        DriverCarOrderDetailsModel *driverOrderModel = [[DriverCarOrderDetailsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
 
        for (NSString *key in orderDic) {
            NSLog(@"parsingNearCarOrderData%@ ------ %@", orderDic[key], key);
            if ([key isEqualToString:@"create_time"]) {
                [driverOrderModel setValue:orderDic[key] forKey:@"createTime"];
            }else {
                [driverOrderModel setValue:orderDic[key] forKey:key];
            }
        }
        [self.orderArray addObject:driverOrderModel];
    }
    
    [self.tableView reloadData];
}

- (void)handleReturn {
    NSArray *vcArray = self.navigationController.viewControllers;
    for(UIViewController *vc in vcArray) {
        if ([vc isKindOfClass:[MyDriverVC class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.orderArray.count == 0) {
        return 0;
    }else {
        return self.orderArray.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DriverCarOrderDetailsModel *carOrderModel = self.orderArray[indexPath.section];
    if (indexPath.row == 9) {
        if (self.stateIndex == 1) {//正在运行的订单
            DriverTheROTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DriverTheROTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }else if(self.stateIndex == 2){
            DriverHRDTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DriverHRDTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            NoAcceptOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoAcceptOrderTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if(indexPath.row == 8 ) {
        GuestbookContentTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuestbookContentTVCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentLabel.text = carOrderModel.leaveMessage;
        return cell;
    }else{
        LogisticsOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogisticsOrderTVCell" forIndexPath:indexPath];
        
        [cell controlsAssignment:(int)indexPath.row dataArray:@[@[@"wd-wssj-wldd-djmz",@"wd-wssj-wldd-dh", @"wd-wssj-ckxq-mjmz", @"wd-wssj-wldd-dh", @"CCstartLocation", @"CCEndLocation", @"SelectModels", @"EstimateMoney"],@[@"商家名字", @"商家电话", @"买家名字", @"买家电话", @"始发地", @"目的地", @"车辆类型", @"运费"], @[carOrderModel.store_name, carOrderModel.store_tel, carOrderModel.buyer_name, carOrderModel.buyer_mobile, carOrderModel.address, carOrderModel.daddress, @"汽车", carOrderModel.transport_charge]]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DriverCarOrderDetailsModel *carOrderModel = self.orderArray[indexPath.section];
    if (indexPath.row == 8) {
        NSLog(@"carOrderModel.leaveMessage%@",carOrderModel.leaveMessage);
        if (carOrderModel.leaveMessage.length > 2) {
            return kFit(47);
        }else {
            return [self cellHeightForIndexPath:indexPath cellContentViewWidth:kScreen_widht tableView:tableView];
        }
    }else {
        return kFit(47);
    }
}
//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 9) {
        
        if (self.stateIndex == 1) {
        
        }else if(self.stateIndex == 2) {
        
        }else if (self.stateIndex == 0 ) {
            
            [self performSelector:@selector(indeterminateExample)];
            NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/grabOrder", kSHY_100];
            NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
            URL_Dic[@"id"] = self.dricerOrderId;
            URL_Dic[@"carOwnerId"] = self.carOwnerId;
            __weak CallCarOderDetailsVC *VC = self;
            AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
            [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
                //    NSLog(@"uploadProgress%@", uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [VC performSelector:@selector(delayMethod)];
                NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
                   NSLog(@"responseObject%@", responseObject);
                if ([resultStr isEqualToString:@"1"]) {
                    [VC.tableView reloadData];
                    [VC showAlert:responseObject[@"msg"]];
                    [VC.navigationController popViewControllerAnimated:YES];
                }else {
                    if ([responseObject[@"msg"] isEqualToString:@"抢单失败，存在未完结订单"]) {
                        UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"抢单失败，存在未完结订单" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"查看" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                            _stateIndex = 1;
                            VC.navigationItem.title = @"正在运行的订单";
                            [VC requestNearCarOrderData];
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
        
                [VC showAlert:@"请求失败请重试" time:1.0];
            }];

        
        }
    }
    
}



#pragma mark  DriverTheROTVCellDelegate
/**
 *使用导航
 */
- (void)navigation:(UIButton *)sender {
    
    DriverCarOrderDetailsModel *model = self.orderArray[0];

    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"帮助!" message:@"请选择您的目的地!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"到商家" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
        CLLocationCoordinate2D CC;
        CC.longitude =  model.store_longitude.floatValue;
        CC.latitude = model.store_latitude.floatValue;
        [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:CC.latitude longitude:CC.longitude] name:@"目的地" POIId:nil];  //传入终点
        [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
    }];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"到买家" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
        CLLocationCoordinate2D CC;
        CC.longitude = model.buyer_longitude.floatValue;
        CC.latitude = model.buyer_latitude.floatValue;
        [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:CC.latitude longitude:CC.longitude] name:@"目的地" POIId:nil];  //传入终点
        [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
    }];
    // 3.将“取消”和“确定”按钮加入到弹框控制器中
    [alertV addAction:cancle];
    [alertV addAction:confirm];
    // 4.控制器 展示弹框控件，完成时不做操作
    [self presentViewController:alertV animated:YES completion:^{
        nil;
    }];
}
/**
 *确认送达
 */
- (void)ConfirmDelivery:(UIButton *)sender {

    [self performSelector:@selector(indeterminateExample)];
    NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/confirmDelivered", kSHY_100];
    
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    DriverCarOrderDetailsModel *model = self.orderArray[0];
    URL_Dic[@"carTaskId"] = model.carTaskId;
    NSLog(@"URL_Dic%@", URL_Dic);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block CallCarOderDetailsVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSString *resultStr = [NSString stringWithFormat:@"%@",responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC showAlert:@"确认成功,祝您生活愉快"];
            [VC.navigationController popViewControllerAnimated:YES];
        }else {
            [VC showAlert:@"确认失败,请重试"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@", error);
        [VC performSelector:@selector(delayMethod)];
    
        [VC showAlert:@"请求失败请重试" time:1.0];
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
//网络加载指示器
- (void)indeterminateExample {
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
    
}

- (void)delayMethod{
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
    
}



@end
