//
//  ConfirmOrderVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ConfirmOrderVC.h"
#import "ConfirmShippingAddressTVCell.h"
#import "COSNTableViewCell.h"
#import "ConfirmOrderGoodsTVCell.h"
#import "SmallTVCell.h"
#import "LeaveWordTVCell.h"//留言
#import "BuyPatternsTVCell.h"
#import "ServiceTableViewCell.h"
#import "submitView.h"//提交订单view
#import "ChangeSAVC.h"//修改默认收货地址
#import "DeliveryWayVC.h"//配送方式选择
#import "TaxViewController.h"//选择是否含税
#import "InvoiceChooseVC.h"//发票界面
#import "PayPopUpView.h"//支付的弹窗
#import "IDViewController.h"//积分说明界面
#import <AlipaySDK/AlipaySDK.h>

#import "buyersShowOrderVC.h"
#import "WXApiObject.h"//微信的请求体
#import "WXApi.h"
#import "WXApiManager.h"
static int cellnumbar;
@interface ConfirmOrderVC ()<UITableViewDelegate, UITableViewDataSource, submitViewDelegate, PayPopUpViewDelegate, WXApiManagerDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *DataMArray;
@property (nonatomic, strong)UIView *backImageView1;//规格选择弹出视图的背景色

@property (nonatomic, strong)PayPopUpView *popUpView;//支付类型选择view 当用户选择商家配送的时候这个界面你不用出现
@property (nonatomic, strong)submitView *submitOrderView;
/**
 *存储订单里面的商品
 */
@property (nonatomic, strong)NSMutableArray *OrderArray;
/**
 *存储默认收货地址 数据
 */
@property (nonatomic, strong)ShippingAddressModel *addressModel;

@end

@implementation ConfirmOrderVC {
    /**
     *表明使用什么配送方式.1商家配送 或者2自提
     */
    NSInteger  DeliveryWayIndex;
    /**
     *表明是否含税
     */
    NSInteger TaxIndex;
    /**
     *发票抬头
     */
    NSString *invoiceTitle;
    /**
     *发票类型  0不开发票 1纸质发票 2电子发票
     */
    NSInteger InvoiceType;
}
- (NSMutableArray *)OrderArray {
    if (!_OrderArray) {
        _OrderArray = [NSMutableArray array];
    }
    return _OrderArray;
}

- (NSMutableArray *)DataMArray {
    if (_DataMArray ==nil) {
        
        self.DataMArray = [NSMutableArray arrayWithArray:@[@"1"]];
        
    }
    return _DataMArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getOrderContentData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [WXApiManager sharedManager].delegate = self;
     NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"return" object:nil];
    
    DeliveryWayIndex = 0;
    invoiceTitle = @"个人";
    
    [self configurationNavigationBar];
    [self setTableView];
    //确定支付按钮
    self.submitOrderView = [[submitView alloc] init];
    _submitOrderView.delegate = self;
    _submitOrderView.priceLabel.text = [NSString stringWithFormat:@"¥%.2f", _orderPrice];
    [self.view addSubview:_submitOrderView];
    _submitOrderView.sd_layout.leftSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(kFit(49));
}

-(void)notice:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *获取订单内容的数据
 */
- (void)getOrderContentData {
    [self performSelector:@selector(indeterminateExample)];
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/cartapi/subToOrder", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"cartId"] = self.cartIds;
    URL_Dic[@"memberId"] = [UserDataSingleton mainSingleton].userID;
    NSLog(@"URL_Dic%@", URL_Dic);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block ConfirmOrderVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"responseObject%@", responseObject);
        [VC performSelector:@selector(delayMethod)];
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC AnalyticalGoodsDetailsData:responseObject];
        }else {
            [VC showAlert:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"请求失败请重试" time:1.0];
    }];
}

- (void)AnalyticalGoodsDetailsData:(NSDictionary *)dic {
    [self.OrderArray removeAllObjects];
   // NSLog(@"AnalyticalGoodsDetailsData%@", dic);
    NSArray *dataArray = dic[@"data"];//获取最外层数据
    NSDictionary *OrderDic = dataArray[0];
    //获取收货地址
    NSArray *addressArr = OrderDic[@"addressList"];
   
    if (addressArr.count != 0) {
        for (int i = 0; i<addressArr.count; i++) {
           
            NSEntityDescription *des = [NSEntityDescription entityForName:@"ShippingAddressModel" inManagedObjectContext:self.managedContext];
            //根据描述 创建实体对象
            ShippingAddressModel *model = [[ShippingAddressModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
            
            NSMutableDictionary *addressDic = addressArr[i];
            for (NSString *key in addressDic){
                [model setValue:addressDic[key] forKey:key];
            }
            if ([model.isDefault  isEqualToString: @"1"]) {
                self.addressModel = model;
            }
        }
        
        
    }
    //获取商品
    NSArray *storeArray =OrderDic[@"cartVoList"];
    if (storeArray.count != 0) {
    //使用数据管理器
     [self managedContext];
    for (NSDictionary *storeDic in storeArray) {//获取商品
        
        NSEntityDescription *des = [NSEntityDescription entityForName:@"ShoppingCartStoreModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        ShoppingCartStoreModel *storeModel = [[ShoppingCartStoreModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        for (NSString *sotreKey in storeDic) {//获取商品里面参数
            NSMutableArray *goodsArray= [NSMutableArray array];//接收该商店里面的商品
            if ([sotreKey isEqualToString:@"list"]) {//获取规格名字
                goodsArray = storeDic[sotreKey];//接收数据
                NSMutableArray *goodsModelArray = [NSMutableArray array];//存储封装成model对象的数组
                for (int i = 0; i < goodsArray.count; i++) {
                    NSMutableDictionary *goodsDic = goodsArray[i];
                    NSEntityDescription *des = [NSEntityDescription entityForName:@"ShoppingCartGoodsModel" inManagedObjectContext:self.managedContext];
                    //根据描述 创建实体对象
                    ShoppingCartGoodsModel * goodsModel= [[ShoppingCartGoodsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                    
                    for (NSString *goodsKey in goodsDic) {
                        if([goodsKey isEqualToString:@"goodsImages"]){
                            
                            [goodsModel setValue:goodsDic[goodsKey] forKey:goodsKey];
                        
                        }else {
                            //NSLog(@"goodsDic[goodsKey]--%@, goodsKey--%@", goodsDic[goodsKey], goodsKey);
                            if ([goodsKey isEqualToString:@"storeName"]||[goodsKey isEqualToString:@"giftPoints"]) {
                                
                            }else {
                                [goodsModel setValue:goodsDic[goodsKey] forKey:goodsKey];
                            }
                        }
                    }
                    [goodsModelArray addObject:goodsModel];
                }
                [storeModel setValue:goodsModelArray forKey:sotreKey];
            }else {
                if ([sotreKey isEqualToString:@"transGoodsNum"]||[sotreKey isEqualToString:@"goodsTotalPrice"]||[sotreKey isEqualToString:@"cartIds"]||[sotreKey isEqualToString:@"giftPoints"] ||[sotreKey isEqualToString:@"goodsTotalFreight"]) {
                    
                }else {
                  //  NSLog(@"storeDic[sotreKey]--%@, sotreKey--%@", storeDic[sotreKey], sotreKey);
                    [storeModel setValue:storeDic[sotreKey] forKey:sotreKey];
                }
            }
        }
        [self.OrderArray addObject:storeModel];
        }
    }//最外层数据是否空判断
    
   // NSLog(@"生成订单数据打印------->>>>>>%@", _OrderArray);
    [self.tableView reloadData];
}

#pragma mark PayPopUpViewDelegate 确定支付选择支付方式
//创建一个存在于视图最上层的UIViewController
- (UIViewController *)appRootViewController{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
- (void)ShoppingCellClickEvent{//
    //xia面是弹窗的初始化
    UIViewController *topVC = [self appRootViewController];
    if (!self.backImageView1) {
        self.backImageView1 = [[UIView alloc] initWithFrame:self.view.bounds];
        self.backImageView1.backgroundColor = [UIColor blackColor];
        self.backImageView1.alpha = 0.3f;
        self.backImageView1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
        tapGesture.numberOfTapsRequired=1;
        [self.backImageView1 addGestureRecognizer:tapGesture];
    }
    [topVC.view addSubview:self.backImageView1];
    
    self.popUpView = [[PayPopUpView alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(450))];
    _popUpView.OrderPrice = _orderPrice;
    self.popUpView.delegate = self;
    [topVC.view addSubview:self.popUpView];
    
    [UIView animateWithDuration: 0.2 animations:^{
        
        self.popUpView.frame =CGRectMake(0, kScreen_heigth-kFit(450), kScreen_widht, kFit(450));
        
    }];
}
//隐藏弹窗
- (void)hiddenView { //调用这个方法不保存选择的数值
    [self.backImageView1 removeFromSuperview];
    [UIView animateWithDuration: 0.2 animations:^{
        self.popUpView.frame =CGRectMake(0, kScreen_heigth * 2, kScreen_widht, kFit(450));
    }];
}
//帮助按钮
- (void)handleHelp {
    IDViewController *VC = [[IDViewController alloc] init];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:navc animated:YES completion:nil];
}
#pragma mark  submitViewDelegate 提交订单
- (void)ConfirmpayBtn {
    if (DeliveryWayIndex == 1) {//需要付钱
        [self ShoppingCellClickEvent];
    }else if(DeliveryWayIndex == 2){ //直接提交 因为需要计算运费
        [self SaveOrder];
    }else {
        
        [self showAlert:@"未选择货运方式" time:1.2];
        
    }
}
//////这里请求支付的接口
- (void)SaveOrder {
    [self performSelector:@selector(indeterminateExample)];
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/orderapi/saveorder", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"cartIds"] = self.cartIds;
    URL_Dic[@"addressId"] = self.addressModel.addressId;
    URL_Dic[@"paytype"] = [NSString stringWithFormat:@"%ld", DeliveryWayIndex];//货运方式 是自提还是商家发货(需要付运费)
    URL_Dic[@"memberId"] = [UserDataSingleton mainSingleton].userID;
    URL_Dic[@"taxState"] = [NSString stringWithFormat:@"%ld", (long)TaxIndex];//是否含税 0不含税 1含税
    URL_Dic[@"invoiceInfo"] = [NSString stringWithFormat:@"%ld", InvoiceType]; // 0不开,1电子,2纸质
    URL_Dic[@"companyName"] = invoiceTitle;//发票的公司名称
    URL_Dic[@"paymentState"] = @"0";//用户是否支付了
    NSLog(@"SaveOrder URL_Dic%@", URL_Dic);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block ConfirmOrderVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"responseObject%@", responseObject);
        
        
        [VC performSelector:@selector(delayMethod)];
        NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([str isEqualToString:@"1"]) {
            
            NSArray *dataArray = responseObject[@"data"];
            NSDictionary *dataDic = dataArray[0];
            NSString *dataStr =  dataDic[@"orderId"];
            [self showAlert:@"提交成功"];
            buyersShowOrderVC *buyersShow = [[buyersShowOrderVC alloc] init];
            buyersShow.orderID = dataStr;
            [self.navigationController pushViewController:buyersShow animated:YES];
        }else {
            [self showAlert:@"提交失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"请求失败请重试" time:1.0];
        NSLog(@"%@", error);
    }];

}
//配置导航条
- (void)configurationNavigationBar{
    self.view.backgroundColor = MColor(134,134,134);
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];//导航条颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];//改变导航条标题的颜色与大小
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];//去除导航条上图片的渲染色
    self.navigationItem.title = @"确认订单";
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
}
//返回上一界面
- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *创建视图
 */
- (void)setTableView {

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth-kFit(49)) style:(UITableViewStylePlain)];
    
    _tableView.delegate =self;
    _tableView.bounces = NO;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableView"];
    
    [_tableView registerClass:[ConfirmShippingAddressTVCell class] forCellReuseIdentifier:@"ConfirmShippingAddressTVCell"];
    [_tableView registerClass:[COSNTableViewCell class] forCellReuseIdentifier:@"COSNTableViewCell"];
    [_tableView registerClass:[ConfirmOrderGoodsTVCell class] forCellReuseIdentifier:@"ConfirmOrderGoodsTVCell"];
    [_tableView registerClass:[SmallTVCell class] forCellReuseIdentifier:@"SmallTVCell"];
    [_tableView registerClass:[LeaveWordTVCell class] forCellReuseIdentifier:@"LeaveWordTVCell"];
    [_tableView registerClass:[BuyPatternsTVCell class] forCellReuseIdentifier:@"BuyPatternsTVCell"];
    [_tableView registerClass:[ServiceTableViewCell class] forCellReuseIdentifier:@"ServiceTableViewCell"];
    [self.view addSubview:_tableView];
}
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.OrderArray.count + 2;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if(section == self.OrderArray.count + 1) {
        return 5;
    }else {
        if (self.OrderArray.count != 0) {
            ShoppingCartStoreModel * storeModel = self.OrderArray[section-1];
            //获取第N个商品
            NSArray *goodsArray = (NSArray *)storeModel.list;
            return goodsArray.count + 1;//返回商品数量 + 1(店铺名字)的行数
        }else {
            return 0;
        }
       
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ConfirmShippingAddressTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmShippingAddressTVCell" forIndexPath:indexPath];
        cell.model = self.addressModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == self.OrderArray.count + 1) {
        if (indexPath.row == 0) {//服务内容
            ServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
            SmallTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SmallTVCell" forIndexPath:indexPath];
            
            NSArray *titleArray = @[@"税收", @"配送方式", @"发票信息"];
            NSString *DeliveryWayStr;
            NSString *TaxStr;
            if (DeliveryWayIndex == 1) {
                DeliveryWayStr = @"自提";
            }else if(DeliveryWayIndex == 2 ){
                DeliveryWayStr = @"商家承包";
            }else {
                    DeliveryWayStr = @"未选择";
            }
            if (TaxIndex == 2) {
                if (indexPath.row == 3) {
                    cell.backgroundColor = MColor(245, 245, 245);
                }
                TaxStr = @"不含税";
            }else {
                cell.backgroundColor = [UIColor whiteColor];
                TaxStr = @"含税";
            }
            NSArray *defaultArray = @[TaxStr, DeliveryWayStr, invoiceTitle];
            [cell titlLabel:titleArray[indexPath.row - 1] DefaultLabel:defaultArray[indexPath.row - 1]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            BuyPatternsTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyPatternsTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            COSNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COSNTableViewCell" forIndexPath:indexPath];
            if (self.OrderArray.count != 0) {
                ShoppingCartStoreModel *model = self.OrderArray[indexPath.section - 1];
                cell.stopName.text = model.storeName;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            ConfirmOrderGoodsTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderGoodsTVCell" forIndexPath:indexPath];
          //  NSLog(@"_OrderArray%@", _OrderArray);
            if (self.OrderArray.count != 0) {
                //获取第N个商店
                ShoppingCartStoreModel * storeModel = self.OrderArray[indexPath.section-1];
                //获取第N个商品
                NSArray *goodsArray = (NSArray *)storeModel.list;
                NSLog(@"goodsArray%@-------%ld", goodsArray, (long)indexPath.row);
                if (goodsArray.count != 0) {
                    ShoppingCartGoodsModel * goodsModel = goodsArray[indexPath.row - 1];
                    
                    cell.model = goodsModel;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kFit(116);
    }else if(indexPath.section == self.OrderArray.count + 1) {
        return kFit(50);
    }else {
        if (indexPath.row == 0) {
                return kFit(61);
            }else{
                return kFit(142);
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __block ConfirmOrderVC * SelfVC = self;
    if (indexPath.section==0) {
        ChangeSAVC *VC = [[ChangeSAVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row != 0) {
            GoodsDetailsVController *VC= [[GoodsDetailsVController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    if (indexPath.section == self.OrderArray.count + 1) {
        if (indexPath.row == 1) {
            TaxViewController *VC = [[TaxViewController alloc] init];
            VC.defaultState = (int)TaxIndex;
            VC.TaxIndexBlock = ^(NSInteger index) {
                TaxIndex = index;
            };
            [self.navigationController pushViewController:VC animated:YES];
        }
        if (indexPath.row == 2) {
            
            DeliveryWayVC *VC = [[DeliveryWayVC alloc] init];
            VC.DefaultDeliveryWayIndex = DeliveryWayIndex;
            VC.returnTextBlock = ^(NSInteger  index){
            DeliveryWayIndex = index;
                
            };
            [self.navigationController pushViewController:VC animated:YES];
        }
        if (indexPath.row == 3) {
            if (TaxIndex == 2) {
            }else {
                InvoiceChooseVC *VC = [[InvoiceChooseVC alloc] init];
                VC.returnTextBlock = ^(NSInteger index,NSString *name) {
                //index.表明是什么类型的发票  不开 个人或者企业
                    InvoiceType  = index;
                    invoiceTitle = name;
                };
                [self.navigationController pushViewController:VC animated:YES];
            }
        }
    }
}
#pragma mark -------- 自提付款在这里----------------------
//记录用户点击了那种支付方式 默认为0  2是积分 3是支付宝 4是微信
- (void)DetermineBtnClick:(NSInteger)sender {
    
    if (sender == 0) {
        [self showAlert:@"您还没有选择支付方式" time:1.2];
        return;
    }
    
    [self performSelector:@selector(indeterminateExample)];
    [self.backImageView1 removeFromSuperview];
    [UIView animateWithDuration: 0.2 animations:^{
        self.popUpView.frame =CGRectMake(0, kScreen_heigth * 2, kScreen_widht, kFit(450));
    }];
    NSString *URL_Str = [NSString stringWithFormat:@"%@/orderapi/saveorder", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"cartIds"] = self.cartIds;
    URL_Dic[@"addressId"] = self.addressModel.addressId;
    URL_Dic[@"paytype"] = [NSString stringWithFormat:@"%ld", (long)DeliveryWayIndex];//货运方式 是自提还是商家发货(需要付运费)
    URL_Dic[@"memberId"] = [UserDataSingleton mainSingleton].userID;
    URL_Dic[@"taxState"] = [NSString stringWithFormat:@"%ld", (long)TaxIndex];//是否含税 0不含税 1含税
    URL_Dic[@"invoiceInfo"] = [NSString stringWithFormat:@"%ld", (long)InvoiceType]; // 0不开,1电子,2纸质
    URL_Dic[@"companyName"] = invoiceTitle;//发票的公司名称
    URL_Dic[@"paymentState"] = @"0";//用户是否支付了
    NSLog(@"URL_Dic%@", URL_Dic);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block ConfirmOrderVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        NSLog(@"自提付款打印数据%@",responseObject);
        [VC performSelector:@selector(delayMethod)];
        if ([str isEqualToString:@"1"]) {
            NSArray *dataArray = responseObject[@"data"];
            NSDictionary *dataDic = dataArray[0];
            NSString *dataStr =  dataDic[@"orderId"];
            
            [self requestOrderDetails:dataStr payState:sender];
            //  [self showAlert:@"订单提交成功,已经拦截支付宝!"];
        }else {
            [self showAlert:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"请求失败请重试" time:1.0];
        NSLog(@"%@", error);
    }];
}
#pragma mark -- 支付宝支付和微信支付在这个里面判断
- (void)requestOrderDetails:(NSString *)orderStr payState:(NSInteger)state{
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/orderapi/orderdetail", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"orderId"] = orderStr;
    NSLog(@"orderId%@", orderStr);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block ConfirmOrderVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"requestOrderDetails%@", responseObject);
        NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        [VC performSelector:@selector(delayMethod)];
        if ([str isEqualToString:@"1"]) {
            NSString *price;
            NSString *subject;
            NSString *outTradeNo;
            NSString *body;
            
            NSArray *dataArray = responseObject[@"data"];
            NSDictionary *dataDic = dataArray[0][@"order"];
            
            outTradeNo = dataDic[@"paySn"];
            price=dataDic[@"orderAmount"];
            
            NSArray * goodsArray = dataDic[@"orderGoodsList"];
            for (NSDictionary *goodsDic in goodsArray) {
                if (subject.length == 0) {
                    subject = goodsDic[@"goodsName"];
                }else {
                    subject = [NSString stringWithFormat:@"%@,%@", subject, goodsDic[@"goodsName"]];
                }
                if (body.length == 0) {
                    NSString * valueStr;
                    NSArray *typeArray = (NSArray *)[goodsDic[@"specInfo"] allKeys];
                    for (NSString *key in typeArray) {
                        if (valueStr.length == 0) {
                            valueStr = goodsDic[key];
                        }else {
                            valueStr = [NSString stringWithFormat:@"%@ %@",valueStr, goodsDic[key]];
                        }
                    }
                    body = [NSString stringWithFormat:@"%@ %@",goodsDic[@"goodsName"],  valueStr];
                }
            }
            if (state == 3) {
            
                [self requestAliPaymentSignature:price subject:subject outTradeNo:outTradeNo body:body];
            }else {
                [self requestWXPaySignature:price paySN:outTradeNo memberId:[UserDataSingleton mainSingleton].userID];
            }
        }else {
            [self showAlert:responseObject[@"msg"]];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"请求失败请重试" time:1.0];
        NSLog(@"%@", error);
    }];
}
//微信支付
- (void)requestWXPaySignature:(NSString *)price paySN:(NSString *)paySN memberId:(NSString *)memberId {

    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    
    NSString *URL_Str = [NSString stringWithFormat:@"http://www.shitibian.com/wxpay/api/towxpayInfo"];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"orderCode"] = paySN;
    URL_Dic[@"amount"] = price;
    URL_Dic[@"memberId"] = memberId;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __weak ConfirmOrderVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        NSLog(@"responseObject:%@",responseObject);
        if(responseObject != nil){
            NSString *retcode = [NSString stringWithFormat:@"%@", responseObject[@"result" ]];
            if (retcode.intValue != 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                //调起微信支付
                PayReq* req            = [[PayReq alloc] init];
                req.partnerId            = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp         = stamp.intValue;
                req.package             = [dict objectForKey:@"packageValue"];
                req.sign                = [dict objectForKey:@"sign"];
                BOOL  payState = [WXApi sendReq:req];
                if (payState) {
                    [VC showAlert:@"支付成功" time:1.2];
                }else {
                    [VC showAlert:@"支付失败" time:1.2];
                }
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@", error);
    }];
}
//支付宝支付
- (void)requestAliPaymentSignature:(NSString *)price subject:(NSString *)subject outTradeNo:(NSString *)outTradeNo body:(NSString *)body {
    NSString *URL_Str = [NSString stringWithFormat:@"%@/alipay/api/generateSignature",kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"body"] = body;
    URL_Dic[@"subject"]=subject;
    URL_Dic[@"outTradeNo"]=outTradeNo;
    URL_Dic[@"totalAmount"] = price;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block ConfirmOrderVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"requestPaymentSignature%@", responseObject);
        NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        [VC performSelector:@selector(delayMethod)];
        if ([str isEqualToString:@"1"]) {
            NSString *signature = responseObject[@"data"];
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            NSString *appScheme = @"shitibianScheme";
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:signature fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"DetermineBtnClick = %@",resultDic);
                NSNotification * notice = [NSNotification notificationWithName:@"return" object:nil userInfo:@{@"1":@"123"}];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
            }];
        }else {
            [self showAlert:@"订单提交失败请重试!"];
            NSNotification * notice = [NSNotification notificationWithName:@"return" object:nil userInfo:@{@"1":@"123"}];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"网络出现问题.请稍后再试!" time:1.0];
        NSLog(@"%@", error);
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

//显示网络加载指示器
- (void)indeterminateExample {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
}
//隐藏网络加载指示器
- (void)delayMethod{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
}

-(void)onResp:(BaseResp*)resp{  
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            caseWXSuccess:{
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
            }
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
}

@end
