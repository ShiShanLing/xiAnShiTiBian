//
//  GoodsDetailsVController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/8.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "GoodsDetailsVController.h"
#import "GDTableViewCell.h"
#import "ServiceTableViewCell.h"
#import "SericeView.h"
#import "ColorTypeTableViewCell.h"//规格 颜色选择
#import "GDEvaluationTVCell.h"//选项
#import "CommentsTVCell.h"//评论cell
#import "ProductDetailsPictureTVCell.h"//图片介绍
#import "BuyView.h"//最下方支付view;


#import "ConfirmOrderVC.h"//生成订单

static int GDETVC;

#import "UITableView+SDAutoTableViewCellHeight.h"

@interface GoodsDetailsVController ()<UITableViewDelegate, UITableViewDataSource, GDEvaluationTVCellDelegate, BuyViewDelegate, PopUpViewDelegate>
@property (nonatomic,strong)UITableView *GoodstableView;
@property (nonatomic, strong)UIView *backImageView1;//规格选择弹出视图的背景色
@property (nonatomic, strong)PopUpView *popUpView;//规格选择view
@property (nonatomic, copy)NSMutableArray *GoodsDataArray;
/**
 *存放从数据库里面过去的规格数据(很多)
 */
@property (nonatomic, strong)NSMutableArray *specDatabaseArray;


@end

@implementation GoodsDetailsVController{
    /**
     *存储用户选择商品规格名字
     */
    NSMutableArray *typeNameArray;//
    /**
     *存储用户选择商品规格名字
     */
    NSMutableArray *typeIDArray;//
    NSInteger _goodsNum;
    /**
     *记录用户是只对规格进行选择 还是说添加购物车或者直接购买 如果用户选择完规格后在进行添加购物车 或者直接购买就不在弹出规格选择器 1代表选择规格 2代表添加购物车 3代表直接购买
     */
    NSInteger recordChoose;//
    NSString *typeID;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGoodsDetailsData];
    [self getProductSpec];
    [self configurationNavigationBar];
    _goodsNum = 1;
    self.GoodstableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth-kFit(50)) style:(UITableViewStylePlain)];
    self.GoodstableView.delegate = self;
    self.GoodstableView.dataSource = self;
    self.GoodstableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.GoodstableView];
    [self.GoodstableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.GoodstableView registerClass:[GDTableViewCell class] forCellReuseIdentifier:@"GDTableViewCell"];
    [self.GoodstableView registerClass:[ServiceTableViewCell class] forCellReuseIdentifier:@"ServiceTableViewCell"];
    [self.GoodstableView registerClass:[ColorTypeTableViewCell class] forCellReuseIdentifier:@"ColorTypeTableViewCell"];
    [self.GoodstableView registerClass:[GDEvaluationTVCell class] forCellReuseIdentifier:@"GDEvaluationTVCell"];
    [self.GoodstableView registerClass:[CommentsTVCell class] forCellReuseIdentifier:@"CommentsTVCell"];
    [self.GoodstableView registerClass:[ProductDetailsPictureTVCell class] forCellReuseIdentifier:@"ProductDetailsPictureTVCell"];
    BuyView *buyView = [[BuyView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.GoodstableView.frame), kScreen_widht, kFit(50))];
    buyView.delegate = self;
    [self.view addSubview:buyView];
    
}

//显示网络加载指示器
- (void)indeterminateExample {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
}
//隐藏网络加载指示器
- (void)delayMethod{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
}
//商品详情解析数据
- (void)setGoodsDetailsData {
    [self performSelector:@selector(indeterminateExample)];
    
    NSString *str=[NSString stringWithFormat:@"%@/goods/api/goodsdetail?goodsId=%@&memberId=%@", kSHY_100, self.goodsID, [UserDataSingleton mainSingleton].userID];
    NSLog(@"/goods/api/goodsdetail%@",str );
    __block GoodsDetailsVController *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        [VC performSelector:@selector(delayMethod)];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSLog(@"/商品详情解析数据responseObject%@", responseObject);
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];

        if ([resultStr isEqualToString:@"1"]) {
            
            [VC AnalyticalGoodsDetailsData:responseObject];
        }else {
            
            [VC showAlert:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"网络有问题请重试!"];
    }];
}
//商品详情封装model
- (void)AnalyticalGoodsDetailsData:(NSDictionary *)dic {
    
    NSArray *array = dic[@"goods"];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"GoodsDetailsModel" inManagedObjectContext:self.managedContext];
    //根据描述 创建实体对象
    GoodsDetailsModel *GDModel = [[GoodsDetailsModel    alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];

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
                    NSLog(@"specNameArray%@", specNameArray);
                }
            }else if ([key isEqualToString:@"goodsImageMore"]) {//获取商品图片
                NSArray *ImageArray = [dataDic[key] componentsSeparatedByString:@","];
                NSMutableArray *Image_URL = [NSMutableArray array];
                for (int i = 0; i < ImageArray.count-1 ; i ++) {
                    NSString *imageStr = ImageArray[i];
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
    }
    [self.GoodstableView reloadData];
}
//获取商品的规格
- (void)getProductSpec {
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/goods/api/findGoodsSpec", kSHY_100];
    NSMutableDictionary*URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"goodsId"] = self.goodsID;
    __weak GoodsDetailsVController *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"获取商品的规格%@", responseObject);
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
                
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"请求失败请重试" time:1.0];
    }];
    
}
//配置导航条
- (void)configurationNavigationBar {
    
    self.navigationController.navigationBar.barTintColor = kNavigation_whrColor;//导航条颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color, NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];//改变导航条标题的颜色与大小
    
    self.navigationItem.title = @"商品详情";
    
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    UIImage *MoreMoreCartImage = [UIImage imageNamed:@"ShoppingCart_black"];
    //设置图像渲染方式
    MoreMoreCartImage = [MoreMoreCartImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉
    
    UIBarButtonItem *MoreMoreButtonItem = [[UIBarButtonItem alloc] initWithImage:MoreMoreCartImage style:UIBarButtonItemStylePlain target:self action:@selector(handlegwc)];//自定义导航条按钮
    
    UIImage *shoppingCartImage = [UIImage imageNamed:@"morehs"];
    //设置图像渲染方式
    shoppingCartImage = [shoppingCartImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉
    UIBarButtonItem *CollectButtonItem = [[UIBarButtonItem alloc] initWithImage:shoppingCartImage style:UIBarButtonItemStylePlain target:self action:@selector(handleCollect)];//自定义导航条按钮
    self.navigationItem.rightBarButtonItems = @[CollectButtonItem, MoreMoreButtonItem];
    
}
//返回上一界面
- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
}
//跳转到购物车
- (void)handlegwc{
    
    ShoppingCartVC *VC = [[ShoppingCartVC alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}
//跳转到消息界面
- (void)handleCollect {
    MessageViewController *VC = [[MessageViewController alloc] init];
    //UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
    [self.navigationController pushViewController:VC animated:YES];
}
//页眉视图
//支付view点击事件 191 打电话, 192 进入商家  193 收藏 194 加入购物车 195 立即购买
- (void)buyViewClick:(NSInteger)index {
    switch (index) {
        case 191: {
            
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"请选择" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"联系商家" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",@"13646712075"]]];
                });
            }];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"联系平台" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //蒂斯塔斯 饿深刻  阁楼bou Q
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",@"13673387452"]]];
                });
                
            }];
            // 3.将“取消”和“确定”按钮加入到弹框控制器中
            [alertV addAction:cancle];
            [alertV addAction:confirm];
            // 4.控制器 展示弹框控件，完成时不做操作
            [self presentViewController:alertV animated:YES completion:^{
                nil;
            }];
        }
            break;
        case 192: {
            GoodsDetailsModel*model = self.GoodsDataArray[0];
            StoreViewController *VC = [[StoreViewController alloc] init];
            VC.storeStr = model.storeId;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 193:{
            if ([UserDataSingleton mainSingleton].userID.length == 0) {
                LogInViewController *VC = [[LogInViewController alloc] init];
                UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
                [self presentViewController:NAVC animated:YES completion:nil];
            }else {
                [self GoodsCollection];
            }
        }
            break;
        case 194: {//添加购物车接口
            recordChoose = 2;
            if (typeIDArray.count == 0) {
                [self ShoppingCellClickEvent];
            }else {
                if ([UserDataSingleton mainSingleton].userID.length == 0) {
                    LogInViewController *VC = [[LogInViewController alloc] init];
                    UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
                    [self presentViewController:NAVC animated:YES completion:nil];
                }else {
                    [self AddCart];
                }
            }
        }
            break;
        case 195:{//直接购买接口
            recordChoose = 3;
            if (typeIDArray.count == 0) {
                [self ShoppingCellClickEvent];
            }else {
                if ([UserDataSingleton mainSingleton].userID.length == 0) {
                    LogInViewController *VC = [[LogInViewController alloc] init];
                    UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
                    [self presentViewController:NAVC animated:YES completion:nil];
                }else {
                    [self DirectPurchase];
                }
            }
        }
            break;
            
        default:
            break;
    }
    if (index == 192) {
        
    }
    
    if (index == 194 || index == 195) {
        
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:NO];
    GDETVC = 0;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            GDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GDTableViewCell"];
            cell.backgroundColor = [UIColor whiteColor];
            if (self.GoodsDataArray.count != 0) {
                GoodsDetailsModel *model = self.GoodsDataArray[0];
                [cell GoodsImageAssignment:model];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else if(indexPath.row == 1){
            ServiceTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"ServiceTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.row == 2){
            ColorTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorTypeTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            GDEvaluationTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GDEvaluationTVCell"];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else {
        if (GDETVC == 1) {
            CommentsTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsTVCell"];
            cell.GoodsCommentsContent.text = @"面料很好，做工精细，又实惠！这是第二次在本店购买了，买了两件送朋友一件，朋友很满意。以后会在来本店……";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            ProductDetailsPictureTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailsPictureTVCell"];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        recordChoose= 1;
        [self ShoppingCellClickEvent];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kFit(411);
        }else if (indexPath.row == 2 || indexPath.row == 1){
            return kFit(45);
        }else{
            return kFit(70);
        }
    }else {
        if (GDETVC == 0) {
            return [self cellHeightForIndexPath:indexPath cellContentViewWidth:kScreen_widht tableView:tableView];
        }else {
            return [self cellHeightForIndexPath:indexPath cellContentViewWidth:kScreen_widht tableView:tableView];
        }
    }
}
//下方显示模块的选择按钮
- (void)ChooseClick:(NSInteger)index {
    GDETVC = (int)index;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [self.GoodstableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.GoodstableView reloadData];
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
- (void)ShoppingCellClickEvent{//
    if (self.GoodsDataArray.count == 0) {
        return;
    }
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
    NSLog(@"GoodsDataArray%@", self.specDatabaseArray);
    GoodsDetailsModel *model = self.GoodsDataArray[0];;
    _popUpView.specIDArray = self.specDatabaseArray;
    _popUpView.goodsNum = _goodsNum;
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
    typeIDArray = [NSMutableArray arrayWithArray:typeID];
    
    typeNameArray = [NSMutableArray arrayWithArray:typeName];
    NSLog(@"%@,-------- %@typeIDArray%@", typeID,typeNameArray, typeIDArray);
    _goodsNum = goodsNum;
    [self.backImageView1 removeFromSuperview];
    [UIView animateWithDuration: 0.2 animations:^{
        self.popUpView.frame =CGRectMake(0, kScreen_heigth * 2, kScreen_widht, kFit(450));
    }];
    
    if (recordChoose == 2) {
        if ([UserDataSingleton mainSingleton].userID.length == 0) {
            LogInViewController *VC = [[LogInViewController alloc] init];
            UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
            [self presentViewController:NAVC animated:YES completion:nil];
        }else {
            [self AddCart];
        }
    }
    if (recordChoose == 3) {
        if ([UserDataSingleton mainSingleton].userID.length == 0) {
            LogInViewController *VC = [[LogInViewController alloc] init];
            UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
            [self presentViewController:NAVC animated:YES completion:nil];
        }else {
            [self DirectPurchase];
        }
        
    }
}
#pragma mark 加入购物车
- (void)AddCart {
    [self performSelector:@selector(indeterminateExample)];
    NSString *str=[NSString stringWithFormat:@"%@/cartapi/addCart", kSHY_100];
    NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
    URL_DIC[@"goodsId"] = self.goodsID;
    URL_DIC[@"count"] = [NSString stringWithFormat:@"%ld", _goodsNum];
    NSString *URL_Type=@"";
    for (int i = 0; i < typeIDArray.count; i ++) {
        if (i == 0) {
            URL_Type = typeIDArray[0];
        }else {
            URL_Type = [NSString stringWithFormat:@"%@,%@", URL_Type, typeIDArray[i]];
        }
    }
    URL_DIC[@"specId"] = URL_Type;
    [URL_DIC setValue:[UserDataSingleton mainSingleton].userID forKey:@"memberId"];
    URL_DIC[@"saveType"]= @"0";
    NSLog(@"URL_DIC%@", URL_DIC);
    __block GoodsDetailsVController *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSLog(@"responseObject%@", responseObject);
        NSDictionary *dic = responseObject;
        NSString *str = [NSString stringWithFormat:@"%@", dic[@"result"]];
        if ([str isEqualToString:@"1"]) {
            [VC showAlert:@"添加成功"];
        }else {
            [VC showAlert:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"网络有问题请重试!"];
    }];
}
#pragma mark 直接购买
- (void)DirectPurchase {
    [self performSelector:@selector(indeterminateExample)];
    
    NSString *str=[NSString stringWithFormat:@"%@/cartapi/buyNow", kSHY_100];
    NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
    URL_DIC[@"goodsId"] = self.goodsID;
    URL_DIC[@"count"] = [NSString stringWithFormat:@"%ld", _goodsNum];
    NSString *URL_Type = @"";
    for (int i = 0; i < typeIDArray.count; i ++) {
        if (i == 0) {
            URL_Type = typeIDArray[0];
        }else {
            URL_Type = [NSString stringWithFormat:@"%@,%@", URL_Type, typeIDArray[i]];
        }
    }
    [URL_DIC setValue:URL_Type forKey:@"specId"];
    URL_DIC[@"memberId"] = [UserDataSingleton mainSingleton].userID;
    __block GoodsDetailsVController *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"直接购买成功%@", responseObject);
        [VC performSelector:@selector(delayMethod)];
        NSDictionary *dic = responseObject;
        NSString *str = [NSString stringWithFormat:@"%@", dic[@"result"]];
        if ([str isEqualToString:@"1"]) {
            
            NSString *dataStr = responseObject[@"data"];
            if ([dataStr isEqualToString:@"-1"]) {
                [VC showAlert:@"你不能购买自己店铺下的东西"];
            }else {
                ConfirmOrderVC *VC =[[ConfirmOrderVC alloc] init];
                GoodsDetailsModel *model = self.GoodsDataArray[0];
                CGFloat price = model.goodsStorePrice;
                VC.orderPrice = price *_goodsNum;
                VC.cartIds = responseObject[@"data"];
                [VC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:VC animated:YES];
            }
        }else {
            [VC showAlert:@"请求失败,请重试"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"网络有问题请重试!"];
    }];
}

#pragma mark cell删除事件
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
    }
}

- (void)GoodsCollection {
    [self performSelector:@selector(indeterminateExample)];
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/storeapi/storecollection", kSHY_100];
    NSMutableDictionary * URL_Dic = [NSMutableDictionary dictionary];
    [URL_Dic setObject:self.goodsID forKey:@"goodsId"];
    [URL_Dic setValue:@"" forKey:@"storeId"];
    URL_Dic[@"favType"] = @"1";
    [URL_Dic setValue:[UserDataSingleton mainSingleton].userID forKey:@"memberId"];
    NSLog(@"GoodsCollection==URL_Dic%@", URL_Dic);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block GoodsDetailsVController *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSLog(@"responseObject%@", responseObject);
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC showAlert:responseObject[@"msg"]];
        }else {
            [VC showAlert:responseObject[@"msg"]];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"网络超时请重试"];
    }];
    
}

@end
