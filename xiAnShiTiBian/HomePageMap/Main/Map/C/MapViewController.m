


//
//  MapViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/21.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "MapViewController.h"

#import "gaodeMapPinAnnotationView.h"
#import "ClassificationSearchView.h"//地图界面分类搜索
#import "MapSearchBoxView.h"//直接搜索
#import "MapCitySelectionView.h"//城市选择按钮
#import "CityListViewController.h"//城市选择界面

#import "SearchBoxView.h"
#import "MapSearchVC.h"//地图上的关键字搜索
#import "MapClassSearchVC.h"//分类搜索
#import "MapStoreTableView.h"
#import "MapPopUpPaopaoView.h"//自定义弹出气泡
#import "MapSearchView.h"
#import "MapStoreShowTVCell.h"
#import "MapAnnotations.h"
#import "MyShopVC.h"

#import "SearchVendorTVCell.h"

#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3
/**
 *存储用户当前位置经纬度
 */
static CLLocationCoordinate2D Position;
/**
 *用来判断是不是可以把用户位置移动到屏幕中心的方法,有两个情况会为YES 一是第一次进来的时候,而是点击定位按钮调用
 *handlePositioningBtn方法的时候 所以说再点击定位按钮的时候 重新定位把我的位置放到地图中间
 */
static BOOL center = YES;
static CGFloat  MapHierarchy = 15;
@interface MapViewController ()< SearchBoxViewDelegate, MapCitySelectionViewDelegate, CityListViewControllerDelegate, MapSearchBoxViewDelegate, ClassificationSearchViewDelegate, MapSearchVCDelegate, MapPopUpPaopaoViewDelegate, UITableViewDelegate,UITableViewDataSource,MapSearchViewDelegate,UITextFieldDelegate, MapStoreShowTVCellDelegate, SearchVendorTVCellDelegate, UITabBarControllerDelegate,MAMapViewDelegate,AMapLocationManagerDelegate,AMapNaviCompositeManagerDelegate>
/**
 *
 */
@property (nonatomic, strong)MapStoreTableView *tableView;

@property (nonatomic, strong)ClassificationSearchView * ClassificationSearchView;
@property (nonatomic, strong)MapSearchBoxView *SearchBoxView;
@property (nonatomic, strong)MapCitySelectionView *citySelectionView;
/**
 *卖方的店铺信息获取数组
 */
@property (nonatomic, strong)NSMutableArray *sellerDataArray;
/**
 *搜索view
 */
@property (nonatomic, strong)MapSearchView *searchView;
/**
 *存储搜索的类型 个人店 实体店 商品 厂家
 */
@property (nonatomic, strong)NSString *SearchType;

/**
 *搜索框后面背景view  在商家信息展示列表拉上去的时候需要改变背景颜色
 */

@property (nonatomic, strong)UIView *backgroundView;

//地图类
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@property (nonatomic, strong) AMapNaviCompositeManager *compositeManager;
@end

@implementation MapViewController
// init
- (AMapNaviCompositeManager *)compositeManager {
    if (!_compositeManager) {
        _compositeManager = [[AMapNaviCompositeManager alloc] init];  // 初始化
        _compositeManager.delegate = self;  // 如果需要使用AMapNaviCompositeManagerDelegate的相关回调（如自定义语音、获取实时位置等），需要设置delegate
    }
    return _compositeManager;
}
- (MapCitySelectionView *)citySelectionView {
    if (!_citySelectionView) {
        _citySelectionView = [[MapCitySelectionView alloc] init];
    }
    return _citySelectionView;
}

- (MapStoreTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MapStoreTableView alloc] initWithFrame:CGRectMake(0, kScreen_heigth-49-39, kScreen_widht, kScreen_heigth-100) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"MapStoreShowTVCell" bundle:nil] forCellReuseIdentifier:@"MapStoreShowTVCell"];
        [_tableView registerClass:[SearchVendorTVCell class] forCellReuseIdentifier:@"SearchVendorTVCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return  _tableView;
}

#pragma mark   方法懒加载
- (NSMutableArray *)storeArray {
    if (!_storeArray) {
        _storeArray = [NSMutableArray array];
    }
    return _storeArray;
}

- (NSMutableArray *)sellerDataArray {
    if (!_sellerDataArray) {
        _sellerDataArray = [NSMutableArray array];
    }
    return _sellerDataArray;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [super.navigationController setNavigationBarHidden:YES];

    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:NO];
   
    
}
- (void)noticeBanSliding:(NSNotificationCenter *)center{
    
    self.tableView.scrollEnabled = NO;
}

- (void)noticeAllowSliding:(NSNotificationCenter *)center{
    
    self.tableView.scrollEnabled = YES;
}
//tableView frame达到顶部
- (void)WhetherInTopNCCenter:(NSNotificationCenter *)center {
    
    _backgroundView.alpha = 1;
    
}
//tableView frame离开顶部
- (void)leaveTopNCTopNCCenter:(NSNotificationCenter *)center {
    _backgroundView.alpha = 0;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = MColor(238, 238, 238);
    self.navigationItem.title = @"地图";
    
    [self initMapView];
    
    [self initCompleteBlock];
    
    [self configLocationManager];
    [self createAdditional];
    NSNotificationCenter * BanSliding = [NSNotificationCenter defaultCenter];
    //禁止UITableVIew滑动
    [BanSliding addObserver:self selector:@selector(noticeBanSliding:) name:@"BanSliding" object:nil];
    
    NSNotificationCenter * allowSliding = [NSNotificationCenter defaultCenter];
    //允许uitableVIew滑动
    [allowSliding addObserver:self selector:@selector(noticeAllowSliding:) name:@"allowSliding" object:nil];
    //当uitableView在最顶端的时候
    NSNotificationCenter *WhetherInTopNC = [NSNotificationCenter defaultCenter];
    [WhetherInTopNC addObserver:self selector:@selector(WhetherInTopNCCenter:) name:@"WhetherInTopNC" object:nil];
    //frame离开顶部
    NSNotificationCenter *leaveTopNC = [NSNotificationCenter defaultCenter];
    [leaveTopNC addObserver:self selector:@selector(leaveTopNCTopNCCenter:) name:@"leaveTopNC" object:nil];
    [self.view addSubview:self.tableView];
    
    
    
    
    self.backgroundView  =[[UIView alloc] init];
    _backgroundView.alpha = 0;
    _backgroundView.backgroundColor = MColor(242, 242, 242);
    [self.view addSubview:_backgroundView];
    _backgroundView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, 64).widthIs(kScreen_widht).heightIs(54);
    
    self.ClassificationSearchView = [ClassificationSearchView new];
    _ClassificationSearchView.delegate = self;
    [self.view addSubview:_ClassificationSearchView];
    _ClassificationSearchView.sd_layout.leftSpaceToView(self.view, kFit(12)).topSpaceToView(self.view, 74) .widthIs(kFit(100)).heightIs(kFit(34));
    
    
    self.citySelectionView.delegate = self;
    [self.view addSubview:_citySelectionView];
    _citySelectionView.sd_layout.rightSpaceToView(self.view, kFit(12)).topEqualToView(_ClassificationSearchView).heightRatioToView(_ClassificationSearchView, 1).widthIs(kFit(60));
    
    self.SearchBoxView = [MapSearchBoxView new];
    _SearchBoxView.delegate = self;
    [self.view addSubview:_SearchBoxView];
    _SearchBoxView.sd_layout.leftSpaceToView(_ClassificationSearchView, kFit(5)).topEqualToView(_ClassificationSearchView).heightRatioToView(_ClassificationSearchView, 1).rightSpaceToView(_citySelectionView, kFit(5));
    if ([UserDataSingleton mainSingleton].networkState == 0){
        UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"您暂时没有联网" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *showAllInfoAction = [UIAlertAction actionWithTitle:@"查看WIFI" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString * urlString = @"App-Prefs:root=WIFI";
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                }
            }
        }];
        UIAlertAction *commentAction = [UIAlertAction actionWithTitle:@"查看移动网络" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString * urlString = @"App-Prefs:root=MOBILE_DATA_SETTINGS_ID";
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                }
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [actionSheetController addAction:cancelAction];
        [actionSheetController addAction:commentAction];
        [actionSheetController addAction:showAllInfoAction];
        [self presentViewController:actionSheetController animated:YES completion:nil];
    }
}

- (void)configLocationManager {
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
    
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
    
   
}
- (void)initMapView {
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        [self.mapView setDelegate:self];
        [self.mapView setZoomLevel:13 animated:NO];
        
        [self.view addSubview:self.mapView];
    }
}
- (void)cleanUpAction
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
    
    [self.locationManager setDelegate:nil];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
}

- (void)reGeocodeAction {
    [self.mapView removeAnnotations:self.mapView.annotations];
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}

- (void)locAction
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //进行单次定位请求
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:self.completionBlock];
}

#pragma mark - Initialization

- (void)initCompleteBlock
{
    __weak MapViewController *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation){
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }else{
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
        }
        //根据定位信息，添加annotation
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        [annotation setCoordinate:location.coordinate];
        
        //有无逆地理信息，annotationView的标题显示的字段不一样
        if (regeocode){
            [annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
            weakSelf.citySelectionView.citySearchLabel.text = regeocode.city;
            [annotation setSubtitle:@"我的位置"];
        }else{
            [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
            [annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
        }
        [weakSelf addAnnotationToMapView:annotation];
        [weakSelf CityInformation:location.coordinate];
        [weakSelf.mapView selectAnnotation:annotation animated:YES];
        [weakSelf.mapView setCenterCoordinate:annotation.coordinate animated:YES];
    };
}

- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation {
    [self.mapView addAnnotation:annotation];
    
}



- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        gaodeMapPinAnnotationView *annotationView = (gaodeMapPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[gaodeMapPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout   = YES;
        annotationView.animatesDrop     = YES;
        annotationView.draggable        = NO;
        annotationView.pinColor         = MAPinAnnotationColorPurple;

        if ([annotation.subtitle isEqualToString:@"我的位置"]) {
            annotationView.image = [UIImage imageNamed:@"icon_center_point"];
        }else {
            annotationView.image = [UIImage imageNamed:@"pin_red"];
        }
            if ([self.SearchType isEqualToString:@"factoryName"]) {
                for (FactoryDataModel *model in self.storeArray) {
                    if ([model.factoryLongitude floatValue] == annotation.coordinate.longitude && [model.factoryLatitude floatValue] == annotation.coordinate.latitude) {
                        annotationView.storeID = model.factoryId;// 不懂这个什么意思 就看 storeID的注释
                    }
                }
            }else {
        
                for (MapSearchStoreModel *model in self.storeArray) {
                    if ([model.storeLongitude floatValue] == annotation.coordinate.longitude && [model.storeLatitude    floatValue] == annotation.coordinate.latitude) {
                        annotationView.storeID = model.storeId;
                    }
                }
            }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [annotationView addGestureRecognizer:tap];
        return annotationView;
    }
    
    return nil;
}


//创建附加功能 地图上的附件
- (void)createAdditional{
    UIButton *PositioningBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    PositioningBtn.frame = CGRectMake(12, 120, 40, 40);
    [PositioningBtn setBackgroundImage:[UIImage imageNamed:@"icon_positioning"] forState:(UIControlStateNormal)];
    [PositioningBtn addTarget:self action:@selector(handlePositioningBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:PositioningBtn];
    
    UIButton *MyStoreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    MyStoreBtn.backgroundColor = [UIColor whiteColor];
    [MyStoreBtn setImage:[UIImage imageNamed:@"mapShop"] forState:(UIControlStateNormal)];
    [MyStoreBtn addTarget:self action:@selector(handleMyStoreBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:MyStoreBtn];
    MyStoreBtn.sd_layout.leftSpaceToView(self.view, 12).topSpaceToView(PositioningBtn, 12).widthIs(40).heightIs(40);
    
    UIImage *QrCodeImage = [UIImage imageNamed:@"QrCode_black"];
    //设置图像渲染方式
    QrCodeImage = [QrCodeImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    
    UIBarButtonItem *QrCodeBarButtonItem = [[UIBarButtonItem alloc] initWithImage:QrCodeImage style:UIBarButtonItemStylePlain target:self action:@selector(handleQrCode)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = QrCodeBarButtonItem;
    
    UIImage *shoppingCartImage = [UIImage imageNamed:@"morehs"];
    //设置图像渲染方式
    shoppingCartImage = [shoppingCartImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉渲染色
}
//进入我的店铺
- (void)handleMyStoreBtn:(UIButton *)sender {
    
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
        
        if ([UserDataSingleton mainSingleton].storeID.length < 2) {
            [self showAlert:@"您还不是商家,请到官网进行申请"];
            NSLog(@"[UserDataSingleton mainSingleton].storeID%@", [UserDataSingleton mainSingleton].storeID);
        }else {
            MyShopVC *VC = [[MyShopVC alloc] init];//商家界面
            [VC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    
    
}

- (void)MapMainSearchClick {
    MapSearchVC *VC = [[MapSearchVC alloc] init];
    VC.delegate = self;
    VC.Position = Position;
    [self presentViewController:VC animated:YES completion:nil];
}

//搜索商品返回的代理方法
- (void)searchResults:(NSString *)str storeArray:(NSArray *)array{
    
    //往地图上添加点
    if ([self.SearchType isEqualToString:@"factoryName"]) {
        for (FactoryDataModel *model in array) {
            CLLocationCoordinate2D coor;
            coor.latitude = [model.factoryLatitude floatValue];
            coor.longitude = [model.factoryLongitude floatValue];
            [self createAnnotationWithCoords:coor];
        }
    }else {
        for (MapSearchStoreModel *model in array) {
            CLLocationCoordinate2D coor;
            coor.latitude = [model.storeLatitude floatValue];
            coor.longitude = [model.storeLongitude floatValue];
            [self createAnnotationWithCoords:coor];
        }
    }
    [self.tableView reloadData];
    
}
//选择城市

- (void)CitySelectionClick {
    
    CityListViewController *cityListView = [[CityListViewController alloc]init];
    cityListView.delegate = self;
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:
                                 @{@"provinceName":@"杭州", @"longitude":@"120.161693",@"latitude":@"30.280059"},
                                 @{@"provinceName":@"西安", @"longitude":@"109.007094",@"latitude":@"34.386866"},
                                 @{@"provinceName":@"北京", @"longitude":@"116.413554",@"latitude":@"39.911013"},
                                 @{@"provinceName":@"上海", @"longitude":@"121.480237",@"latitude":@"31.236305"},
                                 @{@"provinceName":@"合肥", @"longitude":@"117.235447",@"latitude":@"31.82687"},
                                 @{@"provinceName":@"广州", @"longitude":@"113.270793",@"latitude":@"23.135308"},
                                 @{@"provinceName":@"深圳", @"longitude":@"114.066112",@"latitude":@"22.548515"}, nil];
    //历史选择城市列表
    //1获取路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"StorageCitiesData.plist"];//这里就是你将要存储的沙盒路径（.plist文件，名字自定义）
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", dataArray);
    cityListView.arrayHistoricalCity = dataArray;
    //定位城市列表
    cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:@{@"provinceName":@"杭州", @"longitude":@"120.161693",@"latitude":@"30.280059"}, nil];
    [self presentViewController:cityListView animated:YES completion:nil];
}
- (void)MapClassSearchClick {
    
    MapClassSearchVC *VC = [[MapClassSearchVC alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:NAVC animated:YES completion:nil];
    
}

- (void)handleQrCode {
    
    ScanViewController *VC = [[ScanViewController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
    
    
}
//定位按钮点击事件
- (void)handlePositioningBtn:(UIButton *)sender {
    [self.mapView removeAnnotations:self.mapView.annotations];
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//搜索我周边的商店

- (void) CityInformation:(CLLocationCoordinate2D)location{
    [self.storeArray removeAllObjects];
    [self.sellerDataArray removeAllObjects];
    [self indeterminateExample];
    
    NSString *URL_str =[NSString stringWithFormat:@"%@/searchApi/goodsList?searchType=All&Longitude=%f&Latitude=%f", kSHY_100,location.longitude, location.latitude];
    //NSLog(@"URL_str%@", URL_str);
    __block MapViewController *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:URL_str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@", responseObject);
        NSArray *array = responseObject[@"lucenePager"];
        NSDictionary *dataDic = array[0];
        NSArray *storeArray = dataDic[@"result"];
        [VC delayMethod];
        for (NSDictionary *storeDic in storeArray) {
            NSEntityDescription *des = [NSEntityDescription entityForName:@"MapSearchStoreModel" inManagedObjectContext:self.managedContext];
            //根据描述 创建实体对象
            MapSearchStoreModel *model = [[MapSearchStoreModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
            for (NSString *key in storeDic) {
                [model setValue:storeDic[key] forKey:key];
            }
            [self.storeArray addObject:model];
        }
        self.sellerDataArray = [NSMutableArray arrayWithArray:self.storeArray];
        [self.tableView reloadData];
        
        for (NSDictionary *dic in storeArray) {
            CLLocationCoordinate2D coor;
            coor.latitude = [dic[@"storeLatitude"]floatValue];
            coor.longitude = [dic[@"storeLongitude"]floatValue];
            MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
            [annotation setTitle:dic[@"storeName"]];
            [annotation setCoordinate:coor];
            [VC addAnnotationToMapView:annotation];
        //往地图上添加 标注
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"数据请求失败,请重试!" time:1.0];
        [VC delayMethod];
    }];
    
}
//地理位置编码
- (void)locationCode:(CLLocationCoordinate2D)location2D{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:location2D.latitude longitude:location2D.longitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            self.citySelectionView.citySearchLabel.text = place.locality;
            [UserCurrentPositionSingleton mainSingleton].cityName = place.locality;
        }
    }];
    
}

-(void)createAnnotationWithCoords:(CLLocationCoordinate2D) coords {
    
    
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    gaodeMapPinAnnotationView *VC = (gaodeMapPinAnnotationView*)tap.view;
    
    if ([VC.annotation.subtitle isEqualToString:@"我的位置"]) {
        return;
    }
    
    if ([self.SearchType isEqualToString:@"factoryName"]) {
        
        FactoryDataModel *factoryModel;
        for (FactoryDataModel *model in self.sellerDataArray) {
            NSLog(@"model.factoryId%@ VC.storeID%@", model.factoryId, VC.storeID);
            if ([model.factoryId isEqualToString:VC.storeID]) {
                factoryModel = model;
                [self.storeArray removeAllObjects];
                continue;
            }
        }
        [self.storeArray addObject:factoryModel];
    }else {
        MapSearchStoreModel *STOREMODEL;
        for (MapSearchStoreModel *model in self.sellerDataArray) {
            if ([model.storeId isEqualToString:VC.storeID]) {
                STOREMODEL = model;
                [self.storeArray removeAllObjects];
                continue;
            }
        }
        [self.storeArray addObject:STOREMODEL];
    }
    [self.tableView reloadData];
    [UIView animateWithDuration: 0.2 animations:^{
        self.tableView.frame =CGRectMake(0, 267, kScreen_widht, kScreen_heigth-49);
    }];
    
}

#pragma mark  --  系统提示的弹出窗 可设置事件
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

- (void)navigationTap:(MapPopUpPaopaoView *)view {

}
/**
 *进入商店
 */
- (void)enterstoreTap:(MapPopUpPaopaoView *)view {
    StoreViewController *VC = [[StoreViewController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    VC.storeStr = view.storeID;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark  CityListViewControllerDelegate 跳转到对应的城市 --把该城市设为中心店
- (void)didClickedWithCityName:(RecentSearchCity*)cityName {
    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = cityName.latitude.floatValue;
    centerCoordinate.longitude = cityName.longitude.floatValue;
    _mapView.centerCoordinate = centerCoordinate;
    self.citySelectionView.citySearchLabel.text = cityName.provinceName;

    [self.mapView setCenterCoordinate:centerCoordinate animated:YES];
    //搜索附近的商家
    [self CityInformation:centerCoordinate];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //  NSLog(@"CityInformationresponseObject%@", self.storeArray);
    return self.storeArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.SearchType isEqualToString:@"factoryName"]) {
        SearchVendorTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchVendorTVCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.entranceStoreBtn.indexPath = indexPath;
        cell.navigationBtn.indexPath = indexPath;
        cell.model = self.storeArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        MapStoreShowTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MapStoreShowTVCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.EnterBtn.tag = indexPath.row;
        //    NSLog(@"self.storeArray%@ indexPath.row%d", self.storeArray,indexPath.row);
        cell.model = self.storeArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.SearchType isEqualToString:@"factoryName"]) {
        return kFit(220);
    }else {
        return 94;
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}
#pragma mark  SearchVendorTVCell 厂家展示cell代理
/**
 *进入厂家
 */
- (void)EnterVendor:(OrderBtn *)sender {
    
    VendorViewController *VC = [[VendorViewController alloc] init];
    NSMutableArray *MArray = [NSMutableArray array];
    [MArray addObject:self.storeArray[sender.indexPath.row]];
    VC.vendorArray = MArray;
    [VC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:VC animated:YES];
}
/**
 *导航到厂家
 */
- (void)navigationToShop:(OrderBtn *)sender {
    
    FactoryDataModel *model = self.storeArray[sender.indexPath.row];
    CLLocationCoordinate2D location;
    location.latitude = [model.factoryLatitude floatValue];
    location.longitude = [model.factoryLongitude floatValue];
    [self handleMapNavigationCC:location];
    
}

//进入店铺点击事件
- (void)handleSelectBtn:(UIButton *)sender {
    MapSearchStoreModel *model = self.storeArray[sender.tag];
    StoreViewController *VC = [[StoreViewController alloc] init];
    [VC setHidesBottomBarWhenPushed:YES];
    VC.storeStr = model.storeId;
    [self.navigationController pushViewController:VC animated:YES];
    
}

//导航点击事件
- (void)handleMapNavigationCC:(CLLocationCoordinate2D)CC {
    AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:CC.latitude longitude:CC.longitude] name:@"目的地" POIId:nil];  //传入终点
    [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
}
#pragma mark - AMapNaviCompositeManagerDelegate

// 发生错误时,会调用代理的此方法
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager error:(NSError *)error {
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

// 算路成功后的回调函数,路径规划页面的算路、导航页面的重算等成功后均会调用此方法
- (void)compositeManagerOnCalculateRouteSuccess:(AMapNaviCompositeManager *)compositeManager {
    NSLog(@"onCalculateRouteSuccess,%ld",(long)compositeManager.naviRouteID);
}

// 算路失败后的回调函数,路径规划页面的算路、导航页面的重算等失败后均会调用此方法
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager onCalculateRouteFailure:(NSError *)error {
    NSLog(@"onCalculateRouteFailure error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

// 开始导航的回调函数
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager didStartNavi:(AMapNaviMode)naviMode {
    NSLog(@"didStartNavi,%ld",(long)naviMode);
}

// 当前位置更新回调
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager updateNaviLocation:(AMapNaviLocation *)naviLocation {
    NSLog(@"updateNaviLocation,%@",naviLocation);
}

// 导航到达目的地后的回调函数
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager didArrivedDestination:(AMapNaviMode)naviMode {
    NSLog(@"didArrivedDestination,%ld",(long)naviMode);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat contentY = scrollView.contentOffset.y;
    
    CGFloat Y = scrollView.frame.origin.y;
    if (Y <= 118 && contentY< 0) {
        NSNotification * notice = [NSNotification notificationWithName:@"BanSliding" object:nil userInfo:@{@"1":@"关闭"}];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
    if (Y >= 118 && contentY< 0) {
        
        NSNotification * notice = [NSNotification notificationWithName:@"BanSliding" object:nil userInfo:@{@"1":@"关闭"}];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }
    NSLog(@"Y%f contentY%f",Y,contentY);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreen_widht, 39);
    
    UIButton *iconBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    iconBtn.frame = CGRectMake(0, 0, kScreen_widht, 38);
    iconBtn.backgroundColor = [UIColor whiteColor];
    iconBtn.userInteractionEnabled = NO;
    [iconBtn setImage:[UIImage imageNamed:@"zk"] forState:(UIControlStateNormal)];
    [view addSubview:iconBtn];
    
    UILabel *SegmentationLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, kScreen_widht, 1)];
    SegmentationLineLabel.backgroundColor = MColor(238, 238, 238);
    [view addSubview:SegmentationLineLabel];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 39;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if ([UserDataSingleton mainSingleton].userID.length == 0) {
        return NO;
    }else {
        return YES;
    }
    
}

@end

