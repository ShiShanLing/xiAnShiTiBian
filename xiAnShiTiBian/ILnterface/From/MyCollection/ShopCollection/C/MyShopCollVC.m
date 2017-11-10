//
//  MyShopCollVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/7.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MyShopCollVC.h"
#import "ShopCollTVCell.h"//我收藏的店铺
#import "ShopHotTVCell.h"//推荐的店铺
#import "GoodsCollEditorView.h"
#import "SimilarShopVC.h"//更多相似的店铺界面
#import "StoreCollectModel+CoreDataProperties.h"
@interface MyShopCollVC ()<UITableViewDelegate, UITableViewDataSource, ShopCollTVCellDelegate, GoodsCollEditorViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
/**
 *点击编辑时的背景
 */
@property (nonatomic, strong)UIView *backImageView1;
/**
 *点击编辑时的弹窗
 */
@property (nonatomic, strong)GoodsCollEditorView *PopView;

/**
 *存储收藏的店铺数组
 */
@property (nonatomic, strong)NSMutableArray *StoreCollecArray;

@end

@implementation MyShopCollVC

- (NSMutableArray *)StoreCollecArray {
    if (!_StoreCollecArray) {
        _StoreCollecArray = [NSMutableArray array];
    }
    return _StoreCollecArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestCollectionShopsData];
    self.navigationItem.title = @"收藏的店铺";
    //导航条配置
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ShopCollTVCell class] forCellReuseIdentifier:@"ShopCollTVCell"];
    [self.tableView registerClass:[ShopHotTVCell class] forCellReuseIdentifier:@"ShopHotTVCell"];
    [self.view addSubview:_tableView];

}
//请求收藏店铺
- (void)requestCollectionShopsData{
    NSString *URL_Str = [NSString stringWithFormat:@"%@/memberapi/memberfavotites", kSHY_100];
    NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
    URL_DIC[@"memberId"] = [UserDataSingleton mainSingleton].userID;
    URL_DIC[@"pageNo"] = @"1";//第几页
    URL_DIC[@"pageSize"] = @"100";//一页多少个
    URL_DIC[@"type"] = @"2";
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block MyShopCollVC *VC = self;
    [session POST:URL_Str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@", responseObject);
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC showAlert:@"获取数据成功"];
            [VC parsingCollectionShopsData:responseObject[@"data"]];
        }else {
            [VC showAlert:@"获取数据失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showAlert:@"网络超时请重试"];
        NSLog(@"error%@",error);
    }];
}

- (void)parsingCollectionShopsData:(NSArray *)ShopsArray {
    [self.StoreCollecArray removeAllObjects];
    for (NSDictionary *storeDic in ShopsArray) {
        NSEntityDescription *des = [NSEntityDescription entityForName:@"StoreCollectModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        StoreCollectModel *model = [[StoreCollectModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        for (NSString *storeKey in storeDic) {
            NSLog(@"storeDic[storeKey] %@ --- storeKey %@",storeDic[storeKey],storeKey);
            if ([storeKey isEqualToString:@"store"]) {
                for (NSString *key  in storeDic[storeKey]){
                    NSLog(@"storeDic[storeKey][key] %@ --- key %@", storeDic[storeKey][key], key);
                    [model setValue:storeDic[storeKey][key] forKey:key];
                }
            }
            [model setValue:storeDic[storeKey] forKey:storeKey];
        }
        [self.StoreCollecArray addObject:model];
        NSLog(@"parsingCollectionShopsData%@", model);
    }
    [self.tableView reloadData];
}
- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated {

    [super.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
//返回分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return _StoreCollecArray.count;
    
}
//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopCollTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCollTVCell" forIndexPath:indexPath];
    cell.model = _StoreCollecArray[indexPath.row];
    [cell EditButtonTagAssignment:indexPath];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (void)similarShop:(UIButton *)sender {
    NSLog(@"第%ld个商品", sender.tag / 100);
    
    SimilarShopVC *VC = [[SimilarShopVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return kFit(75);
}

#pragma mark ShopCollTVCellDelegate
- (void)collShopEditor:(UIButton *)sender {
    NSLog(@"你点击的是第%ld", sender.tag);
    
    [self ShoppingCellClickEvent:sender.tag];
    
}
- (UIViewController *)appRootViewController{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
- (void)ShoppingCellClickEvent:(NSInteger )index{//
    
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
    
    self.PopView = [[GoodsCollEditorView alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(145))];
    self.PopView.tag = index;
    _PopView.delegate = self;
    [topVC.view addSubview:self.PopView];
    
    [UIView animateWithDuration: 0.2 animations:^{
        
        self.PopView.frame =CGRectMake(0, kScreen_heigth - kFit(145), kScreen_widht, kFit(145));
        
    }];
}

#pragma mark  GoodsCollEditorViewDelegate
/**
 *删除收藏的商品
 */
- (void)deleteBtnClick:(GoodsCollEditorView *)view {
    
    [self.backImageView1 removeFromSuperview];
    [UIView animateWithDuration: 0.2 animations:^{
        self.PopView.frame =CGRectMake(0, kScreen_heigth * 2, kScreen_widht, kFit(145));
    }];
    
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/storeapi/storecollection", kSHY_100];
    StoreCollectModel *model = _StoreCollecArray[view.tag];
    
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"storeId"] = model.storeId;
    URL_Dic[@"memberId"] =[UserDataSingleton mainSingleton].userID;
    URL_Dic[@"favType"] = @"2";
    URL_Dic[@"goodsId"] = @"";

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __weak MyShopCollVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@", responseObject);
        [VC showAlert:responseObject[@"msg"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@", error);
    }];
    
}
/**
 *进入商店
 */
- (void)EnterShopBtnClick:(GoodsCollEditorView *)view {
    
    [self.backImageView1 removeFromSuperview];
    
    [UIView animateWithDuration: 0.2 animations:^{
        self.PopView.frame =CGRectMake(0, kScreen_heigth * 2, kScreen_widht, kFit(145));
    }];
    StoreViewController *VC = [[StoreViewController alloc] init];
    StoreCollectModel *model = _StoreCollecArray[view.tag];
    VC.storeStr = model.storeId;
    [self.navigationController pushViewController:VC animated:YES];
    
}
/**
 *取消
 */
- (void)cancelBtnClick {
    [self.backImageView1 removeFromSuperview];
    [UIView animateWithDuration: 0.2 animations:^{
        self.PopView.frame =CGRectMake(0, kScreen_heigth * 2, kScreen_widht, kFit(145));
    }];
    
}
- (void)hiddenView { //调用这个方法不保存选择的数值
    [self.backImageView1 removeFromSuperview];
    
    [UIView animateWithDuration: 0.2 animations:^{
        self.PopView.frame =CGRectMake(0, kScreen_heigth * 2, kScreen_widht, kFit(145));
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


@end
