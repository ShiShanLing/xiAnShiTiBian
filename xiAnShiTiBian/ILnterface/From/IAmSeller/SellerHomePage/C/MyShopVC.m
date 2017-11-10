//
//  MyShopVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/16.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MyShopVC.h"
#import "ShopCalculateFreightVC.h"//待定运费
#import "ShopWaitingPaymentVC.h"//等待付款
#import "WaitingCallcarVC.h"//等待叫车
#import "ShopWaitDeliveryVC.h"//等待发货
#import "ShopWaitingGoodsVC.h"//等待收货
#import "SellerStoreDataVC.h"//店铺信息界面
#import "CallCarOrderVC.h"//商家的叫车订单界面
#import "SellerEndOrderVC.h"//商家已经完成的家界面
#import "SellerShipmentsAddVC.h"//商家发货地址界面

#import "ShopActivityTVCell.h"
#import "ShopMyOrderTVCell.h"
#import "ShopServiceTVCell.h"
@interface MyShopVC ()<UITableViewDelegate, UITableViewDataSource, ShopMyOrderTVCellDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSManagedObjectContext *managedContext;

@property (nonatomic, strong)AppDelegate *delegate;


@property (nonatomic, strong)SellerDataModel *sellerDataModel;

@property (nonatomic, strong)NSMutableArray *sellerDataArray;

@end

@implementation MyShopVC

- (NSMutableArray *)sellerDataArray {
    if (!_sellerDataArray) {
        _sellerDataArray = [NSMutableArray array];
    }
    return _sellerDataArray;
}

- (SellerDataModel *)sellerDataModel {
    if (!_sellerDataModel) {
        _sellerDataModel = [[SellerDataModel alloc] init];
    }
    return _sellerDataModel;
}

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configurationNavigationBar];
    [self configurationTableView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO];
    [self obtainStoreData];
}

- (void)configurationNavigationBar{
    self.view.backgroundColor = MColor(234, 234, 234);
      [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color,NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];
    self.navigationItem.title = @"我的店铺";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;

}

- (void)obtainStoreData {
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/storeapi/storeDetails", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"storeId"] = [UserDataSingleton mainSingleton].storeID;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block MyShopVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@", responseObject);
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            
            [VC parsingStoreData:responseObject[@"data"][0]];
        }else {
            [VC showAlert:@"商家信息获取失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"网络超时请重试"];
    }];
}
- (void)parsingStoreData:(NSMutableDictionary *)data {
    NSEntityDescription *des = [NSEntityDescription entityForName:@"SellerDataModel" inManagedObjectContext:self.managedContext];
    //根据描述 创建实体对象
    SellerDataModel *model = [[SellerDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
    for (NSString *key in data) {
        [model setValue:data[key] forKey:key];
    }
    self.sellerDataModel = model;
    self.navigationItem.title = model.storeName;
    [self.sellerDataArray addObject:model];
    [SellerDataSingleton mainSingleton].sellerDataModel = model;
    [self.tableView reloadData];
}
//更多
- (void)handleCollect {
    MessageViewController *VC = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
//返回上一界面
- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)configurationTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = MColor(238, 238, 238);
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[ShopActivityTVCell class] forCellReuseIdentifier:@"ShopActivityTVCell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_tableView registerClass:[ShopMyOrderTVCell class] forCellReuseIdentifier:@"ShopMyOrderTVCell"];
    [_tableView registerClass:[ShopServiceTVCell class] forCellReuseIdentifier:@"ShopServiceTVCell"];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 1){
        ShopMyOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopMyOrderTVCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        ShopServiceTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopServiceTVCell" forIndexPath:indexPath];
        NSArray *titleArray = @[@[@"qbdd", @"已完成订单"], @[@"wd-wssj-wldd", @"查看物流订单"], @[@"StoreData", @"店铺信息"], @[@"deliveryAddress", @"发货地址"]];
        [cell ControlsAssignment:titleArray[indexPath.row - 2] indexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SellerDataModel *model = self.sellerDataArray[0];
    
    if (indexPath.row == 2) {
        SellerEndOrderVC *VC = [[SellerEndOrderVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 3) {
        CallCarOrderVC *VC = [[CallCarOrderVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 4) {
        SellerStoreDataVC *VC = [[SellerStoreDataVC alloc] init];
        VC.storeID = model.storeId;;
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 5) {
        SellerShipmentsAddVC *VC = [[SellerShipmentsAddVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return kFit(0);
    }else if(indexPath.row == 1){
        return kFit(133);
    }else {
        return kFit(56);
    }
}

//订单类型选择
- (void)SelectOrderStatus:(int)index {
    switch (index) {
        case 200:{
            ShopCalculateFreightVC *VC = [[ShopCalculateFreightVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 201:{
            ShopWaitingPaymentVC *VC = [[ShopWaitingPaymentVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 202:{
            WaitingCallcarVC *VC = [[WaitingCallcarVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 203:{
            ShopWaitDeliveryVC *VC = [[ShopWaitDeliveryVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 204:{
            ShopWaitingGoodsVC *VC = [[ShopWaitingGoodsVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        default:
            break;
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

@end
