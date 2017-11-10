//
//  StoreViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/2.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "StoreViewController.h"
#import "ShopGoodsListVC.h"
#import "ShopFrontPageVC.h"
#import "StoreDetaileVC.h"
#import "StoreHeadView.h"
#import "MainTouchTableTableView.h"
#import "MYSegmentView.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define headViewHeight          Main_Screen_Width * 0.4
//static CGFloat const headViewHeight = ;

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

static int layout;

@interface StoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)MainTouchTableTableView * mainTableView;
@property (nonatomic, strong) MYSegmentView * RCSegView;
@property(nonatomic,strong)UIImageView *headImageView;//头部图片
@property(nonatomic, strong)StoreHeadView *storeHeadView;//商店的介绍和信誉度显示
@property(nonatomic,strong)UIImageView * avatarImage;
@property(nonatomic,strong)UILabel *countentLabel;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;

@property (nonatomic, strong)AppDelegate *delegate;
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext * managedObjectContext;
/**
 *显示是否收藏过店铺
 */
@property (nonatomic, strong)UIButton *isFavBtn;
/**
 *存储店铺信息model的数组
 */
@property (nonatomic, strong)NSMutableArray *storeModelArray;

@property (nonatomic, strong)StoreRankingListModel *storeDetailsModel;

@end

@implementation StoreViewController
- (NSMutableArray *)storeModelArray {
    if (!_storeModelArray) {
        _storeModelArray = [NSMutableArray array];
    }
    return _storeModelArray;
}
- (StoreRankingListModel *)storeDetailsModel {

    if (!_storeDetailsModel) {
        _storeDetailsModel = [[StoreRankingListModel alloc] init];
    }
    return _storeDetailsModel;
}

- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedContext =  delegate.managedObjectContext;
    }
   return _managedContext;
}

- (AppDelegate *)delegate {
    if (!_delegate) {
        _delegate = [[AppDelegate alloc] init];
    }
    return _delegate;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self storeInformationDataRequest];
    [super.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configurationNavigationBar];
    self.navigationItem.title = @"店铺界面";
    self.automaticallyAdjustsScrollViewInsets = NO;
   self.mainTableView= [[MainTouchTableTableView alloc]initWithFrame:CGRectMake(0,64,Main_Screen_Width,Main_Screen_Height-64)];
    _mainTableView.delegate=self;
    _mainTableView.dataSource=self;
    _mainTableView.bounces = NO;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.contentInset = UIEdgeInsetsMake(headViewHeight,0, 0, 0);
    [self.view addSubview:self.mainTableView];
    [self.mainTableView addSubview:self.storeHeadView];
    /*
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
}

//店铺信息数据请求
- (void)storeInformationDataRequest {
    {
        [self performSelector:@selector(indeterminateExample)];
        NSString * URL_Str = [NSString stringWithFormat:@"%@/storeapi/storedetail",kSHY_100];

        NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
        URL_Dic[@"storeId"] = self.storeStr;
        URL_Dic[@"memberId"] = @"";
        __block StoreViewController *VC = self;
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
        [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
       // NSLog(@"uploadProgress%@", uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [VC performSelector:@selector(delayMethod)];
            NSLog(@"店铺信息数据请求responseObject%@", responseObject);
            NSString *str =[NSString stringWithFormat:@"%@", responseObject[@"result"]];
            if ([str isEqualToString:@"1"]) {
                [VC AnalyticalStoreInformationData:responseObject];
            }else {
                [self showAlert:@"获取失败请重试"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [VC performSelector:@selector(delayMethod)];
               [self showAlert:@"网络链接超时请重试"];
        }];
    }
}
//店铺信息数据请求
- (void)AnalyticalStoreInformationData:(NSDictionary *)dic {
    
    NSArray *dataArray = dic[@"data"];
    [self managedContext];
    NSDictionary *StoreDic = dataArray[0];
    //StoreRankingListModel
    NSEntityDescription *des = [NSEntityDescription entityForName:@"StoreRankingListModel" inManagedObjectContext:self.managedContext];
    //根据描述 创建实体对象
    StoreRankingListModel *model = [[StoreRankingListModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
    
    for (NSString *key in StoreDic) {
        if ([key isEqualToString:@"isfav"]) {
            NSString *isfavStr = [NSString stringWithFormat:@"%@", StoreDic[@"isfav"]];
            if ([isfavStr isEqualToString:@"1"]) {
                _isFavBtn.selected = YES;
            }else {
                _isFavBtn.selected = NO;
            }
        }
     //    NSLog(@"StoreDicValue<%@>key<%@>", StoreDic[key], key);
        [model setValue:StoreDic[key] forKey:key];
    }
    [self.storeModelArray addObject:model];
    self.storeDetailsModel = model;
   
    self.storeHeadView.model = self.storeDetailsModel;
    
    [self.mainTableView reloadData];
}

//配置导航条
- (void)configurationNavigationBar {
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = MColor(238, 238, 238);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color}];//导航条标题颜色
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    self.isFavBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_widht - 40,15,50,50)];
    [_isFavBtn setImage:[UIImage imageNamed:@"scq"]forState:UIControlStateNormal];
    [_isFavBtn setImage:[UIImage imageNamed:@"sch"] forState:(UIControlStateSelected)];
    [_isFavBtn addTarget:self action:@selector(handleCollect)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:_isFavBtn];

    self.navigationItem.rightBarButtonItem= rightItem;

    
}
//返回上一界面
- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

//收藏
- (void)handleCollect {
 //   _isFavBtn.selected = !_isFavBtn.selected;
    if ([UserDataSingleton mainSingleton].userID.length == 0) {
        [self showAlert:@"您还没有登录"];
        UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"你好!" message:@"您还没有登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            LogInViewController *VC = [[LogInViewController alloc] init];
            UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
            [self presentViewController:NAVC animated:YES completion:nil];
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        // 3.将“取消”和“确定”按钮加入到弹框控制器中
        [alertV addAction:cancle];
        [alertV addAction:confirm];
        // 4.控制器 展示弹框控件，完成时不做操作
        [self presentViewController:alertV animated:YES completion:^{
            nil;
        }];

    }else {
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/storeapi/storecollection", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"storeId"] = self.storeDetailsModel.storeId;
    URL_Dic[@"memberId"] =[UserDataSingleton mainSingleton].userID;
    URL_Dic[@"favType"] = @"2";
    URL_Dic[@"goodsId"] = @"";
    NSLog(@"URL_Dic%@", URL_Dic);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block StoreViewController *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"收藏responseObject%@", responseObject);
        
        NSString *isfavStr = [NSString stringWithFormat:@"%@", responseObject[@"isfav"]];
        if ([isfavStr isEqualToString:@"1"]) {
            _isFavBtn.selected = YES;
        }else {
            _isFavBtn.selected = NO;
        }
        
        [VC showAlert:responseObject[@"msg"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@", error);
    }];
    }
}

-(void)acceptMsg : (NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    /**
     * 处理联动
     */
    //获取滚动视图y值的偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat tabOffsetY = [self.mainTableView rectForSection:0].origin.y;
    CGFloat offsetY = scrollView.contentOffset.y;
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    if (offsetY>=tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _isTopIsCanNotMoveTabView = YES;
    }else{
        _isTopIsCanNotMoveTabView = NO;
    }
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //NSLog(@"滑动到顶端");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            //NSLog(@"离开顶端");
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }
    /**
     * 处理头部视图
     */
     if(yOffset < -headViewHeight) {
        CGRect f = self.storeHeadView.frame;
        f.origin.y= yOffset;
        self.storeHeadView.frame= f;
    }
}

-(StoreHeadView *)storeHeadView {
    if (_storeHeadView == nil) {
        _storeHeadView= [[StoreHeadView alloc]init];
        _storeHeadView.frame = CGRectMake(0, -150, kScreen_widht, 150);
        _storeHeadView.userInteractionEnabled = YES;
    }
    return _storeHeadView;
}


#pragma marl -tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.storeModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Main_Screen_Height-64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //添加pageView
    if (self.storeModelArray.count == 0) {
        
    }else {
        
    [cell.contentView addSubview:self.setPageViewControllers];
    }
    return cell;
}
/*
 *这里可以任意替换你喜欢的pageView
 */
-(UIView *)setPageViewControllers {
        StoreDetaileVC * First=[[StoreDetaileVC alloc]init];
        First.storeID = self.storeStr;
        First.model =  self.storeDetailsModel;
        ShopGoodsListVC * Third=[[ShopGoodsListVC alloc]init];
        Third.storeID = self.storeStr;
     //   ShopFrontPageVC* Second=[[ShopFrontPageVC alloc]init];
        
        NSArray *controllers=@[Third,First];
        
        NSArray *titleArray =@[@"全部商品",@"店铺信息"];
        
        MYSegmentView * rcs=[[MYSegmentView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64) controllers:controllers titleArray:titleArray ParentController:self lineWidth:Main_Screen_Width/5 lineHeight:3.];
        _RCSegView = rcs;
    return _RCSegView;
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


@end
