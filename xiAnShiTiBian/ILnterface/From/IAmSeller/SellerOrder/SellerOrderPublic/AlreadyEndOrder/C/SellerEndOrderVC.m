//
//  SellerEndOrderVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerEndOrderVC.h"
#import "ShopOrderHeadTVCell.h"
#import "OrderGoodsTVCell.h"//订单里面的商品展示
#import "SellerOrderDiscountTVCell.h"
#import "OrderSelectionView.h"//订单选择view
#import "OrderTimeChooseView.h"//订单时间选择器
#import "OrderDiscountChoiceView.h"//订单类型选择器
@interface SellerEndOrderVC ()<UITableViewDelegate, UITableViewDataSource, OrderSelectionViewDelegate, OrderTimeChooseViewDelegate, OrderDiscountChoiceViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *DataArray;
/**
 *订单选择
 */
@property (nonatomic, strong)OrderSelectionView *orderSelectionView;
/**
 *订单折扣选择
 */
@property (nonatomic, strong)OrderDiscountChoiceView *orderDiscountChoiceView;

@property (nonatomic, strong)UIView *backImageView;//选择时间的背景颜色
/**
 *订单时间选择器
 */
@property (nonatomic, strong)OrderTimeChooseView *orderTimeChooseView;
@end

@implementation SellerEndOrderVC

- (NSMutableArray *)DataArray {
    if (!_DataArray) {
        _DataArray = [NSMutableArray array];
    }
    return _DataArray;
}

-(void)viewWillAppear:(BOOL)animated {

[self RequestOrderListData];
}
- (void)viewWillDisappear:(BOOL)animated {

    [self performSelector:@selector(delayMethod)];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"已完成的订单";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = MColor(238, 238, 238);
    [self creatTableView];
    
}

- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
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
    
    NSString *url_Str = [NSString stringWithFormat:@"%@/orderapi/seller_orderlist", kSHY_100];
    NSDictionary *url_Dic = @{@"memberId":[UserDataSingleton mainSingleton].userID,@"pageNo":@"0",@"pageSize":@"10",@"orderState":@"40",@"storeId":[UserDataSingleton mainSingleton].storeID, @"buyingPatternsName":@""};
    NSString *dataStr = [self dictionaryToJson:url_Dic];//吧字典转成字符串
    NSString *strURLOne = [dataStr stringByReplacingOccurrencesOfString:@" " withString:@""];//去掉字符串中的空格键
    NSString *strURLTwo = [strURLOne stringByReplacingOccurrencesOfString:@"\n" withString:@""];//去掉字符串中的回车键
    NSString *encryptDate=[SecurityUtil encryptAESData:strURLTwo];//加密
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    dataDic[@"request"] = encryptDate;//创建后台所需要的参数(加密后的)
    NSLog(@"url_Dic%@dataDic%@", url_Dic,dataDic);
    __block SellerEndOrderVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:url_Str parameters:dataDic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSString *resultsStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        NSLog(@"responseObject%@",responseObject);
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
            if ([orderKey isEqualToString:@"balanceState"]) {
                
            }else if([orderKey isEqualToString:@"orderGoodsList"]){//如果是商品对象
                NSArray *GoodsListArray = sellerOrderDic[orderKey];//商品展示数组
                NSMutableArray *goodsModelArr = [NSMutableArray array];//存储封装完成的商品model
                for (NSDictionary *GoodsDic in GoodsListArray) {
                    NSEntityDescription *des = [NSEntityDescription entityForName:@"SellerOrderGoodsModel" inManagedObjectContext:self.managedContext];
                    //根据描述 创建实体对象
                    SellerOrderGoodsModel *SellerGoodsModel = [[SellerOrderGoodsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                    for (NSString *goodsKey in GoodsDic) {//遍历商品数组
                        
                        if ([goodsKey isEqualToString:@"goodsReturnNum"]) {
                            
                        }else {
                            [SellerGoodsModel setValue:GoodsDic[goodsKey] forKey:goodsKey]; //给model对象赋值
                        }
                    }
                    [goodsModelArr addObject:SellerGoodsModel];//吧赋完值的对象放到数组里面
                }
                [SellerOrderModel setValue:goodsModelArr forKey:orderKey];//吧存有商品的数组放到订单model里面;
            }else {
                NSLog(@"orderKey%@",orderKey);
                if ([orderKey isEqualToString:@"goodsAmount"]||[orderKey isEqualToString:@"giftPoints"]) {
                    
                }else {
                    [SellerOrderModel setValue:sellerOrderDic[orderKey] forKey:orderKey];
                }
            }
        }
        [self.DataArray addObject:SellerOrderModel];
    }
    [self.tableView reloadData];
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[SellerOrderDiscountTVCell class] forCellReuseIdentifier:@"SellerOrderDiscountTVCell"];
    [_tableView registerClass:[ShopOrderHeadTVCell class] forCellReuseIdentifier:@"ShopOrderHeadTVCell"];
    [_tableView registerClass:[SellerOrderGoodsTVCell class] forCellReuseIdentifier:@"SellerOrderGoodsTVCell"];
    [self.view addSubview:_tableView];
}
#pragma mark OrderSelectionViewDelegate
//按照折扣选择订单
- (void)SelectDiscount {
    [self ChooseOrderDiscountClickEvent];
}
//按照时间选择订单
- (void)SelectOrderTime {
    [self ChooseOrderTimeClickEvent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.DataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.DataArray.count ==0 ) {
        return 3;
    }else {
    SellerOrderListModel *ListModel = self.DataArray[section];
        NSLog(@"------%@", ListModel);
    NSArray *goodsModelArray = (NSArray *)ListModel.orderGoodsList;
    return goodsModelArray.count  + 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerOrderListModel *ListModel = self.DataArray[indexPath.section];
    NSArray *goodsModelArray = (NSArray *)ListModel.orderGoodsList;
    if (indexPath.row == 0) {
        
        ShopOrderHeadTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopOrderHeadTVCell" forIndexPath:indexPath];
        cell.model = ListModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == goodsModelArray.count + 1){
        SellerOrderDiscountTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerOrderDiscountTVCell" forIndexPath:indexPath];
        cell.GoodsDiscountLabel.text = ListModel.createTimeStr;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        SellerOrderGoodsTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerOrderGoodsTVCell" forIndexPath:indexPath];
        cell.backgroundColor = MColor(238, 238, 238);

        cell.model = goodsModelArray[indexPath.row -1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    SellerOrderListModel *ListModel = self.DataArray[indexPath.section];
    NSArray *goodsModelArray = (NSArray *)ListModel.orderGoodsList;
    if (indexPath.row == 0) {
        return kFit(40);
    }else  if (indexPath.row == goodsModelArray.count+1) {
        return kFit(46);
    }else{
        return kFit(92.5);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return kFit(5);
    }else {
    return kFit(0.01);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kFit(5);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kFit(5))];
    view.backgroundColor = MColor(238, 238, 238);
    return view;
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

- (void)ChooseOrderDiscountClickEvent {
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
    
    self.orderDiscountChoiceView = [[OrderDiscountChoiceView alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(300))];
    
    _orderDiscountChoiceView.delegate = self;
    [topVC.view addSubview:_orderDiscountChoiceView];
    
    [UIView animateWithDuration:0.3 animations:^{
        _orderDiscountChoiceView.frame = CGRectMake(0, kScreen_heigth-kFit(200), kScreen_widht, kFit(200));
    }];

}
/**
 *订单时间选择器创建
 */
- (void)ChooseOrderTimeClickEvent{//
    
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
    
    self.orderTimeChooseView = [[OrderTimeChooseView alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(300))];
   
    _orderTimeChooseView.delegate = self;
    [topVC.view addSubview:_orderTimeChooseView];
    
    [UIView animateWithDuration:0.3 animations:^{
        _orderTimeChooseView.frame = CGRectMake(0, kScreen_heigth-kFit(200), kScreen_widht, kFit(200));
    }];
}
//让弹窗消失
-(void)hiddenView {
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _orderTimeChooseView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    [UIView animateWithDuration:0.3 animations:^{
        _orderDiscountChoiceView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    [_orderTimeChooseView removeFromSuperview];
    [_orderDiscountChoiceView removeFromSuperview];
}
//让弹窗消失
- (void)deselect {
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _orderTimeChooseView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    [UIView animateWithDuration:0.3 animations:^{
        _orderDiscountChoiceView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];

    [_orderTimeChooseView removeFromSuperview];
    [_orderDiscountChoiceView removeFromSuperview];
}

//让确定选择时间
- (void)ChooseOrderTime:(NSString *)sender {
    _orderSelectionView.timeLabel.text = sender;
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _orderTimeChooseView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    [_orderTimeChooseView removeFromSuperview];
}

- (void)ChooseDiscount:(NSString *)discount {
    [self.backImageView removeFromSuperview];
    _orderSelectionView.discountLabel.text = [NSString stringWithFormat:@"%@折", discount];
    [UIView animateWithDuration:0.3 animations:^{
        _orderDiscountChoiceView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    [_orderDiscountChoiceView removeFromSuperview];
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
