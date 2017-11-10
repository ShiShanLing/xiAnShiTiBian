//
//  ShoppingCartVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/21.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ShoppingCartVC.h"

#import "MJExtension.h"
#import "ShopCartHeadViewCell.h"
#import "ShopCartGoodViewCell.h"
#import "bottomPriceView.h"
#import "MBProgressHUD+MJ.h"
#import "GoodsToolBar.h"
#import "YouLikeTableViewCell.h"
#import "ShoppingCartGoodsTVCell.h"
#import "ShoppingCartGoodsEditorTVCell.h"//商品编辑状态

#import "GoodsDetailsVController.h"
#import "ShoppingCartGoodsTVCell.h"
#import "ConfirmOrderVC.h"


#define goodsToolBarH 44

@interface ShoppingCartVC () <UITableViewDataSource, UITableViewDelegate,ShoppingCartGoodsTVCellDelegate, ShopCartHeadViewCellDelegate, bottomPriceViewDelegate, UITextFieldDelegate, GoodsToolBarDelegate, GuessLikeViewDelegate, ModifyNumberViewDelegate, ShoppingCartGoodsEditorTVCellDelegate, PopUpViewDelegate, YouLikeTableViewCellDelegate, NotLoggedInTableViewCellDelegate, NoInternetTVCellDelegate>
@property (weak, nonatomic) UITableView *tableView;
/**购物车的所有内容(商店和商品)*/
@property (nonatomic, strong) NSMutableDictionary *shopCartDic;
/**
 *存储商店商品编辑状态的数组
 */
@property (nonatomic, strong) NSMutableArray *goodsEditStateArray;

@property (nonatomic, strong) NSMutableArray *shopNameArray;
/**选着的商品*/
@property (nonatomic, strong) NSMutableArray *selectedArray;
/**选中的店铺*/
@property (nonatomic, strong) NSMutableArray *selectedStoreArr;
/**购物车每件商品的模型数组*/
@property (nonatomic, strong) NSMutableArray *modelArr;
/**总价格*/
@property (nonatomic, assign) double allSum;

@property (nonatomic, strong) GoodsToolBar *goodsToolBar;

/**
 *
 */
@property (nonatomic, strong)NSMutableArray *recommendGoodsArray;

@property (weak, nonatomic) UIBarButtonItem *barBtn;
/**
 *结算view  显示多少商品多少钱
 */
@property (nonatomic, strong) bottomPriceView *bottonView;
@property (weak, nonatomic) UITextField *countText;
@property (nonatomic, assign) NSInteger currentCount;
@property (nonatomic, strong) ShopCartModel *currentModel;
@property (nonatomic, strong) ShopCartGoodViewCell *currentCell;
@property (nonatomic, strong) UIScrollView *scrollView;
//下面两个是规格选择弹窗的视图
@property (nonatomic, strong)UIView *backImageView1;//规格选择弹出视图的背景色
@property (nonatomic, strong)PopUpView *popUpView;//规格选择view
/**
 *存储购物车内所有店铺数据的数组
 */
@property (nonatomic, strong)NSMutableArray *storeListArray;
/**
 *存储某一个商品的详情信息,,用来在规格弹窗里面显示
 */
@property (nonatomic, strong)NSMutableArray *GoodsDataArray;
/**
 *存储某一个商品的规格详情,用来在规格弹窗里面显示
 */
@property (nonatomic, strong)NSMutableArray *specDatabaseArray;
@end

@implementation ShoppingCartVC {
    /**
     *存储用户选择商品规格名字
     */
    NSMutableArray *typeNameArray;//
    /**
     *存储用户选择商品规格名字
     */
    NSMutableArray *typeIDArray;//
    NSInteger _goodsNum;
    NSString *typeID;
    /**
     *存储当前选择的cartID 用于判断各种情况
     */
    NSString *cartID;
    //存储 所选商品一共多少钱
    CGFloat goodsPrice;
}

- (NSMutableArray *)recommendGoodsArray {
    if (!_recommendGoodsArray) {
        _recommendGoodsArray = [NSMutableArray array];
    }
    return _recommendGoodsArray;
}
- (NSMutableArray *)goodsEditStateArray {
    if (!_goodsEditStateArray) {
        _goodsEditStateArray = [NSMutableArray array];
    }
    return _goodsEditStateArray;
}
- (NSMutableArray *)specDatabaseArray {
    if (!_specDatabaseArray) {
        _specDatabaseArray = [NSMutableArray array];
    }
    return _specDatabaseArray;
}
- (NSMutableArray *)GoodsDataArray {
    if (!_GoodsDataArray) {
        _GoodsDataArray = [NSMutableArray array];
    }
    return _GoodsDataArray;
}

- (NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray new];
    }
    return _modelArr;
}
- (NSMutableArray *)storeListArray {
    if (!_storeListArray) {
        _storeListArray = [NSMutableArray array];
    }
    return _storeListArray;
}
//一个key对应该商店的所有商品
- (NSMutableDictionary *)shopCartDic{
    if (!_shopCartDic) {
        _shopCartDic = [NSMutableDictionary new];
    }
    return _shopCartDic;
}
- (NSMutableArray *)shopNameArray{
    if (!_shopNameArray) {
        _shopNameArray = [NSMutableArray new];
    }
    return _shopNameArray;
}
/**被选中的商品*/
- (NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray new];
    }
    return _selectedArray;
}
/**被选中的店铺*/
- (NSMutableArray *)selectedStoreArr{
    if (!_selectedStoreArr) {
        _selectedStoreArr = [NSMutableArray new];
    }
    return _selectedStoreArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", 0.00];
    _bottonView.payStr = [NSString stringWithFormat:@"%d", 0];
    _bottonView.isSelectBtn = NO;
    [self ShoppingCartListData];
    [self goodsRecommendDataRequest];
    [self.storeListArray removeAllObjects];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self performSelector:@selector(delayMethod)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configurationNavigationBar];
    //[self ShoppingCartListData];//获取数据
    [self createTableView];
}
- (UIStatusBarStyle)preferredStatusBarStyle { //改变状态条颜色
    
    return UIStatusBarStyleLightContent;
    
}
//配置导航条
- (void)configurationNavigationBar {
    [self  preferredStatusBarStyle];
    self.navigationController.navigationBar.barTintColor = kNavigation_whrColor;//导航条颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color,NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];
    
    self.navigationItem.title = @"购物车";//导航条标题
    UIImage *CollectButtonimage = [UIImage imageNamed:@"morehs"];
    //[tapButton setImage:buttonimage forState:(UIControlStateNormal)];
    //设置图像渲染方式
    CollectButtonimage = [CollectButtonimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    //  UIBarButtonItem *CollectButtonItem = [[UIBarButtonItem alloc] initWithImage:CollectButtonimage style:UIBarButtonItemStylePlain target:self action:@selector(handleCollect)];//自定义导航条按钮
    //  self.navigationItem.rightBarButtonItems = @[CollectButtonItem];
}
//创建tableView
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SScreen_Width, SScreen_Height - kFit(50)) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[YouLikeTableViewCell class] forCellReuseIdentifier:@"YouLikeTableViewCell"];
    [tableView registerClass:[ShoppingCartGoodsTVCell class] forCellReuseIdentifier:@"ShoppingCartGoodsTVCell"];
    [tableView registerClass:[ShoppingCartGoodsEditorTVCell class] forCellReuseIdentifier:@"ShoppingCartGoodsEditorTVCell"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [tableView  registerNib:[UINib nibWithNibName:@"NotLoggedInTableViewCell" bundle:nil] forCellReuseIdentifier:@"NotLoggedInTableViewCell"];
    [tableView registerNib:[UINib nibWithNibName:@"NoInternetTVCell" bundle:nil] forCellReuseIdentifier:@"NoInternetTVCell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.bottonView = [[bottomPriceView alloc]initWithFrame:CGRectMake(0, SScreen_Height - kFit(50)-44, SScreen_Width, kFit(50))];
    self.bottonView.delegate = self;
    self.allSum = 0;
    [self.view addSubview:self.bottonView];
    
    
    GoodsToolBar *toolbar = [[GoodsToolBar alloc] initWithFrame:CGRectMake(0, kScreen_heigth- 100, SScreen_Width, goodsToolBarH)];
    toolbar.backgroundColor = MColor(230, 230, 230);
    toolbar.delegate = self;
    //  [self.view addSubview:toolbar];
    self.goodsToolBar = toolbar;
    
    // 监听通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
//更多
- (void)handleCollect {
    
    MessageViewController *VC = [[MessageViewController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
    
}
//显示网络加载指示器
- (void)indeterminateExample {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
}
//隐藏网络加载指示器
- (void)delayMethod{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
}
//编辑
- (void)editClick:(UIBarButtonItem *)sender {
    
    
}
#pragma mark  获取数据
- (void) ShoppingCartListData{
    
    if ([UserDataSingleton mainSingleton].userID.length == 0) {
        
    }else {
        
        [self performSelector:@selector(indeterminateExample)];
        
        NSString *str=[NSString stringWithFormat:@"%@/cartapi/cartList?memberId=%@&saveType=0", kSHY_100, [UserDataSingleton mainSingleton].userID];
        NSLog(@"ShoppingCartListData%@", str);
        __block ShoppingCartVC *VC = self;
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //  NSLog(@"购物车列表数据%@", responseObject);
            [VC performSelector:@selector(delayMethod)];
            [VC AnalyticalgCartListDetailsData:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [VC performSelector:@selector(delayMethod)];
            [VC showAlert:@"网络有问题请重试!"];
        }];
    }
}
//商品详情封装model
- (void)AnalyticalgCartListDetailsData:(NSDictionary *)dic {
    [self.storeListArray removeAllObjects];
    NSArray *storeArray = dic[@"data"];
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
                [self.goodsEditStateArray addObject:@"0"];
                for (int i = 0; i < goodsArray.count; i++) {
                    NSMutableDictionary *goodsDic = goodsArray[i];
                    NSEntityDescription *des = [NSEntityDescription entityForName:@"ShoppingCartGoodsModel" inManagedObjectContext:self.managedContext];
                    //根据描述 创建实体对象
                    ShoppingCartGoodsModel *goodsModel = [[ShoppingCartGoodsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                    //根据描述 创建实体对象
                    for (NSString *goodsKey in goodsDic) {
                        if ([goodsKey isEqualToString:@"storeId"] ||[goodsKey isEqualToString:@"saveType"]||[goodsKey isEqualToString:@"firstGcId"]) {
                        }else {
                            //   NSLog(@"goodsDic[goodsKey]--%@, goodsKey--%@", goodsDic[goodsKey], goodsKey);
                            if ([goodsKey isEqualToString:@"storeName"]) {
                                
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
                    //   NSLog(@"storeDic[sotreKey]--%@, sotreKey--%@", storeDic[sotreKey], sotreKey);
                    [storeModel setValue:storeDic[sotreKey] forKey:sotreKey];
                }
            }
        }
        [self.storeListArray addObject:storeModel];
    }
    
    [self.tableView reloadData];
}
#pragma mark - 监听方法
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        // Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y >= self.view.height) { //控制器view的高度
            self.goodsToolBar.y = self.view.height;
            //还原
        } else {
            self.goodsToolBar.y = keyboardF.origin.y - self.goodsToolBar.height;
            CGFloat setOff = self.goodsToolBar.y - CGRectGetMaxY(self.currentCell.frame) + self.tableView.contentOffset.y;
            if (setOff < 0) {
                self.tableView.y = setOff;
            }
            NSLog(@"%f, %f", self.tableView.y, CGRectGetMaxY(self.currentCell.frame));
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([UserDataSingleton mainSingleton].networkState == 0){
        return 1;
    }else {
        if (self.storeListArray.count != 0) {
            return (self.storeListArray.count + 1);
        }else{
            if (self.recommendGoodsArray.count <=1) {
                return 1;
            }else {
                return 2;
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.storeListArray.count != 0) {
        if (self.storeListArray.count != section) {
            //   NSLog(@"numberOfRowsInSection--%@", self.storeListArray);
            ShoppingCartStoreModel *model = self.storeListArray[section];//获取第几个section下的店铺model
            NSArray *goodsArr = model.list;//获取店铺下的商品数组
            return goodsArr.count + 1;//返货商品数量 + 1(商品标题)的数量
        }else{
            //猜你喜欢
            return self.recommendGoodsArray.count/2;
        }
    }else{
        if (section == 0) {
            //空空如也\网络异常
            return 1;
        }else{
            //猜你喜欢
            return self.recommendGoodsArray.count/2;
        }
    }
    
}
#pragma mark 返回cell的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.storeListArray.count != 0) {
        if (indexPath.section != self.storeListArray.count) {//如果不是热门推荐
            ShoppingCartStoreModel *storeModel = self.storeListArray[indexPath.section];//获取第几个section下的店铺model
            NSString *storeStare =  self.goodsEditStateArray[indexPath.section];
            if (indexPath.row == 0) {//商店头
                static NSString *ID = @"shopCartHeadCell";
                ShopCartHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
                [cell ControlsAssignment:indexPath];
                if (!cell) {
                    cell = [[ShopCartHeadViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.delegate = self;
                }
                cell.model = storeModel;
                if ([storeStare isEqualToString:@"1"]) {
                    cell.editorBtn.selected = NO;
                }else {
                    cell.editorBtn.selected = YES;
                }
                return cell;
            }else{//商品
                
                NSArray *goodsArray = (NSArray *)storeModel.list;
                ShoppingCartGoodsModel *goodsModel = goodsArray[indexPath.row - 1];
                BOOL judgeNum;
                if (indexPath.row == goodsArray.count) {
                    judgeNum = YES;
                }else {
                    judgeNum = NO;
                }
                if ([storeStare isEqualToString:@"1"]) {//如果是YES那商品就是在被编辑状态
                    ShoppingCartGoodsEditorTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartGoodsEditorTVCell" forIndexPath:indexPath];
                    [cell ControlsAssignment:indexPath subscript:judgeNum];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.model = goodsModel;
                    cell.delegate = self;
                    cell.ModifyNumberView.indexPath = indexPath;
                    cell.ModifyNumberView.delegate = self;
                    cell.ModifyNumberView.numberTF.text = [NSString stringWithFormat:@"%hd", goodsModel.goodsNum];
                    cell.backgroundColor = [UIColor whiteColor];
                    return cell;
                }else {//否则就是没有被编辑
                    ShoppingCartGoodsTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartGoodsTVCell"  forIndexPath:indexPath];
                    [cell ControlsAssignment:indexPath subscript:judgeNum];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    //  NSLog(@"cellForRowAtIndexPath%@", self.storeListArray);
                    cell.model = goodsModel;
                    cell.delegate = self;
                    cell.backgroundColor = [UIColor whiteColor];
                    
                    //给GuessYouLike的model
                    return cell;
                }
            }
        }else{//猜你喜欢
            
            GoodsDetailsModel *modelL = self.recommendGoodsArray[indexPath.row*2];
            GoodsDetailsModel *modelR = self.recommendGoodsArray[indexPath.row*2 + 1];
            YouLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YouLikeTableViewCell"  forIndexPath:indexPath];
            [cell grantLikeViewAddCode:indexPath];
            cell.delegate = self;
            cell.modelL = modelL;
            cell.modelR = modelR;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        if (indexPath.section == 0) {
            
            if([UserDataSingleton mainSingleton].networkState == 0){
                NoInternetTVCell *cell= [tableView dequeueReusableCellWithIdentifier:@"NoInternetTVCell" forIndexPath:indexPath];
                cell.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else {
                if ([UserDataSingleton mainSingleton].userID.length == 0) {
                    NotLoggedInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotLoggedInTableViewCell" forIndexPath:indexPath];
                    cell.delegate = self;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }else {
                    //空空如也
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
                    cell.backgroundColor = MColor(238, 238, 238);
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shoppingCart_empty"]];
                    imageView.backgroundColor = MColor(238, 238, 238);
                    UILabel *titleLabel = [[UILabel alloc] init];
                    titleLabel.text = @"购物车为空";
                    titleLabel.textAlignment = 1;
                    titleLabel.textColor = MColor(51, 51, 51);
                    titleLabel.font = MFont(kFit(15));
                    [cell addSubview:imageView];
                    [cell addSubview:titleLabel];
                    imageView.sd_layout.widthIs(100).heightIs(100).centerXEqualToView(cell).centerYEqualToView(cell);
                    titleLabel.sd_layout.leftSpaceToView(cell, 0).topSpaceToView(imageView, kFit(10)).rightSpaceToView(cell, 0).heightIs(kFit(15));
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
            }
        }else{//猜你喜欢
            GoodsDetailsModel *modelL = self.recommendGoodsArray[indexPath.row*2];
            GoodsDetailsModel *modelR = self.recommendGoodsArray[indexPath.row*2 + 1];
            
            YouLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YouLikeTableViewCell"  forIndexPath:indexPath];
            [cell grantLikeViewAddCode:indexPath];
            cell.delegate = self;
            cell.modelL = modelL;
            cell.modelR = modelR;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //给GuessYouLike的model
            return cell;
        }
    }
}

#pragma mark 跳转登录界面 和 刷新网络
- (void)refreshView {
    
    [self ShoppingCartListData];
    
}

- (void)handleLogInBtn{
    LogInViewController *VC = [[LogInViewController alloc] init];
    UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
    [VC setHidesBottomBarWhenPushed:YES];
    [self presentViewController:NAVC animated:YES completion:nil];
}
#pragma mark  YouLikeTableViewCell猜你喜欢点击事件
- (void)handleLikeViewClick:(GuessLikeView *)tap {
    GoodsDetailsModel *model;
    if (tap.tag == 0) {
        NSLog(@"recommendGoodsArray%ld", tap.indexPath.row * 2);
        model = self.recommendGoodsArray[tap.indexPath.row * 2];
    }else {
        NSLog(@"recommendGoodsArray%ld", tap.indexPath.row * 2 + 1);
        model = self.recommendGoodsArray[tap.indexPath.row * 2 + 1];
    }
    GoodsDetailsVController *VC = [[GoodsDetailsVController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    VC.goodsID = model.goodsId;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark   ModifyNumberViewDelegate  加减商品数量
- (void)GoodsNumberChange:(UIButton*)sender view:(ModifyNumberView *)view {
    [self performSelector:@selector(indeterminateExample)];
    
    ShoppingCartStoreModel *storeModel = self.storeListArray[view.indexPath.section];
    NSMutableArray *goodsArray = (NSArray *)storeModel.list;
    ShoppingCartGoodsModel *goodsModel = goodsArray[view.indexPath.row-1];
    static int i = 0 ;
    i = goodsModel.goodsNum;
    if (sender.tag == 201) {
        if (i == 1) {
            
        }else {
            i--;
        }
    }
    if (sender.tag == 202) {
        i++;
    }
    NSString *URL_Str = [NSString stringWithFormat:@"%@/cartapi/updateCartCount", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"cartId"] = goodsModel.cartId;
    URL_Dic[@"count"] = [NSString stringWithFormat:@"%d", i];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block ShoppingCartVC *VC = self;
    
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // [VC showAlert:responseObject[@"msg"]];
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        
        if ([resultStr isEqualToString:@"1"]) {
            goodsModel.goodsNum = i;
            goodsArray[view.indexPath.row-1] = goodsModel ;
            storeModel.list = goodsArray;
            self.storeListArray[view.indexPath.section] = storeModel;
            
            [self.tableView reloadData];
            
        }else {
        }
        [VC performSelector:@selector(delayMethod)];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"网络链接超时请重试"];
        [VC performSelector:@selector(delayMethod)];
    }];
    
}
#pragma mark cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.storeListArray.count != 0) {
        if (indexPath.section != self.storeListArray.count) {//如果不是热门推荐
            
            ShoppingCartStoreModel *storeModel = self.storeListArray[indexPath.section];
            NSArray *goodsArray = storeModel.list;
            ShoppingCartGoodsModel *goodsModel = goodsArray[indexPath.row-1];
            GoodsDetailsVController *VC = [[GoodsDetailsVController alloc] init];
            [VC setHidesBottomBarWhenPushed:YES];
            VC.goodsID = goodsModel.goodsId;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    
}
#pragma mark 页眉
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == (self.storeListArray.count ? self.storeListArray.count:1)) {
        
        if (self.recommendGoodsArray.count <=1) {
            return nil;
        }else {
            UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kFit(47))];
            View.backgroundColor = [UIColor whiteColor];
            UILabel *leftLine = [UILabel new];
            leftLine.backgroundColor = MColor(161, 161, 161);
            [View addSubview:leftLine];
            leftLine.sd_layout.leftSpaceToView(View, kFit(12)).centerYEqualToView(View).widthIs(kFit(115)).heightIs(0.5);
            //------
            UIButton *ioncBtn = [UIButton new];
            UIImage *buttonimage = [UIImage imageNamed:@"sptj"];
            //设置图像渲染方式        buttonimage = [buttonimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
            [ioncBtn setImage:buttonimage forState:(UIControlStateNormal)];
            [View addSubview:ioncBtn];
            ioncBtn.sd_layout.leftSpaceToView(leftLine, kFit(15)).topSpaceToView(View, 0).bottomSpaceToView(View, 0).widthIs(kFit(24));
            //-------
            UILabel *titleLabel = [UILabel new];  titleLabel.textColor = MColor(51, 51, 51);
            titleLabel.text = @"热门推荐";         titleLabel.font = MFont(kFit(15));
            [View addSubview:titleLabel];
            titleLabel.sd_layout.leftSpaceToView(ioncBtn, kFit(5)).topSpaceToView(View, 0).bottomSpaceToView(View, 0).widthIs(kFit(70));
            UILabel *rightLine = [UILabel new];
            rightLine.backgroundColor = MColor(161, 161, 161);
            [View addSubview:rightLine];
            rightLine.sd_layout.rightSpaceToView(View, kFit(12)).centerYEqualToView(View).widthIs(kFit(115)).heightIs(0.5);
            return View;
        }
    }else{
        return nil;
    }
}
#pragma mark 返回页眉的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.storeListArray.count == 0) {
        if (section == 0) {
            return kFit(10);
        }else{
            return kFit(47);
        }
    }else{
        if (section == self.storeListArray.count) {
            return kFit(47);
        }else{
            return kFit(10);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFit(1);
}
#pragma mark 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.storeListArray.count == 0) {
        if (indexPath.section == 0) {
            return kFit(375);
        }else{
            return kFit(259);
        }
    }else{
        if (indexPath.section != self.storeListArray.count) {
            if (indexPath.row == 0) {
                return kFit(47);
            }else{
                return kFit(103);
            }
        }else{
            return kFit(259);
        }
    }
}
#pragma mark cell删除事件
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置删除按钮
    NSLog(@"%ld_____%ld", indexPath.section, self.shopNameArray.count);
    if (indexPath.row != 0) {
        
        
        UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
            
            //1.取出对应的商店的所有商品数组
            ShoppingCartStoreModel * storeModel = self.storeListArray[indexPath.section];
            NSMutableArray *array = (NSMutableArray *)storeModel.list;
            ShoppingCartGoodsModel *GoodsModel = array[indexPath.row - 1];
            //删除操作 给后台发送删除请求
            
            NSString *URL_str = [NSString stringWithFormat:@"%@/cartapi/deleteCart", kSHY_100];
            NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
            URL_Dic[@"cartIds"] = GoodsModel.cartId;
            __block ShoppingCartVC *VC = self;
            AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
            [session POST:URL_str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@", responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@", error);
            }];
            //删除 缓存数据
            [array removeObjectAtIndex:indexPath.row - 1];
            //2.1删除已选中商品
            if (array.count == 0) {
                //删除已选中商店
                [self.storeListArray removeObjectAtIndex:indexPath.section];
            }else {
                storeModel.list = array;
                self.storeListArray[indexPath.section] = storeModel;
            }
            [tableView reloadData];
        }];
        return @[deleteRowAction];
    }else{
        return nil;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0 && indexPath.section != self.storeListArray.count) {
        return YES;
    }else{
        return NO;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}

#pragma mark - ShopCartGoodViewCellDelegate
- (void)shopCartGoodViewCellChange:(ShopCartGoodViewCell *)cell{
    _allSum = 0;
    for (ShopCartModel *model in self.selectedArray) {
        self.allSum += model.goods_price * model.goods_num;
    }
    _bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
}
#pragma mark 选择商店的点击事件
- (void)shopCartStoreSelectedClick:(int)index state:(BOOL)state{
    ShoppingCartStoreModel *storeModel = self.storeListArray[index];//获取第几个section下的店铺model
    storeModel.isSelect = state;
    NSMutableArray *GoodsArray = (NSMutableArray *)storeModel.list;
    NSLog(@"您点击的第%d个商店", index);
    for (int i = 0; i < GoodsArray.count; i ++) {
        ShoppingCartGoodsTVCell *goodsModel = GoodsArray[i];
        goodsModel.isSelect=state;
        GoodsArray[i] = goodsModel;
    }
    storeModel.list = GoodsArray;
    
    self.storeListArray[index] = storeModel;
    [self determineWhetherAllSelected];
    [self CalculateTotalPrice];
}
- (void)ShopGoodsEditor:(int)index state:(BOOL)state {
    NSLog(@"ShopGoodsEditor%d state%@", index, state?@"YES":@"NO");
    if (state) {
        self.goodsEditStateArray[index] = @"1";
    }else {
        self.goodsEditStateArray[index] = @"0";
    }
    
    [self.tableView reloadData];
    
}
#pragma mark - bottomPriceViewDelegate 购物车内的商品全选
- (void)bottomPriceView:(BOOL)bottonView{
    for (int i = 0; i < self.storeListArray.count; i ++) {
        ShoppingCartStoreModel *storeModel = self.storeListArray[i];//获取第几个section下的店铺model
        storeModel.isSelect = bottonView;
        NSMutableArray *GoodsArray = storeModel.list;
        for (int j = 0 ; j < GoodsArray.count; j ++) {
            ShoppingCartGoodsModel *goodsModel = GoodsArray[j];//第几个商品
            goodsModel.isSelect= bottonView;
            GoodsArray[j] = goodsModel;
        }
        storeModel.list = GoodsArray;
        self.storeListArray[i] = storeModel;
    }
    
    [self CalculateTotalPrice];
}
#pragma mark -------->>>>>>>>>>请看这里 这里是结算<<<<<<<<<-----------
- (void)SettlementClick:(UIButton *)sender {
    
    NSString *cartIds = [self obtainSelectedOrder];
    NSLog(@"请看这里 这里是结算%@", cartIds);
    
    if (cartIds != nil) {
        ConfirmOrderVC *VC =[[ConfirmOrderVC alloc] init];
        VC.cartIds = cartIds;
        VC.orderPrice = goodsPrice;
        [VC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        [self showAlert:@"您还没有选择商品"];
    }
}

#pragma mark  结算之前选计算一共多少商品(拼接所有已经选择的商品购物车ID)
- (NSString *)obtainSelectedOrder {
    NSLog(@"%@", self.storeListArray);
    NSString *cartId;
    NSLog(@"一共%lu个商店", (unsigned long)self.storeListArray.count);
    for (int i  = 0; i < self.storeListArray.count; i++) {
        ShoppingCartStoreModel *model = self.storeListArray[i];//获取第几个section下的店铺model
        NSArray *goodsArr = (NSArray *)model.list;//获取店铺下的商品数组
        for (int j = 0; j < goodsArr.count; j ++) {
            
            ShoppingCartGoodsModel *goodsModel = goodsArr[j];
            if (goodsModel.isSelect) {
                if (cartId == nil) {
                    cartId = goodsModel.cartId;
                }else {
                    cartId = [NSString stringWithFormat:@"%@,%@", cartId, goodsModel.cartId];
                }
            }
        }
    }
    return cartId;
}

#pragma mark - GoodsToolBarDelegate
- (void)goodsToolBarChoose:(GoodsToolBar *)goodsToolBar{
    if ([self.countText.text integerValue] >= 99) {
        self.countText.text = [NSString stringWithFormat:@"%d", 99];
    }
    if ([self.countText.text integerValue] <= 0) {
        self.countText.text = [NSString stringWithFormat:@"%d", 1];
    }
    self.currentModel.goods_num = [self.countText.text integerValue];
    self.currentCell.goodCount = [self.countText.text integerValue];
    //上传数量
    
    //重写计算
    if ([self.selectedArray containsObject:self.currentModel]) {
        self.allSum = self.allSum - self.currentModel.goods_price * self.currentCount + self.currentModel.goods_price * [self.countText.text integerValue];
    }
    self.bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
    
    self.currentModel = nil;
    self.currentCell = nil;
    self.currentCount = 0;
    [self.countText resignFirstResponder];
}
- (void)goodsToolBarCancel:(GoodsToolBar *)goodsToolBar{
    self.countText.text = [NSString stringWithFormat:@"%lu", self.currentCount];
    [self.countText resignFirstResponder];
    self.currentCount = 0;
    self.currentModel = nil;
    self.currentCell = nil;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.countText = textField;
    self.currentCount = [textField.text integerValue];
    ShopCartGoodViewCell *cell = (ShopCartGoodViewCell *)textField.superview.superview;
    self.currentModel = cell.model;
    self.currentCell = cell;
    NSLog(@"%f", CGRectGetMaxY(cell.frame));
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.y = 0;
    }];
}
//移除
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark   计算当前一共选择了多少商品 多少价格
- (void)CalculateTotalPrice {
    CGFloat price = 0.0;//价钱
    int num = 0;//数量
    for (int i = 0; i < self.storeListArray.count; i ++) {
        ShoppingCartStoreModel *storeModel = self.storeListArray[i];//获取第几个section下的店铺model
        NSMutableArray *GoodsArray = (NSMutableArray *)storeModel.list;
        for (int j = 0 ; j < GoodsArray.count; j ++) {
            ShoppingCartGoodsModel *goodsModel = GoodsArray[j];//第几个商品
            if (goodsModel.isSelect) {
                num ++;
                price += goodsModel.goodsPrice * goodsModel.goodsNum;
            }
        }
        storeModel.list = GoodsArray;
        self.storeListArray[i] = storeModel;
    }
    NSLog(@"%.2f------------%d", price, num);
    goodsPrice = price;
    _bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", price];
    _bottonView.payStr = [NSString stringWithFormat:@"%d", num];
    [self.tableView reloadData];
    
}
//判断购物车内的商品是否全部被选中
- (void)determineWhetherAllSelected {
    
    BOOL state = YES;
    for (int i = 0; i < self.storeListArray.count; i ++) {
        ShoppingCartStoreModel *storeModel = self.storeListArray[i];//获取第几个section下的店铺model
        NSMutableArray *GoodsArray = (NSMutableArray *)storeModel.list;
        for (int j = 0 ; j < GoodsArray.count; j ++) {
            ShoppingCartGoodsModel *goodsModel = GoodsArray[j];//第几个商品
            if (!goodsModel.isSelect) {
                state = NO;
                j = (int)GoodsArray.count;
                i = (int)self.storeListArray.count;
            }
        }
    }
    _bottonView.isSelectBtn = state;
    [self.tableView reloadData];
}
#pragma mark 选择商品的点击事件
- (void)ShoppingCartGoodsSelectedClick:(int)index {
    int section = index/100;
    int row = index%100;
    ShoppingCartStoreModel *storeModel = self.storeListArray[section];//获取第几个section下的店铺model
    NSMutableArray *GoodsArray = storeModel.list;
    ShoppingCartGoodsModel *goodsModel = GoodsArray[row];//第几个商品
    goodsModel.isSelect=!goodsModel.isSelect;//改变商品状态
    NSLog(@"第""%d""个商店  第""%d""个商品 商品规格%@", section, row, goodsModel.specInfo);
    GoodsArray[row] = goodsModel;//保存
    BOOL isSelect = YES;
    for (int i = 0; i < GoodsArray.count; i ++) {//判断如果多有的商品都已经被选中 那么就把商家选中
        ShoppingCartGoodsTVCell *goodsModel = GoodsArray[i];
        if (!goodsModel.isSelect) {
            isSelect = NO;
            i = (int)GoodsArray.count;
        }
    }
    storeModel.isSelect = isSelect;
    NSLog(@"%@", isSelect?@"YES":@"NO");
    storeModel.list = GoodsArray;
    self.storeListArray[section] = storeModel;
    [self determineWhetherAllSelected];
    [self CalculateTotalPrice];
}

//商品详情解析数据
- (void)setGoodsDetailsData:(NSString *)goodsID index:(int)index{
    
    [self performSelector:@selector(indeterminateExample)];
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/goods/api/goodsdetail", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"goodsId"] = goodsID;
    URL_Dic[@"memberId"] = [UserDataSingleton mainSingleton].userID;
    __block ShoppingCartVC *VC = self;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        //  NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        [VC AnalyticalGoodsDetailsData:responseObject index:index];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"网络有问题请重试!"];
    }];
}
//商品详情封装model
- (void)AnalyticalGoodsDetailsData:(NSDictionary *)dic index:(int)index{
    
    NSArray *array = dic[@"goods"];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"GoodsDetailsModel" inManagedObjectContext:self.managedContext];
    //根据描述 创建实体对象
    GoodsDetailsModel *GDModel = [[GoodsDetailsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
    for (NSDictionary *dataDic in array) {//获取商品
        for (NSString *key in dataDic) {//获取商品里面参数
            NSMutableArray *specNameArray = [NSMutableArray array];
            
            if ([key isEqualToString:@"specName"]) {//获取规格名字
                
                if ([dataDic[key] isKindOfClass:[NSString class]]) {
                    
                }else {
                    
                    NSDictionary *specNameDic = dataDic[key];//获取规格字典
                    for (NSString *specKey in specNameDic) { //获取规格名字
                        [specNameArray addObject:specNameDic[specKey]];
                    }
                    [GDModel setValue:specNameArray forKey:key];
                }
                //NSLog(@"specName%@", specNameArray);
            }else if ([key isEqualToString:@"goodsImageMore"]) {//获取商品图片
                NSArray *ImageArray = [dataDic[key] componentsSeparatedByString:@","];
                NSMutableArray *Image_URL = [NSMutableArray array];
                for (int i = 0; i < ImageArray.count ; i ++) {
                    NSString *imageStr = [NSString stringWithFormat:@"%@%@", kSHY_100,ImageArray[i]];
                    [Image_URL addObject:imageStr];
                }
                [GDModel setValue:Image_URL forKey:key];
            }else if ([key isEqualToString:@"goodsSpec"]) {
                if ([dataDic[key] isKindOfClass:[NSString class]]) {//如果是NSString
                }else {
                    NSMutableDictionary *goodsSpecDic = [NSMutableDictionary dictionary];
                    NSDictionary *SpecDic =dataDic[key];
                    for (NSString  *keyOne in SpecDic) {  //特殊处理
                        NSString  *str = SpecDic[keyOne];
                        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
                        NSDictionary *JXdic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                              options:NSJSONReadingMutableContainers
                                                                                error:nil];
                        {//获取和对应的规格名字 因为不确定 specName 和 goodsSpec这两个如果那个先走 所以不使用上面的方法 直接在获取的原始字典里面找
                            NSMutableDictionary *specNameDic = [NSMutableDictionary dictionary];
                            specNameDic = dataDic[@"specName"];
                            for (NSString *keyTwo in specNameDic) {//方式重名 直接用one two htree
                                if ([keyTwo isEqualToString:keyOne]) {
                                    
                                    [goodsSpecDic setValue:JXdic forKey:specNameDic[keyTwo]];
                                }
                            }
                        }
                    }
                    [GDModel setValue:goodsSpecDic forKey:key];
                }
            }else {
                //   NSLog(@"<<<<<<dataDic[key]>>>>>>>%@<<<<key>>>>%@", dataDic[key], key);
                
                [GDModel setValue:dataDic[key] forKey:key];
                
            }
        }
        [self.GoodsDataArray addObject:GDModel];
        NSLog(@"GoodsDataArray%@", _GoodsDataArray);
        [self getProductSpec:GDModel.goodsId index:index];
    }
    
}
//获取商品的规格
- (void)getProductSpec:(NSString *)goodsID index:(int)index{
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/goods/api/findGoodsSpec", kSHY_100];
    NSMutableDictionary*URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"goodsId"] = goodsID;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block ShoppingCartVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            NSArray *dataArray = responseObject[@"data"];//存储规格的数组
            NSDictionary *dataDic = dataArray[0];//存储规格的字典
            NSArray *SpecDataArray = dataDic[@"goodsSpecDetails"];//规格详情
            //初步解析数据
            for (NSDictionary *specDic in SpecDataArray) {
                //这个字典是用来存储规格值的
                NSMutableDictionary *specValueIdDic = [NSMutableDictionary dictionary];
                //这个字典是用来存储规格名字的
                [specValueIdDic setValue:specDic[@"specGoodsStorage"] forKey:@"specGoodsStorage"];//存储库存
                [specValueIdDic setValue:specDic[@"specGoodsPrice"] forKey:@"specGoodsPrice"];
                NSDictionary *specValueIdDataDic = specDic[@"specGoodsSpec"];//获取未解析之前的规格值字典
                //存储规格值
                for (NSString *specValueKey in specValueIdDataDic) {
                    [specValueIdDic setValue:specValueIdDataDic[specValueKey] forKey:specValueKey];//存储规格值
                }
                [self.specDatabaseArray addObject:specValueIdDic];//存储规格值
                //  NSLog(@"specDatabaseArray%@", _specDatabaseArray);
            }
            [self ShoppingCellClickEvent:index];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
/**
 *规格选择点击事件
 */
- (void)specEditor:(int)index {
    
    NSInteger section = index/100;
    NSInteger row = index%100;
    // NSLog(@"你选择编辑第%ld个商店的第%ld个商品", (long)section, (long)row);
    ShoppingCartStoreModel *storeModel = self.storeListArray[section];
    NSArray *goodsArray = (NSArray *)storeModel.list;
    ShoppingCartGoodsModel *goodsModel = goodsArray[row];
    cartID = goodsModel.cartId;
    [self setGoodsDetailsData:goodsModel.goodsId index:index];
}
/**
 *商品删除事件
 */
-(void)GoodsDeleteEvents:(int)index {
    
    
    NSInteger section = index/100;
    NSInteger row = index%100;
    
    
    NSLog(@"你选择编辑第%ld个商店的第%ld个商品", (long)section, (long)row);
    ShoppingCartStoreModel *storeModel = self.storeListArray[section];
    NSMutableArray *goodsArray = [NSMutableArray arrayWithArray:storeModel.list];
    ShoppingCartGoodsModel *goodsModel = goodsArray[row];
    NSString *URL_Str = [NSString stringWithFormat:@"%@/cartapi/deleteCart", kSHY_100];
    
    NSMutableDictionary *URL_DIc = [NSMutableDictionary dictionary];
    URL_DIc[@"cartIds"] = goodsModel.cartId;
    __block ShoppingCartVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:URL_Str parameters:URL_DIc progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@", responseObject);
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC showAlert:responseObject[@"msg"]];
            [goodsArray removeObjectAtIndex:row];
            storeModel.list = goodsArray;
            self.storeListArray[section] = storeModel;
            [VC.tableView reloadData];
        }else {
            [VC showAlert:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"网络超时请重试"];
        NSLog(@"error%@", error);
    }];
    
    
}
#pragma mark 选择规格的弹出视图
//创建一个存在于视图最上层的UIViewController
- (UIViewController *)appRootViewController{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
- (void)ShoppingCellClickEvent:(int)index{//
    
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
    
    self.popUpView = [[PopUpView alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(450))];
    NSLog(@"GoodsDataArray%@", self.GoodsDataArray);
    GoodsDetailsModel *model = self.GoodsDataArray[0];
    NSInteger section = index/100;
    NSInteger row = index%100;
    ShoppingCartStoreModel *storeModel = self.storeListArray[section];
    NSArray *goodsArray = (NSArray *)storeModel.list;
    ShoppingCartGoodsModel *goodsModel = goodsArray[row];
    _popUpView.goodsNum = goodsModel.goodsNum;
    _popUpView.specIDArray = self.specDatabaseArray;
    _popUpView.model = model;
    self.popUpView.delegate = self;
    [topVC.view addSubview:self.popUpView];
    
    [UIView animateWithDuration: 0.2 animations:^{
        self.popUpView.frame =CGRectMake(0, kScreen_heigth-kFit(450), kScreen_widht, kFit(450));
    }];
}
#pragma mark PopUpViewDelegate  弹出视图的两个代理方法
- (void)hiddenView { //调用这个方法不保存选择的数值
    [self.backImageView1 removeFromSuperview];
    [UIView animateWithDuration: 0.2 animations:^{
        self.popUpView.frame =CGRectMake(0, kScreen_heigth * 2, kScreen_widht, kFit(450));
    }];
}
// 确定按钮 调用这个方法保存选择的数值
- (void)DetermineBtnClick:(UIButton *)sender typeID:(NSArray *)typeID typeName:(NSArray *)typeName goodsNum:(NSInteger)goodsNum{
    
    _goodsNum = goodsNum;
    [self.backImageView1 removeFromSuperview];
    [UIView animateWithDuration: 0.2 animations:^{
        self.popUpView.frame =CGRectMake(0, kScreen_heigth * 2, kScreen_widht, kFit(450));
    }];
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/cartapi/updateCart", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    NSString *URL_Type=@"";
    for (int i = 0; i < typeID.count; i ++) {
        if (i == 0) {
            URL_Type = typeID[0];
            
        }else {
            URL_Type = [NSString stringWithFormat:@"%@,%@", URL_Type, typeID[i]];
        }
    }
    
    URL_Dic[@"cartId"] = cartID;
    URL_Dic[@"count"] = [NSString stringWithFormat:@"%ld",goodsNum];
    URL_Dic[@"specId"] = URL_Type;
    NSLog(@"URL_Str%@  URL_Str%@", URL_Str, URL_Dic);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block ShoppingCartVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC showAlert:responseObject[@"msg"]];
            NSString *URL_Type=@"";
            for (int i = 0; i < typeName.count; i ++) {
                if (i == 0) {
                    URL_Type = typeName[0];
                    
                }else {
                    URL_Type = [NSString stringWithFormat:@"%@ , %@", URL_Type, typeName[i]];
                }
            }
            
            [VC ShoppingCartListData];
        }else {
            [VC showAlert:responseObject[@"msg"]];
        }
        // NSLog(@"responseObject%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"网络超时,请重试"];
    }];
    
}


#pragma mark -- 推荐商品的接口

//商品推荐数据请求
- (void)goodsRecommendDataRequest{
    //  [self performSelector:@selector(indeterminateExample)];
    NSString *str=[NSString stringWithFormat:@"%@/goods/api/findRecommendGoods", kSHY_100];
    NSLog(@"goodsRecommendDataRequest%@", str);
    __block ShoppingCartVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *stateStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([stateStr isEqualToString:@"1"]) {
            [VC AnalyticalRecommendGoodsData:responseObject];
        }else {
            [VC showAlert:responseObject[@"msg"] time:1.0];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"推荐商品数据获取失败" time:1.0];
    }];
}
//商品推荐数据解析
- (void)AnalyticalRecommendGoodsData:(NSDictionary *)data {
    [self.recommendGoodsArray removeAllObjects];
    NSArray *array = data[@"data"];
    // [self managedContext];
    
    for (NSDictionary *dataDic in array) {//获取商品
        //创建实体描述对象
        
        NSEntityDescription *des = [NSEntityDescription entityForName:@"GoodsDetailsModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        GoodsDetailsModel *GDModel = [[GoodsDetailsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        NSDictionary *goodsDetailsDic = dataDic[@"goods"];
        for (NSString *key in goodsDetailsDic) {//获取商品里面参数
            if ([key isEqualToString:@"provinceName"]||[key isEqualToString:@"goodsShow"]||[key isEqualToString:@"provinceId"]||[key isEqualToString:@"goodsStoreState"]||[key isEqualToString:@"updateTimeStr"]||[key isEqualToString:@"esPrice"]||[key isEqualToString:@"goodsClick"]||[key isEqualToString:@"goodsColImg"]||[key isEqualToString:@"specId"]||[key isEqualToString:@"goodsSerial"]) {
            }else {
                [GDModel setValue:goodsDetailsDic[key] forKey:key];
            }
        }
        [self.recommendGoodsArray addObject:GDModel];
    }
    [self.tableView reloadData];
}


@end
