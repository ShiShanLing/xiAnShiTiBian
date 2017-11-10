//
//  OrderCFVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "OrderCFVC.h"
#import "PublicTVOneCell.h"
#import "ForecastPriceTVCell.h"
#import "CarChooseView.h"//车型选择
#import "RulesFreightTVCell.h"
@interface OrderCFVC ()<UITableViewDelegate, UITableViewDataSource,CarChooseViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *DataArray;
/**
 *汽车型号选择 Fahrzeugmodell 
 */
@property (nonatomic, strong) CarChooseView *FPickerView;

@property (nonatomic, strong)NSMutableArray *VehicleTypeArray;
/**
 *车型选择时的背景色
 */
@property (nonatomic, strong)UIView *backImageView;

/**
 *选择的当前车型str
 */
@property (nonatomic, strong)NSMutableDictionary *ChooseCarDic;

@property (strong, nonatomic)AppDelegate *AppDelegate;
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

@implementation OrderCFVC

- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {
        //获取Appdelegate对象
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedContext =  delegate.managedObjectContext;
    }
    return _managedContext;
}
- (AppDelegate *)AppDelegate {
    if (!_AppDelegate) {
        _AppDelegate = [[AppDelegate alloc] init];
    }
    return _AppDelegate;
}



- (NSMutableDictionary *)ChooseCarDic {
    if (!_ChooseCarDic) {
        _ChooseCarDic  = [NSMutableDictionary dictionary];
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
    self.navigationItem.title = @"计算运费";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self creatTableView];

}





- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth-0) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = MColor(238, 238, 238);
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
      [_tableView registerClass:[PublicTVOneCell class] forCellReuseIdentifier:@"PublicTVOneCell"];
    [_tableView registerClass:[ForecastPriceTVCell class] forCellReuseIdentifier:@"ForecastPriceTVCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"RulesFreightTVCell" bundle:nil] forCellReuseIdentifier:@"RulesFreightTVCell"];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        ForecastPriceTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastPriceTVCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.ForecastPriceBtn setTitle:@"预估" forState:(UIControlStateNormal)];
        cell.backgroundColor = MColor(238, 238, 238);
        return cell;
    }else if(indexPath.row == 4){
        RulesFreightTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RulesFreightTVCell" forIndexPath:indexPath];
        cell.backgroundColor = MColor(238, 238, 238);
        cell.rulesFreightLabel.backgroundColor  = MColor(238, 238, 238);
        return cell;
    
    }else{
        PublicTVOneCell *cell= [tableView dequeueReusableCellWithIdentifier:@"PublicTVOneCell" forIndexPath:indexPath];
        NSString *carType = @" ";
        if (_ChooseCarDic.count == 0) {
            
        }else {
            carType = _ChooseCarDic[@"carType"];
        }
        NSLog(@"carType%@", carType);
        NSMutableArray *contentArray = @[[NSString stringWithFormat:@"%@ %@", _buyersModel.areaInfo, _buyersModel.address], [self defaultShippingAddress], carType];
        [cell CellControlsAssignment:indexPath content:contentArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (NSString *)defaultShippingAddress {
    NSString *Address = @" ";
   
            Address = [NSString stringWithFormat:@"%@ %@", [SellerDataSingleton mainSingleton].sellerDataModel.areaInfo, [SellerDataSingleton mainSingleton].sellerDataModel.storeAddress];

    return Address;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        [self CalculateFreight];
    }
    //获取车辆类型
    if (indexPath.row == 2) {
        [self performSelector:@selector(indeterminateExample)];
        
        NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/selectCarCost", kSHY_100];
        __block OrderCFVC *VC = self;
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session GET:URL_Str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"downloadProgress%@", downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [VC performSelector:@selector(delayMethod)];
            if ([[NSString stringWithFormat:@"%@", responseObject[@"result"] ] isEqualToString:@"1"]) {
                VC.VehicleTypeArray = [NSMutableArray arrayWithArray:responseObject[@"data"]];
                [VC CellClickEvent];
            }else {
                [VC showAlert:@"车辆信息获取失败,请重试"];
            }
            NSLog(@"responseObject%@", responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [VC performSelector:@selector(delayMethod)];
            [VC showAlert:@"网络超时请重试"];
        }];
    }
}
/**
 *根据距离车型 计算运费
 */
- (void) CalculateFreight{
    
        BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(self.buyersModel.latitude.doubleValue, self.buyersModel.longitude.doubleValue));
        BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake([SellerDataSingleton mainSingleton].sellerDataModel.storeLatitude.doubleValue, [SellerDataSingleton mainSingleton].sellerDataModel.storeLongitude.doubleValue));
        CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    if (_ChooseCarDic.count == 0) {
        [self  showAlert:@"请选择车型"];
    }else {
        [self performSelector:@selector(indeterminateExample)];
        
        NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/getTransportCharge", kSHY_100];
        NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
        URL_DIC[@"distance"] = [NSString stringWithFormat:@"%.2f", distance/1000];
        URL_DIC[@"id"] = _ChooseCarDic[@"id"];
        NSLog(@"URL_Str%@ \nURL_DIC%@", URL_Str, URL_DIC);
        __block OrderCFVC *VC = self;
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session POST:URL_Str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
            //NSLog(@"uploadProgress%@", uploadProgress);
           // [VC performSelector:@selector(delayMethod)];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            NSString *text = responseObject[@"data"];
            CGFloat price = text.floatValue;
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:[NSString stringWithFormat:@"计算成功 大概%.2f公里,一共%.2f人民币",distance/1000, price] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [VC SubmitOrdersFreight:[NSString stringWithFormat:@"%@", responseObject[@"data"]]];
                
            }];
            // 3.将“取消”和“确定”按钮加入到弹框控制器中
            [alertV addAction:cancle];
            [alertV addAction:confirm];
            // 4.控制器 展示弹框控件，完成时不做操作
            [self presentViewController:alertV animated:YES completion:^{
                nil;
            }];
        }else {
            [VC showAlert:@"获取失败请重试"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        NSLog(@"error%@", error);
    }];
    }
}
/**
 *订单提交运费
 */
- (void)SubmitOrdersFreight:(NSString *)price {
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/updateOrder", kSHY_100];
    NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
    URL_DIC[@"orderSn"] =self.OrderSn;
    URL_DIC[@"transportCharge"] = price;
    URL_DIC[@"id"] = self.ChooseCarDic[@"id"];
    __block OrderCFVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:URL_Str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
        [VC performSelector:@selector(delayMethod)];
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [self.navigationController popViewControllerAnimated:YES];
            [VC showAlert:@"订单提交成功"];
        }else {
            [VC showAlert:@"获取失败请重试"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"网络超时请重试"];
    }];
}
//创建一个存在于视图最上层的UIViewController
- (UIViewController *)appRootViewController{
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
- (void)CellClickEvent {
    
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
    self.ChooseCarDic = [NSMutableDictionary dictionaryWithDictionary:carDic];
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return kFit(70);
    }else if(indexPath.row == 4){
        return 200;
    }else {
        return kFit(48);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
