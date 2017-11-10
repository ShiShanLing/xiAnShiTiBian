//
//  SpecifydriverCallCarVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/9.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SpecifydriverCallCarVC.h"

@interface SpecifydriverCallCarVC ()
/**
 *商品订单编号
 */
@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
/**
 *车主电话
 */
@property (weak, nonatomic) IBOutlet UITextField *driverPhoneTF;
//----------------------------------------------司机信息查询成功的view
/**
 *查询车主成功显示的view
 */
@property (weak, nonatomic) IBOutlet UIView *driverDataView;
/**
 *车主头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *driverHeadImage;
/**
 *车主名字
 */
@property (weak, nonatomic) IBOutlet UILabel *driverNameLabel;
/**
 *司机电话
 */
@property (weak, nonatomic) IBOutlet UILabel *driverIponeLabel;
/**
 *司机车牌号
 */
@property (weak, nonatomic) IBOutlet UILabel *carPlateNumLabel;
/**
 *汽车品牌
 */
@property (weak, nonatomic) IBOutlet UILabel *CarTypeLabel;
/**
 *车辆类型
 */
@property (weak, nonatomic) IBOutlet UILabel *carCategoryLabel;
/**
 *发布订单按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *generateOrderBtn;
/**
 *司机查询失败view
 */
@property (weak, nonatomic) IBOutlet UIView *queryFailsView;

@property (weak, nonatomic) IBOutlet UILabel *searchResultsLabel;

@property (nonatomic, strong)NSManagedObjectContext *managedContext;

@property (nonatomic, strong)AppDelegate *delegate;

/**
 *存储司机资料的数组
 */
@property (nonatomic, strong)NSMutableArray *driverDataArray;
@end

@implementation SpecifydriverCallCarVC
- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedContext =  delegate.managedObjectContext;
    }
    return _managedContext;
}
- (AppDelegate *)delegate {
    if (_delegate) {
        _delegate = [[AppDelegate alloc] init];
    }
    return _delegate;
}

- (NSMutableArray *)driverDataArray {
    if (!_driverDataArray) {
        _driverDataArray = [NSMutableArray array];
    }
    return _driverDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queryFailsView.hidden = YES;
    self.driverDataView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleFindBtn:(id)sender {
    [self.driverPhoneTF resignFirstResponder];
    if (self.driverPhoneTF.text.length == 0) {
        [self showAlert:@"手机号不能为空" time:1.0];
        return;
    }
    NSString *URL_Str = [NSString stringWithFormat:@"%@/carowner/api/findCarOwnerByMobile", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"mobile"] = self.driverPhoneTF.text;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __weak SpecifydriverCallCarVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            _driverDataView.hidden = NO;
            [VC parsingDriverData:responseObject[@"data"][0]];
        } else {
            [VC showAlert:responseObject[@"msg"] time:1.0];
            _searchResultsLabel.text = responseObject[@"msg"];
            _queryFailsView.hidden = NO;
        }
        NSLog(@"responseObject%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@", error);
    }];
}
/**
 *解析司机数据
 */
- (void)parsingDriverData:(NSDictionary *)driverData {
    [self managedContext];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"DriverDataModel" inManagedObjectContext:self.managedContext];
    //根据描述 创建实体对象
    DriverDataModel *driverModel = [[DriverDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
    
    for (NSString *key in driverData) {
        [driverModel setValue:driverData[key] forKey:key];
    }
    [self.driverDataArray addObject:driverModel];
    [self ShowOwnerInformation:driverModel];
    NSLog(@"driverDataArray%@",_driverDataArray);
}

- (void)ShowOwnerInformation:(DriverDataModel *)model {
    self.driverNameLabel.text = [NSString stringWithFormat:@"司机名字:%@", model.carOwnerName];
    self.driverIponeLabel.text  = [NSString stringWithFormat:@"手机号:%@", model.memberMobile];
    self.carPlateNumLabel.text = [NSString stringWithFormat:@"车牌号:%@",model.carLicenseNumber];
    self.carCategoryLabel.text = [NSString stringWithFormat:@"汽车型号:%@", model.carType];;
    self.CarTypeLabel.text = [NSString stringWithFormat:@"车辆类型:%@", model.carVehicleBrand];
}
//发布叫车订单
- (IBAction)handleGenerateOrderBtn:(id)sender {
    DriverDataModel *model = _driverDataArray[0];
    NSString *URL_Str = [NSString stringWithFormat:@"%@/carowner/api/specifyCarOwner", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"orderId"] = _model.orderId;
    URL_Dic[@"orderSn"] = _model.orderSn;
    URL_Dic[@"carOwnerId"] = model.carOwnerId;
    URL_Dic[@"storeId"] = _model.storeId;
    URL_Dic[@"transportCharge"] = _model.shippingFee;;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"msg"]];
        if ([resultStr isEqualToString:@"1"]) {
            __weak SpecifydriverCallCarVC *VC = self;
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"恭喜您!" message:@"订单指定司机成功!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [VC.navigationController popViewControllerAnimated:YES];
            }];
         
            // 3.将“取消”和“确定”按钮加入到弹框控制器中
            [alertV addAction:cancle];
            // 4.控制器 展示弹框控件，完成时不做操作
            [self presentViewController:alertV animated:YES completion:^{
                nil;
            }];
        }else {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@", error);
    }];
}

-(void)setModel:(SellerOrderListModel *)model {
    _model = model;
    self.orderIDLabel.text = model.orderSn;
}

@end
