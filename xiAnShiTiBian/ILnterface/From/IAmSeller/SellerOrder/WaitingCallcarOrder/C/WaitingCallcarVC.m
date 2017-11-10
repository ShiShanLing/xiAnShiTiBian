
//
//  WaitingCallcarVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "WaitingCallcarVC.h"
#import "ShopOrderHeadTVCell.h"
#import "OrderGoodsTVCell.h"//订单里面的商品展示
#import "ShopOrderEditTVCell.h"
#import "IWantCallCarVC.h"
#import "SpecifydriverCallCarVC.h"
@interface WaitingCallcarVC ()<UITableViewDelegate, UITableViewDataSource, ShopOrderEditTVCellDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *DataArray;

@property (nonatomic, strong)NSManagedObjectContext *managedContext;

@property (nonatomic, strong)AppDelegate *delegate;

@property (readonly, strong, nonatomic)NSManagedObjectContext *nanagedObjectContext;
@end

@implementation WaitingCallcarVC

- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedContext = delegate.managedObjectContext;
    }
    return _managedContext;
}
- (AppDelegate *)delegate {
    if (_delegate) {
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self RequestOrderListData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"待叫车";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = [UIColor orangeColor];
    [self creatTableView];
    
}
- (NSString*)dictionaryToJson:(NSDictionary *)dic //字典转字符串
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//请求接口
- (void)RequestOrderListData {
    
    [self performSelector:@selector(indeterminateExample)];
    NSString *url_Str = [NSString stringWithFormat:@"%@/orderapi/seller_orderlist", kSHY_100];
    
    NSDictionary *url_Dic = @{@"memberId":[UserDataSingleton mainSingleton].userID,@"pageNo":@"0",@"pageSize":@"10",@"orderState":@"20",@"storeId":[UserDataSingleton mainSingleton].storeID, @"buyingPatternsName":@""};
    NSString *dataStr = [self dictionaryToJson:url_Dic];//吧字典转成字符串
    NSString *strURLOne = [dataStr stringByReplacingOccurrencesOfString:@" " withString:@""];//去掉字符串中的空格键
    NSString *strURLTwo = [strURLOne stringByReplacingOccurrencesOfString:@"\n" withString:@""];//去掉字符串中的回车键
    NSString *encryptDate=[SecurityUtil encryptAESData:strURLTwo];//加密
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    dataDic[@"request"] = encryptDate;//创建后台所需要的参数(加密后的)
    __block WaitingCallcarVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:url_Str parameters:dataDic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSString *resultsStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultsStr isEqualToString:@"1"]) {
            [VC AnalyticalSellerOrderListData:responseObject[@"data"]];
        }else {
            [VC showAlert:@"获取失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self performSelector:@selector(delayMethod)];
        [VC showAlert:@"网络有问题.请检查问题"];
    }];
}
//解析数据 -- 封装model
- (void)AnalyticalSellerOrderListData:(NSString *)dataStr {
    [self.DataArray removeAllObjects];
    NSString *nameData=[SecurityUtil decryptAESData:dataStr];
    //字符串转字典
    NSData *data = [nameData dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *tempDictQueryDiamond = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"tempDictQueryDiamond%@", tempDictQueryDiamond);
    [self managedContext];
    for (NSDictionary *sellerOrderDic in tempDictQueryDiamond) {
        NSEntityDescription *des = [NSEntityDescription entityForName:@"SellerOrderListModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        SellerOrderListModel *SellerOrderModel = [[SellerOrderListModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        
        for (NSString *orderKey in sellerOrderDic) {
            // NSLog(@"sellerOrderDic[orderKey]%@orderKey%@", sellerOrderDic[orderKey], orderKey);
            if ([orderKey isEqualToString:@"KeybalanceState"]) {
                
            }else if([orderKey isEqualToString:@"orderGoodsList"]){//如果是商品对象
                
                NSArray *GoodsListArray = sellerOrderDic[orderKey];//商品展示数组
                
                NSMutableArray *goodsModelArr = [NSMutableArray array];//存储封装完成的商品model
                for (NSDictionary *GoodsDic in GoodsListArray) {
                    NSEntityDescription *des = [NSEntityDescription entityForName:@"SellerOrderGoodsModel" inManagedObjectContext:self.managedContext];
                    //根据描述 创建实体对象
                    SellerOrderGoodsModel *SellerGoodsModel = [[SellerOrderGoodsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                    for (NSString *goodsKey in GoodsDic) {//遍历商品数SellerOrderGoodsModel组
                        if ([goodsKey isEqualToString:@"goodsReturnNum"]) {
                            
                        }else {
                            [SellerGoodsModel setValue:GoodsDic[goodsKey] forKey:goodsKey]; //给model对象赋值
                        }
                    }
                    [goodsModelArr addObject:SellerGoodsModel];//吧赋完值的对象放到数组里面
                }
                [SellerOrderModel setValue:goodsModelArr forKey:orderKey];//吧存有商品的数组放到订单model里面;
            }else {
                [SellerOrderModel setValue:sellerOrderDic[orderKey] forKey:orderKey];
            }
        }
        [self.DataArray addObject:SellerOrderModel];
    }
    [self.tableView reloadData];
}
- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_tableView registerClass:[ShopOrderHeadTVCell class] forCellReuseIdentifier:@"ShopOrderHeadTVCell"];
    [_tableView registerClass:[SellerOrderGoodsTVCell class] forCellReuseIdentifier:@"SellerOrderGoodsTVCell"];
    [_tableView registerClass:[ShopOrderEditTVCell class] forCellReuseIdentifier:@"ShopOrderEditTVCell"];
    [self.view addSubview:_tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.DataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    SellerOrderListModel *model = self.DataArray[section];
    NSArray *array = (NSArray *)model.orderGoodsList;
    return array.count + 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerOrderListModel *model = self.DataArray[indexPath.section];
    NSArray *GoodsArray = (NSArray *)model.orderGoodsList;
    if (indexPath.row == 0) {
        ShopOrderHeadTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopOrderHeadTVCell" forIndexPath:indexPath];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == GoodsArray.count+1) {
        ShopOrderEditTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopOrderEditTVCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        cell.delegate = self;
        return cell;
    }else {
        SellerOrderGoodsTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerOrderGoodsTVCell" forIndexPath:indexPath];
        cell.backgroundColor = MColor(238, 238, 238);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = GoodsArray[indexPath.row - 1];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerOrderListModel *model = self.DataArray[indexPath.section];
    NSArray *GoodsArray = (NSArray *)model.orderGoodsList;
    
    if (indexPath.row != 0 && indexPath.row !=  GoodsArray.count+1) {
        
        GoodsDetailsVController *VC = [[GoodsDetailsVController alloc] init];
        SellerOrderGoodsModel *model = GoodsArray[indexPath.row - 1];
        VC.goodsID = model.goodsId;
        [self.navigationController pushViewController:VC animated:YES];
        
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerOrderListModel *model = self.DataArray[indexPath.section];
    NSArray *GoodsArray = (NSArray *)model.orderGoodsList;
    if (indexPath.row == 0) {
        return kFit(40);
    }else if (indexPath.row == GoodsArray.count + 1) {
        return kFit(50);
    }else {
        return kFit(92.5);
    }
}
/**
 *我要叫车
 */
- (void)IWantCallCar:(OrderBtn *)sender {
   
   
   
    IWantCallCarVC *VC = [[IWantCallCarVC alloc] init];
    SellerOrderListModel *model = self.DataArray[sender.indexPath.section];
    VC.model = model;
    [self.navigationController pushViewController:VC animated:YES];
    
}
/**
 *已经叫过车了
 */
- (void)haveAlreadyCalledCar:(OrderBtn *)sender {
    SpecifydriverCallCarVC *VC = [[NSBundle mainBundle] loadNibNamed:@"SpecifydriverCallCarVC" owner:nil options:nil].lastObject;
    SellerOrderListModel *model = self.DataArray[sender.indexPath.section];
    VC.model = model;
    [self.navigationController pushViewController:VC animated:YES];

}

//网络加载指示器
- (void)indeterminateExample {
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
    
}

- (void)delayMethod{
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
    
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
