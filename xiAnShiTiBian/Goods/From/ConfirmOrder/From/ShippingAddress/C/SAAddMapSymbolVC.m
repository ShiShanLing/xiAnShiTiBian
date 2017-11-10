//
//  SAAddMapSymbolVCViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/2.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SAAddMapSymbolVC.h"
#import "CitySelectionView.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
/**
 *记录当前地图层级
 */
static CGFloat  MapHierarchy = 15;
static CLLocationCoordinate2D Position;//存储用户当前位置

@interface SAAddMapSymbolVC () <BMKMapViewDelegate,BMKLocationServiceDelegate, UITextViewDelegate, UITextFieldDelegate, CitySelectionViewDelegate, BMKGeoCodeSearchDelegate>

@property (nonatomic, strong)TakeBackKBView *takeBackKBView;

@property (nonatomic, strong)UIScrollView *scrollView;
//Details about the address的缩写  详文字
@property (nonatomic, strong)UITextView *DAATV;

@property (nonatomic, strong)UITextField *AddressTF;
/**
 *判断textView里面有没有文字 如果没有就显示提示文字,因为textview没有默认提示文字的属性 所以就用label代替了
 */
@property (nonatomic, strong)UILabel *promptLabel;

/**
 *定位
 */
@property (nonatomic, strong)BMKLocationService* locService;

@property (nonatomic, strong)UIView *additionalView;//黑色透明背景
@property (nonatomic, strong)UIView *coverNavigationView;
@property (nonatomic, strong)UIView *underlyingView;

@property (nonatomic, copy) NSString *province; // 省份

@property (nonatomic, copy) NSString *city;  // 城市

@property (nonatomic, copy) NSString *area;  // 地区

@property (nonatomic, strong) NSMutableArray *provinces;

@property (nonatomic, strong) NSMutableArray *cityArray;    // 城市数据

@property (nonatomic, strong) NSMutableArray *areaArray;    // 区信息

@property (nonatomic, strong) NSMutableArray *selectedArray;
//选择城市
@property (nonatomic,strong)CitySelectionView *CitySView;


@end

@implementation SAAddMapSymbolVC{
    /**
     *这个参数用来判断用户是否移动过地图 因为 regionDidChangeAnimated方法在你没有移动地图是默认位置是北京 但是这样会影响单地理位置编码 给用户显示现在位置 所以需要在第一次进入该方法的时候将定位的经纬度给他地理位置编码
     */
    BOOL  LocateState;
    
    BMKMapView* _mapView;
    BMKGeoCodeSearch* _geocodesearch;
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _mapView.overlooking = -30;
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    LocateState= YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置导航条
    [self createNavigation];
    //创建UIScrollView
    [self createScrollView];
    [self createMap];
    
    UIButton *mapCenterBtn = [UIButton new];
    UIImage *mapCenterImage = [UIImage imageNamed:@"MapCenter"];
    mapCenterImage = [mapCenterImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [mapCenterBtn setImage:mapCenterImage forState:(UIControlStateNormal)];
    [_mapView addSubview:mapCenterBtn];
    mapCenterBtn.sd_layout.widthIs(kFit(50)).heightIs(kFit(50)).centerXEqualToView(_mapView).centerYEqualToView(_mapView);
    
    [self createView];

}
//配置导航条
-(void)createNavigation {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color,NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];
    self.navigationItem.title = @"编辑收货地址";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = MColor(238, 238, 238);
}
//创建ScrollView
- (void)createScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth)];
    _scrollView.backgroundColor = MColor(238, 238, 238);
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kScreen_widht, kScreen_heigth-64);
    [self.view addSubview:_scrollView];
    
}
//创建地图
- (void)createMap {
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kFit(200))];
    _mapView.showMapScaleBar = YES;
    _mapView.delegate = self;
    _mapView.zoomLevel = MapHierarchy;
    _mapView.mapScaleBarPosition = CGPointMake(kScreen_widht-100, kFit(170));
    //打开定位服务
    self.locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    // _mapView.showsUserLocation = YES;//显示定位图层
    [_scrollView addSubview:_mapView];
}
//创建视图
- (void)createView {
    UILabel *phoneLabel= [UILabel new];
    phoneLabel.text = @"请对店铺地址进行编辑";
    phoneLabel.textColor = MColor(51, 51, 51);
    phoneLabel.font = MFont(kFit(15));
    [_scrollView addSubview:phoneLabel];
    phoneLabel.sd_layout.leftSpaceToView(_scrollView, kFit(12)).topSpaceToView(_mapView, kFit(15)).widthIs(kFit(200)).heightIs(kFit(15));
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bottomView];
    bottomView.sd_layout.leftSpaceToView(_scrollView, 0).topSpaceToView(phoneLabel, kFit(15)).heightIs(kFit(47.5)).rightSpaceToView(_scrollView, 0);
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"店铺地址:";
    titleLabel.textColor = MColor(51, 51, 51);
    titleLabel.font = MFont(kFit(14));
    [bottomView addSubview:titleLabel];
    titleLabel.sd_layout.leftSpaceToView(bottomView, kFit(12)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).widthIs(kFit(65));
    
    self.AddressTF = [UITextField new];
    _AddressTF.text = @"";
    _AddressTF.font = MFont(kFit(14));
    _AddressTF.delegate = self;
    _AddressTF.returnKeyType = UIReturnKeyDone;
    [bottomView addSubview:_AddressTF];
    _AddressTF.sd_layout.leftSpaceToView(titleLabel, kFit(27.5)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).rightSpaceToView(bottomView, 0);
    
    //放在显示当前位置 UITextField 上方的btn 用来触发城市选择器,(实现地理位置编码)
    UIButton *SelectCity = [UIButton buttonWithType:(UIButtonTypeSystem)];
    SelectCity.backgroundColor =  [UIColor clearColor];
    [bottomView addSubview:SelectCity];
    [SelectCity addTarget:self action:@selector(handleSelectCity) forControlEvents:(UIControlEventTouchUpInside)];
    SelectCity.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).rightSpaceToView(bottomView, 0);
    
    UIButton *submitBtn = [UIButton new];
    submitBtn.backgroundColor = kNavigation_Color;
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.titleLabel.font = MFont(kFit(17));
    [submitBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
    [submitBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [submitBtn addTarget:self action:@selector(handleSubmitBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [_scrollView addSubview:submitBtn];
    submitBtn.sd_layout.widthIs(kScreen_widht-kFit(24)).heightIs(kFit(47.5)).topSpaceToView(bottomView, kFit(20)).centerXEqualToView(_scrollView);
}
#pragma mark --  UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
#pragma mark ---UITextView
//文本内容变化的时候
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    return YES;
    
}
//点击textView的时候
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _promptLabel.text=@"";
    return YES;
}
//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    
}
//编辑完毕的时候
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        _promptLabel.text=@"请输入详情收货地址";
    }
    
    
}

- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}
//确定按钮(提交)
- (void)handleSubmitBtn {
    
    if ([_delegate respondsToSelector:@selector(ShippingAddress:)]) {
        
        [_delegate ShippingAddress:@{@"name":self.AddressTF.text, @"latitude":[NSString stringWithFormat:@"%f", Position.latitude], @"longitude":[NSString stringWithFormat:@"%f", Position.longitude]}];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//view的点击事件 隐藏键盘
- (void)handleTap {
    [self.AddressTF resignFirstResponder];
    [self.DAATV resignFirstResponder];
}
#pragma mark --- BMKMapViewDelegate
/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    
    
    
}
//按地图相应的方法
- (void)mapview:(BMKMapView *)mapView onForceTouch:(CLLocationCoordinate2D)coordinate force:(CGFloat)force maximumPossibleForce:(CGFloat)maximumPossibleForce {
    
    
}
//长按地图响应的方法
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate {
    
    
}
/**
 *双击地图时会回调此接口
 *@param mapView 地图View
 *@param coordinate 返回双击处坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    
    
    
}

#pragma mark --- BMKLocationServiceDelegate
//地图区域发生变化时调用
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MapHierarchy = mapView.zoomLevel;
    CLLocationCoordinate2D centerCoordinate;
    if (LocateState == YES) {
        centerCoordinate =Position;
        LocateState = NO;
    }else {
        centerCoordinate =mapView.region.center;
        Position=mapView.region.center;
    }
    
    
    NSLog(@" regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            
            NSDictionary *location =[place addressDictionary];
            NSLog(@"国家：%@",[location objectForKey:@"Country"]);
            NSLog(@"城市：%@",[location objectForKey:@"State"]);
            NSLog(@"区：%@",[location objectForKey:@"SubLocality"]);
            NSLog(@"位置：%@", place.name);
            NSLog(@"国家：%@", place.country);
            NSLog(@"城市：%@", place.locality);
            NSLog(@"区：%@", place.subLocality);
            NSLog(@"街道：%@", place.thoroughfare);
            NSLog(@"子街道：%@", place.subThoroughfare);
            _AddressTF.text = [NSString stringWithFormat:@"%@%@%@", [location objectForKey:@"State"], place.locality, place.subLocality];
        }
    }];
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser{
    NSLog(@"start locate");
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    
    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    Position =region.center;
    _mapView.region = region;
    
    [_locService stopUserLocationService];
}
/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser {
    NSLog(@"stop locate");
}
/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"location error");
}


#pragma mark   BMKGeoCodeSearchDelegate

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
       // [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        [self delayMethod];
       
    }
}

- (void)handleSelectCity {

    [self ShoppingCellClickEvent];
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
- (void)ShoppingCellClickEvent{//
    
    //xia面是弹窗的初始化
    UIViewController *topVC = [self appRootViewController];
    if (!self.additionalView) {
        self.additionalView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.additionalView.backgroundColor = [UIColor blackColor];
        self.additionalView.alpha = 0.3f;
        self.additionalView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
        tapGesture.numberOfTapsRequired=1;
        [self.additionalView addGestureRecognizer:tapGesture];
    }
    [topVC.view addSubview:self.additionalView];
    
    self.CitySView = [[CitySelectionView alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(450))];
    //  NSLog(@"GoodsDataArray%@", self.GoodsDataArray);
    
    self.CitySView.delegate = self;
    [topVC.view addSubview:self.CitySView];
    
    [UIView animateWithDuration: 0.2 animations:^{
        self.CitySView.frame =CGRectMake(0, kScreen_heigth-kFit(250), kScreen_widht, kFit(250));
    }];
}

//城市的选择 点击事件
- (void)CitySelectionConfirmOrCancel:(UIButton *)sender cityName:(NSString *)cityName regionName:(NSString *)regionName {
    if (sender.tag == 132) {
        [self.additionalView removeFromSuperview];
        [self.coverNavigationView removeFromSuperview];
        [UIView animateWithDuration:0.3 animations:^{
            _CitySView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, 300);
        }];
    }else {
        
        self.AddressTF.text = [NSString stringWithFormat:@"%@ %@", cityName, regionName];
        [self.additionalView removeFromSuperview];
        [self.coverNavigationView removeFromSuperview];
        [UIView animateWithDuration:0.3 animations:^{
            _CitySView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, 300);
        }];
        
        BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
        geocodeSearchOption.city= cityName;
        geocodeSearchOption.address = regionName;
        BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
        if(flag)
        {
            [self indeterminateExample];
            NSLog(@"geo检索发送成功");
        }
        else
        {
            NSLog(@"geo检索发送失败");
        }

    }
}

- (void)hiddenView {
    
    [self.additionalView removeFromSuperview];
    [self.coverNavigationView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _CitySView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, 300);
    }];


}
//让城市选择器消失
- (void)hideWindow:(UIGestureRecognizer *)tap {
    [self.additionalView removeFromSuperview];
    [self.coverNavigationView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _CitySView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, 300);
    }];
}





@end
