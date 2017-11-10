


//
//  MapViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/21.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "MapViewController.h"


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
@interface MapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate, SearchBoxViewDelegate, MapCitySelectionViewDelegate, CityListViewControllerDelegate, MapSearchBoxViewDelegate, ClassificationSearchViewDelegate, MapSearchVCDelegate, MapPopUpPaopaoViewDelegate, UITableViewDelegate,UITableViewDataSource,MapSearchViewDelegate,UITextFieldDelegate, MapStoreShowTVCellDelegate, SearchVendorTVCellDelegate, UITabBarControllerDelegate>
/**
 *
 */
@property (nonatomic, strong)MapStoreTableView *tableView;
/**
 *基本地图
 */
@property (nonatomic, strong)BMKMapView* mapView;
/**
 *定位
 */
@property (nonatomic, strong)BMKLocationService* locService;


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
@end

@implementation MapViewController

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
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:NO];
    
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.delegate = self;
    _locService.delegate = self;
    
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

    [self createMapView];
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


//创建地图
- (void)createMapView {
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth)];
    _mapView.isSelectedAnnotationViewFront = YES;
    self.mapView.showMapScaleBar = YES;
    _mapView.overlooking = -30;
    [_mapView setMapType:BMKMapTypeStandard];
    self.mapView.zoomLevel = MapHierarchy;
    self.mapView.mapScaleBarPosition = CGPointMake(kScreen_widht-100, kScreen_heigth-70);
    //打开定位服务
    self.locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    [self.view addSubview:self.mapView];

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
    
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.storeArray removeAllObjects];
    self.storeArray = [NSMutableArray arrayWithArray:array];
    [self.sellerDataArray removeAllObjects];
    self.sellerDataArray = [NSMutableArray arrayWithArray:self.storeArray];
    _mapView.delegate = self;
    NSLog(@"self.sellerDataArray%@", self.sellerDataArray);
    self.SearchType = str;
    
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
    center = YES;
    [_locService startUserLocationService];
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    
}
//地图区域发生变化时调用
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MapHierarchy = mapView.zoomLevel;
    BMKCoordinateRegion region;
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    region.center= centerCoordinate;
    
   // NSLog(@" regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            NSDictionary *location =[place addressDictionary];
                   }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//搜索我周边的商店
- (void) CityInformation:(CLLocationCoordinate2D)location{
    [self.storeArray removeAllObjects];
    [self.sellerDataArray removeAllObjects];
    BMKCoordinateRegion region;
    [UserCurrentPositionSingleton mainSingleton].Position = location;
    
    region.center.latitude = location.latitude;
    region.center.longitude = location.longitude;
    region.span.latitudeDelta = 0.25;
    region.span.longitudeDelta = 0.25;
    _mapView.region = region;
    [self indeterminateExample];
    
    NSString *URL_str =[NSString stringWithFormat:@"%@/searchApi/goodsList?searchType=All&Longitude=%f&Latitude=%f", kSHY_100,location.longitude, location.latitude];
    //NSLog(@"URL_str%@", URL_str);
    __block MapViewController *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
 
    [session GET:URL_str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
            BMKPointAnnotation *pa = [[BMKPointAnnotation alloc] init];
            pa.coordinate = coor;
            pa.title = dic[@"storeName"];
            [_mapView addAnnotation:pa];
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
    
    BMKPointAnnotation *pa = [[BMKPointAnnotation alloc] init];
    pa.coordinate = coords;
    [_mapView addAnnotation:pa];
    
}

#pragma mark  BMKLocationServiceDelegate 百度地图定位的方法
/**
 *在地图View将要启动定位时, 会调用此函数
 * mapView 地图View
 */
- (void)willStartLocatingUser {
    NSLog(@"start locate");
}

/**
 *用户位置更新后，会调用此函数   在这里请求附近的商家
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];

    if (center) {
        [_mapView removeOverlays:_mapView.overlays];
        [_mapView removeAnnotations:_mapView.annotations];
        
        Position = userLocation.location.coordinate;
        BMKCoordinateRegion region;
        region.center.latitude = userLocation.location.coordinate.latitude;
        region.center.longitude = userLocation.location.coordinate.longitude;
        _mapView.region = region;
        [self locationCode:region.center];
        [self CityInformation: region.center];
        center= NO;
    }
}

/**
 *在地图View停止定位后，会调用此函数
 * mapView 地图View
 */

- (void)didStopLocatingUser {
    NSLog(@"stop locate");
}
/**
 *定位失败后，会调用此函数
 *@param mapView 地图
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];//判断是否开启了定位
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        
        UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示:" message:@"您还没有定位, 如果您关闭了定位请在手机设置里面打开" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不用了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"去打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        // 3.将“取消”和“确定”按钮加入到弹框控制器中
        [alertV addAction:cancle];
        [alertV addAction:confirm];
        // 4.控制器 展示弹框控件，完成时不做操作
        [self presentViewController:alertV animated:YES completion:^{
            nil;
        }];
    }else {
        //[self showAlert:@"定位失败,请检查您的网络"];
    }
   // NSLog(@"location error");
}
#pragma mark implement BMKMapViewDelegate
/**
 *根据anntation生成对应的View
 *@param view 地图
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation {
    
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[MapAnnotations alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((MapAnnotations*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((MapAnnotations*)annotationView).animatesDrop = YES;
        
    }
    
    if ([self.SearchType isEqualToString:@"factoryName"]) {
        
        for (FactoryDataModel *model in self.storeArray) {
            
            if ([model.factoryLongitude floatValue] == annotation.coordinate.longitude && [model.factoryLatitude floatValue] == annotation.coordinate.latitude) {
                ((MapAnnotations*)annotationView).storeID = model.factoryId;// 不懂这个什么意思 就看 storeID的注释
           //     NSLog(@"不懂这个什么意思 就看 storeID的注释%@", model.factoryId);
            }
        }
    }else {
    
        for (MapSearchStoreModel *model in self.storeArray) {
            if ([model.storeLongitude floatValue] == annotation.coordinate.longitude && [model.storeLatitude    floatValue] == annotation.coordinate.latitude) {
                ((MapAnnotations*)annotationView).storeID = model.storeId;
            }
        }
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [annotationView addGestureRecognizer:tap];
    
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    annotationView.userInteractionEnabled = YES;
    return annotationView;
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    MapAnnotations *VC = (MapAnnotations*)tap.view;
    
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
//    AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
//    //传入终点坐标
//    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:39.918058 longitude:116.397026] name:@"故宫" POIId:nil];
//    //启动
//    [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
//    //节点数组
//    NSMutableArray *nodesArray = [[NSMutableArray alloc] initWithCapacity:2];
//    //起点
//    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
//    startNode.pos = [[BNPosition alloc] init];
//    NSLog(@"起点%f,%f", Position.longitude, Position.latitude);
//    startNode.pos.x = Position.longitude;
//    startNode.pos.y = Position.latitude;
//    startNode.pos.eType = BNCoordinate_BaiduMapSDK;
//    [nodesArray addObject:startNode];
//    //终点
//    BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
//    endNode.pos = [[BNPosition alloc] init];
//    NSLog(@"终点%f,%f", view.storePosition.longitude, view.storePosition.latitude);
//    endNode.pos.x = view.storePosition.longitude;
//    endNode.pos.y = view.storePosition.latitude;
//    endNode.pos.eType = BNCoordinate_BaiduMapSDK;
//    [nodesArray addObject:endNode];
//    //发起路径规划
//    [BNCoreServices_RoutePlan setDisableOpenUrl:YES];
//  [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Recommend naviNodes:nodesArray time:nil delegete:self userInfo:nil];
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
#pragma mark  CityListViewControllerDelegate 跳转到对应的城市
- (void)didClickedWithCityName:(RecentSearchCity*)cityName {
    
    BMKCoordinateRegion region;
    region.center.latitude = cityName.latitude.floatValue;
    region.center.longitude = cityName.longitude.floatValue;
    region.span.latitudeDelta = 0.25;
    region.span.longitudeDelta = 0.25;
  //  Position = region.center;
    _mapView.region = region;
    self.citySelectionView.citySearchLabel.text = cityName.provinceName;
    NSLog(@"didClickedWithCityName%@ self.citySelectionView.citySearchLabel.text%@", cityName.provinceName, self.citySelectionView.citySearchLabel.text);
    [self CityInformation: region.center];
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

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    MapAnnotations *mapAnnotations = view.annotation;
    
}
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi {


}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    if ([UserDataSingleton mainSingleton].userID.length == 0) {
        return NO;
    }else {
        return YES;
    }
    
}

@end
