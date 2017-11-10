
//
//  MyViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/21.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "MyViewController.h"
#import "MyOrderCViewCell.h"//我的资料cell
#import "ToolCViewCell.h" //工具cell
#import "MyIntegralCViewCell.h"//积分cell
#import "SpecialListCViewCell.h"//横向cell
#import "GoodsRecCViewCell.h"//商品推荐
#import "IntegralRecordVC.h"//积分记录界面
#import "WithdrawRMBVC.h"//积分提现界面
#import "IDViewController.h"//积分说明功能

#import "LogInViewController.h"//登录界面
#import "MyGoodsCollVC.h"//我收藏的商品
#import "MyShopCollVC.h"//我收藏的商品
#import "MyIntegralVC.h"//我的积分界面
#import "MyOrderViewController.h"//我的订单
#import "SetUpViewController.h"//设置界面
#import "MyEvaluationVC.h"//我的评价界面
#import "MyShopVC.h"//我的店铺界面
#import "RegisteredEnteringVC.h"//注册商家界面
#import "MyFootprintVC.h"//我的足迹界面

#import "MyDriverVC.h"//老司机的主界面
#import "RegisteredAsDriverVC.h"//注册成为司机界面
//以下是弹出界面的功能
//存储用户登录信息. 默认没有登录
static  int UserState;

@interface MyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, MyOrderCViewCellDelegate,ToolCViewCellDelegate, MyIntegralCViewCellDelegate , SpecialListCViewCellDelegate>{
    
    NSInteger lastContentOffset;
}
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIView *TopView;//自定义导航条


/**
 *cocodata数据解析和保存对象
 */
@property (strong, nonatomic)AppDelegate *AppDelegate;
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong)NSMutableArray *urseDataArray;

//推荐商品列表
@property (nonatomic, strong)NSMutableArray *recommendGoodsArray;

@end

@implementation MyViewController
- (NSMutableArray *)recommendGoodsArray {
    if (!_recommendGoodsArray) {
        _recommendGoodsArray = [NSMutableArray array];
    }
    return _recommendGoodsArray;
}
- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {
        //获取Appdelegate对象
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.managedContext = delegate.managedObjectContext;
    }
    return _managedContext;
}
- (AppDelegate *)AppDelegate {
    if (!_AppDelegate) {
        _AppDelegate = [[AppDelegate alloc] init];
    }
    return _AppDelegate;
}
- (NSMutableArray *)urseDataArray {
    if (!_urseDataArray) {
        _urseDataArray = [NSMutableArray array];
    }
    return  _urseDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kNavigation_Color;
    [self goodsRecommendDataRequest];
    [self setCollectionView];
    
}
//获取用户信息  如果里面是空的代表用户还没有登录
- (void)AnalysisUserData{
    [self.urseDataArray removeAllObjects];
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSLog(@"paths%@", paths);
    NSString *plistPath = [paths objectAtIndex:0];
    NSString *filename=[plistPath stringByAppendingPathComponent:@"UserLogInData.plist"];
    NSMutableDictionary *userData = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSArray *keyArray =[userData allKeys];
    if (keyArray.count == 0) {
    }else {

        NSEntityDescription *des = [NSEntityDescription entityForName:@"UserDataModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        UserDataModel *model = [[UserDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];

        for (NSString *key in userData) {
            if ([key isEqualToString:@"memberId"]) {
                [UserDataSingleton mainSingleton].userID = userData[key];
            }
            [model setValue:userData[key] forKey:key];
        }
        [self.urseDataArray addObject:model];
        
    }
    NSLog(@"self.urseDataArray%@", self.urseDataArray);
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self AnalysisUserData];
    [super.navigationController setNavigationBarHidden:YES];
    UserState = 0;
}

//商品推荐数据请求
- (void)goodsRecommendDataRequest{
    //  [self performSelector:@selector(indeterminateExample)];
    
    NSString *str=[NSString stringWithFormat:@"%@/goods/api/findRecommendGoods", kSHY_100];
    NSLog(@"goodsRecommendDataRequest%@", str);
    
    
    __block MyViewController *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        [_collectionView.mj_footer endRefreshing];
        //   NSLog(@"goodsRecommendDataRequest%@", responseObject);
        NSString *stateStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([stateStr isEqualToString:@"1"]) {
            [VC AnalyticalRecommendGoodsData:responseObject];
        }else {
            [VC showAlert:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_collectionView.mj_footer endRefreshing];
        [VC showAlert:@"网络有问题请重试!"];
    }];
}
//商品推荐数据解析
- (void)AnalyticalRecommendGoodsData:(NSDictionary *)data {
    [self.recommendGoodsArray removeAllObjects];
    NSArray *array = data[@"data"];
    // [self managedContext];
    for (NSDictionary *dataDic in array) {//获取商品
        NSLog(@"self.managedContext%@", self.managedContext);
        NSEntityDescription *des = [NSEntityDescription entityForName:@"GoodsDetailsModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        GoodsDetailsModel *GDModel = [[GoodsDetailsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        NSDictionary *goodsDetailsDic = dataDic[@"goods"];
        for (NSString *key in goodsDetailsDic) {//获取商品里面参数
                [GDModel setValue:goodsDetailsDic[key] forKey:key];
        }
        [self.recommendGoodsArray addObject:GDModel];
    }
    
    [self.collectionView reloadData];
}

- (UIStatusBarStyle)preferredStatusBarStyle { //改变状态条颜色

    return UIStatusBarStyleLightContent;

}
//判断窗口是否出现
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
        CGFloat  y =scrollView.contentOffset.y;
    
        static CGFloat a = 0.01;
        if ( y > 90 ) {//上啦
            
            if ((y > 0) && a<0.9) {
                a =(0.01 * y) ;
                [UIView animateWithDuration: 0.2 animations:^{
                    self.TopView.alpha = a;
                }];
            }
        }
        
        if(y < 90) {//下拉
            
            if (y < 90 && a>0) {
                a = 0.01 * y;
                self.TopView.alpha = a;
                lastContentOffset =scrollView.contentOffset.y;
            }
        }
        if (scrollView.contentOffset.y < (kScreen_widht/ 15.000000) * 2) {
            self.TopView.alpha = 0;
        }
    

}
//创建集合视图
- (void)setCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //添加页眉
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = kFit(3);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) collectionViewLayout:layout];
    _collectionView .dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.bounces = NO;
    _collectionView.mj_footer = [MJRefreshFooter  footerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    self.collectionView.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [_collectionView registerClass:[MyOrderCViewCell class] forCellWithReuseIdentifier:@"MyOrderCViewCell"];
    [_collectionView registerClass:[ToolCViewCell class] forCellWithReuseIdentifier:@"ToolCViewCell"];
    [_collectionView registerClass:[MyIntegralCViewCell class] forCellWithReuseIdentifier:@"MyIntegralCViewCell"];
    [_collectionView registerClass:[SpecialListCViewCell class] forCellWithReuseIdentifier:@"SpecialListCViewCell"];
    [_collectionView registerClass:[GoodsRecCViewCell class] forCellWithReuseIdentifier:@"GoodsRecCViewCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    [self.view addSubview:_collectionView];
    CATransition *animation1 = [CATransition animation];
    animation1.duration = 0.2;
    animation1.type = kCATransitionMoveIn;
    animation1.subtype = kCATransitionFromTop;
    [self.TopView.layer addAnimation: animation1 forKey: nil];
    
    self.TopView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreen_widht, 84)];
    self.TopView.backgroundColor = kNavigation_Color;
    self.TopView.alpha = 0;
    // 70 24
    [self.view addSubview:self.TopView];
    
    UIButton *setUpBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [setUpBtn setTitle:@"设置" forState:(UIControlStateNormal)];
    setUpBtn.titleLabel.font = MFont(kFit(15));
    [setUpBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
    [setUpBtn addTarget:self action:@selector(handleSetUpBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:setUpBtn];
    setUpBtn.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, kFit(23)).widthIs(kFit(54)).heightIs(kFit(39));
    
    UIButton *messageBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//去除导航条上图片的渲染色
    
    UIImage *buttonimage = [UIImage imageNamed:@"hd"];
    //[tapButton setImage:buttonimage forState:(UIControlStateNormal)];
    //设置图像渲染方式
    buttonimage = [buttonimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    
    [messageBtn setImage:buttonimage forState:(UIControlStateNormal)];
    [messageBtn addTarget:self action:@selector(handleSetUpBtn:) forControlEvents:(UIControlEventTouchUpInside)];
   // [self.view addSubview:messageBtn];
    messageBtn.sd_layout.rightSpaceToView(self.view, 0).topSpaceToView(self.view, kFit(16)).widthIs(kFit(54)).heightIs(kFit(39));

}

- (void)handleSetUpBtn:(UIButton *)sender {
    if (self.urseDataArray.count == 0) {
        LogInViewController *VC = [[LogInViewController alloc] init];
        UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
        [self presentViewController:NAVC animated:YES completion:nil];
    }else {
        SetUpViewController *VC = [[SetUpViewController alloc] init];
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 4) {
        return self.recommendGoodsArray.count;
    }else {
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        MyOrderCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyOrderCViewCell" forIndexPath:indexPath];
        if (self.urseDataArray.count != 0) {
            cell.model = self.urseDataArray[0];
        }else {
            [cell SetDefaultValue];
        }
        cell.delegate = self;
        return cell;
    }else if(indexPath.section == 1) {
        ToolCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ToolCViewCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else if(indexPath.section == 2){
        MyIntegralCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyIntegralCViewCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else if(indexPath.section ==3){
        SpecialListCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SpecialListCViewCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else {
        GoodsDetailsModel *model = self.recommendGoodsArray[indexPath.row];
        GoodsRecCViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsRecCViewCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 4) {
        GoodsDetailsModel *model = self.recommendGoodsArray[indexPath.row];
        GoodsDetailsVController *VC = [[GoodsDetailsVController alloc] init];
        VC.goodsID = model.goodsId;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }

}
//订单点击事件  160
- (void)MyOrderChoose:(int)index {
    
    if (index == 311) {
        if (self.urseDataArray.count != 0) {
            SetUpViewController *VC = [[SetUpViewController alloc] init];
            [VC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:VC animated:YES];
        }else {
            LogInViewController *VC = [[LogInViewController alloc] init];
            UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
            [self presentViewController:NAVC animated:YES completion:nil];
        }
        
        
    }else if (index == 313) {
    
    } else if (self.urseDataArray.count == 0) {
        UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示!" message:@"您还没有登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            LogInViewController *VC = [[LogInViewController alloc] init];
            UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
            [self presentViewController:NAVC animated:YES completion:nil];
        }];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"不用了我再看看" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        // 3.将“取消”和“确定”按钮加入到弹框控制器中
        [alertV addAction:cancle];
        [alertV addAction:confirm];
        // 4.控制器 展示弹框控件，完成时不做操作
        [self presentViewController:alertV animated:YES completion:^{
            nil;
        }];

    }else {
    
    if (index == 160) {
        MyOrderViewController *VC = [[MyOrderViewController alloc] init];
        VC.index = 0;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (index == 161) {
        MyOrderViewController *VC = [[MyOrderViewController alloc] init];
        VC.index = 2;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (index == 162) {
        MyOrderViewController *VC = [[MyOrderViewController alloc] init];
        VC.index = 3;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (index == 163) {
        MyOrderViewController *VC = [[MyOrderViewController alloc] init];
        VC.index = 4;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (index == 164) {
        MyOrderViewController *VC = [[MyOrderViewController alloc] init];
        VC.index = 5;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
        }
    }
}
//工具栏点击事件  170
-(void)ToolChoose:(int)index {
    if (self.urseDataArray.count == 0) {
        UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示!" message:@"您还没有登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            LogInViewController *VC = [[LogInViewController alloc] init];
            UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
            [self presentViewController:NAVC animated:YES completion:nil];
        }];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"不用了我再看看" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        // 3.将“取消”和“确定”按钮加入到弹框控制器中
        [alertV addAction:cancle];
        [alertV addAction:confirm];
        // 4.控制器 展示弹框控件，完成时不做操作
        [self presentViewController:alertV animated:YES completion:^{
            nil;
        }];
        
    }else{
    switch (index) {
        case 170:{
            MyGoodsCollVC *VC = [[MyGoodsCollVC alloc] init];
            [VC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 171:{
            MyShopCollVC *VC = [[MyShopCollVC alloc] init];
            [VC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 172:{
            MyEvaluationVC *VC = [[MyEvaluationVC alloc] init];
            [VC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 173:{
          UserDataModel *model = self.urseDataArray[0];
            MyFootprintVC *VC = [[MyFootprintVC alloc] init];
            [VC setHidesBottomBarWhenPushed:YES];
            VC.AppKey = model.appKey;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 174:{
            MyIntegralVC *VC = [[MyIntegralVC alloc] init];
            [VC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        default:
            break;
        }
    }
}
//我的积分点击事件 180
-(void)MyIntegraChoose:(int)index {
    
    if ([UserDataSingleton mainSingleton].userID.length == 0) {
        UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示!" message:@"您还没有登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            LogInViewController *VC = [[LogInViewController alloc] init];
            UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
            [self presentViewController:NAVC animated:YES completion:nil];
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"不用了我再看看" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        // 3.将“取消”和“确定”按钮加入到弹框控制器中
        [alertV addAction:cancle];
        [alertV addAction:confirm];
        // 4.控制器 展示弹框控件，完成时不做操作
        [self presentViewController:alertV animated:YES completion:^{
            nil;
        }];
    }else {
    UserDataModel *model = self.urseDataArray[0];
    NSLog(@"我的积分点击事件%d", index);
    if (index == 181) {
        IntegralRecordVC *VC = [[IntegralRecordVC alloc] init];
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (index == 180) {
        WithdrawRMBVC *VC = [[WithdrawRMBVC alloc] init];
        [VC setHidesBottomBarWhenPushed:YES];
        VC.membersID = model.memberId;
        VC.integralStr = model.memberRankPoints;
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        IDViewController *VC = [[IDViewController alloc] init];
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }
    }
}
//我是车主 我是商家 客服点击事件
- (void)managementFunctionClick:(int)index {

    if (self.urseDataArray.count == 0) {
        UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示!" message:@"您还没有登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            LogInViewController *VC = [[LogInViewController alloc] init];
            UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
            [self presentViewController:NAVC animated:YES completion:nil];
        }];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"不用了我再看看" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        // 3.将“取消”和“确定”按钮加入到弹框控制器中
        [alertV addAction:cancle];
        [alertV addAction:confirm];
        // 4.控制器 展示弹框控件，完成时不做操作
        [self presentViewController:alertV animated:YES completion:^{
            nil;
        }];
    }else {
        switch (index) {
            case 150:{
                [self requestDriverData];
            }
            break;
        case 151:{
            if ([UserDataSingleton mainSingleton].storeID.length < 2) {
                [self showAlert:@"您还不是商家,请到官网进行申请"];
            }else {
                MyShopVC *VC = [[MyShopVC alloc] init];//商家界面
                [VC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:VC animated:YES];
            }
        }
            break;
        case 152:{
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",@"13746712075"]]];
            });
            
        }
            break;
            
        default:
            break;
    }
    
    }
}
/**
 *请求司机数据
 */
- (void)requestDriverData {

    NSString *URL_Str = [NSString stringWithFormat:@"%@/carowner/api/diverMessage",kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"memberId"] = [UserDataSingleton mainSingleton].userID;
    NSLog(@"请求司机数据%@",URL_Dic);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block MyViewController *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];

        if ([resultStr isEqualToString:@"1"]) {
            MyDriverVC *VC = [[MyDriverVC alloc] init];//司机界面
            [VC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:VC animated:YES];
        }else {
            RegisteredAsDriverVC *VC = [[RegisteredAsDriverVC alloc] init];//司机注册界面
            [VC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:VC animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        
        NSLog(@"error%@",error);
    }];
    
}
//返回cell的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
         return CGSizeMake(kScreen_widht, kFit(315));
    }else if (indexPath.section == 1){
        return CGSizeMake(kScreen_widht, kFit(154));
    }else if(indexPath.section == 2) {
         return CGSizeMake(kScreen_widht, kFit(154));
    }else if(indexPath.section == 3){
        return CGSizeMake(kScreen_widht, kFit(150));
    }else {
        return CGSizeMake((kScreen_widht-3)/2, kFit(259));
    }
}
//返回页眉视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (indexPath.section == 4) {
        
        UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        UILabel *leftLine = [UILabel new];
        leftLine.backgroundColor = MColor(161, 161, 161);
        [headerView addSubview:leftLine];
        leftLine.sd_layout.leftSpaceToView(headerView, kFit(12)).centerYEqualToView(headerView).widthIs(kFit(115)).heightIs(0.5);
        //------
        UIButton *ioncBtn = [UIButton new];
        UIImage *buttonimage = [UIImage imageNamed:@"sptj"];
        //设置图像渲染方式        buttonimage = [buttonimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [ioncBtn setImage:buttonimage forState:(UIControlStateNormal)];
        [headerView addSubview:ioncBtn];
        ioncBtn.sd_layout.leftSpaceToView(leftLine, kFit(15)).topSpaceToView(headerView, 0).bottomSpaceToView(headerView, 0).widthIs(kFit(24));
        //-------
        UILabel *titleLabel = [UILabel new];  titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.text = @"热门推荐";         titleLabel.font = MFont(kFit(15));
        [headerView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(ioncBtn, kFit(5)).topSpaceToView(headerView, 0).bottomSpaceToView(headerView, 0).widthIs(kFit(70));
        
        UILabel *rightLine = [UILabel new];
        rightLine.backgroundColor = MColor(161, 161, 161);
        [headerView addSubview:rightLine];
        rightLine.sd_layout.rightSpaceToView(headerView, kFit(12)).centerYEqualToView(headerView).widthIs(kFit(115)).heightIs(0.5);
        
        reusableview = headerView;
        return reusableview;

    }else {

        UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, 10)];
        view.backgroundColor = MColor(238, 238, 238);
        [headerView addSubview:view];
        return headerView;
    }
   
}

//单独返回每一个页眉视图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 4) {
        return CGSizeMake(kScreen_widht, 40);
    }if (section == 0) {
        return CGSizeMake(0, -20);
    }else {
        return CGSizeMake(kScreen_widht, 10);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//显示网络加载指示器
- (void)indeterminateExample {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
}
//隐藏网络加载指示器
- (void)delayMethod{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
    self.collectionView.mj_footer.automaticallyHidden = YES;
}

- (void)refresh {
    
    [self goodsRecommendDataRequest];

    
}



@end
