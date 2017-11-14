//
//  SAAddMapSymbolVCViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/2.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SAAddMapSymbolVC.h"
#import "CitySelectionView.h"
#import<AMapSearchKit/AMapSearchKit.h>
#import "GeocodeAnnotation.h"
#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3
/**
 *记录当前地图层级
 */
static CGFloat  MapHierarchy = 15;
static CLLocationCoordinate2D Position;//存储用户当前位置

@interface SAAddMapSymbolVC () <UITextViewDelegate, UITextFieldDelegate, CitySelectionViewDelegate,AMapLocationManagerDelegate,MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic, strong)TakeBackKBView *takeBackKBView;

@property (nonatomic, strong)UIScrollView *scrollView;
//Details about the address的缩写  详文字
@property (nonatomic, strong)UITextView *DAATV;

@property (nonatomic, strong)UILabel *AddressTF;
/**
 *判断textView里面有没有文字 如果没有就显示提示文字,因为textview没有默认提示文字的属性 所以就用label代替了
 */
@property (nonatomic, strong)UILabel *promptLabel;


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
//地图类
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property(nonatomic,strong)AMapSearchAPI * search;
@property(nonatomic,strong)AMapReGeocodeSearchRequest *regeo ;

@end

@implementation SAAddMapSymbolVC{
    /**
     *这个参数用来判断用户是否移动过地图 因为 regionDidChangeAnimated方法在你没有移动地图是默认位置是北京 但是这样会影响单地理位置编码 给用户显示现在位置 所以需要在第一次进入该方法的时候将定位的经纬度给他地理位置编码
     */
    BOOL  LocateState;

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
    __weak SAAddMapSymbolVC *weakSelf = self;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
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
            [annotation setSubtitle:@"我的位置"];
        }else{
            [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
            [annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
        }
        [weakSelf.mapView setCenterCoordinate:annotation.coordinate animated:YES];
    }];
}
- (void)initMapView {
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, 400)];
        [self.mapView setDelegate:self];
        [self.mapView setZoomLevel:13 animated:NO];
        _search = [[AMapSearchAPI alloc]init];
        _search.delegate = self;
        [_scrollView addSubview:_mapView];
        
        //地图中心的经纬度,  获取的按钮
        UIButton *mapCenterBtn = [UIButton new];
        UIImage *mapCenterImage = [UIImage imageNamed:@"icon_center_point"];
        mapCenterImage = [mapCenterImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [mapCenterBtn setImage:mapCenterImage forState:(UIControlStateNormal)];
        [self.mapView addSubview:mapCenterBtn];
        mapCenterBtn.sd_layout.centerXEqualToView(self.mapView).centerYEqualToView(self.mapView).widthIs(50).heightIs(50);
        
    }
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil){
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = nil;
        annotationView.pinColor                     = MAPinAnnotationColorRed;
        annotationView.image = [UIImage imageNamed:@"icon_center_point"];
        return annotationView;
    }
    return nil;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    LocateState= YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [AMapServices sharedServices].enableHTTPS = NO;
    [self createScrollView];
    [self initMapView];
    [self configLocationManager];
    //配置导航条
    [self createNavigation];
    //创建UIScrollView

    [self createMap];

    
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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, 667)];
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
    
    self.AddressTF = [UILabel new];
    _AddressTF.text = @"";
    _AddressTF.font = MFont(kFit(14));
    _AddressTF.numberOfLines = 0;
    [bottomView addSubview:_AddressTF];
    _AddressTF.sd_layout.leftSpaceToView(titleLabel, kFit(10)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).rightSpaceToView(bottomView, 0);
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
    //需要翻地理位置编码
    if (sender.tag == 132) {
        [self.additionalView removeFromSuperview];
        [self.coverNavigationView removeFromSuperview];
        [UIView animateWithDuration:0.3 animations:^{
            _CitySView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, 300);
        }];
    }else {
        //如果将坐标转为地址,需要进行逆地理编码
        //设置逆地理编码查询参数 ,进行逆地编码时，请求参数类为 AMapReGeocodeSearchRequest，location为必设参数。
        AMapGeocodeSearchRequest *AMGSR = [[AMapGeocodeSearchRequest alloc] init];
        AMGSR.address =[NSString stringWithFormat:@"%@%@", cityName, regionName];
        [_search AMapGeocodeSearch:AMGSR];
        self.AddressTF.text = [NSString stringWithFormat:@"%@%@", cityName, regionName];
        [self.additionalView removeFromSuperview];
        [self.coverNavigationView removeFromSuperview];
        [UIView animateWithDuration:0.3 animations:^{
            _CitySView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, 300);
        }];
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

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"%f",mapView.region.center.latitude); //拿到中心点的经纬度
    NSLog(@"%f\n",mapView.region.center.longitude);
    //如果将坐标转为地址,需要进行逆地理编码
    //设置逆地理编码查询参数 ,进行逆地编码时，请求参数类为 AMapReGeocodeSearchRequest，location为必设参数。
    _regeo = [[AMapReGeocodeSearchRequest alloc] init];
    _regeo.location = [AMapGeoPoint locationWithLatitude:mapView.region.center.latitude longitude:mapView.region.center.longitude];
    _regeo.requireExtension = YES;
    [_search AMapReGoecodeSearch:_regeo];
}

#pragma mark -  AMapSearchDelegate

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    [self showAlert:@"地理位置编辑失败!" time:1.2];
    NSLog(@"Error: %@ - %@", error);
}

/* 逆地理编码回调. */

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response.regeocode != nil){
        //解析response获取地址描述，具体解析见 Demo
        //位置信息
        self.AddressTF.text = response.regeocode.formattedAddress;
        NSLog(@"reGeocode:%@", response.regeocode.formattedAddress);//获得的中心点地址
    }
}
/**
 * @brief 地理编码查询回调函数
 * @param request  发起的请求，具体字段参考 AMapGeocodeSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapGeocodeSearchResponse 。
 */
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    
//    CLLocationCoordinate2D CLLC;
//    CLLC.latitude  =
    if (response.geocodes.count == 0) {
        [self showAlert:@"抱歉查不到改地址!" time:1.0];
        return;
    }
    NSMutableArray *annotations = [NSMutableArray array];
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
        GeocodeAnnotation *geocodeAnnotation = [[GeocodeAnnotation alloc] initWithGeocode:obj];
        
        [annotations addObject:geocodeAnnotation];
    }];
    
    if (annotations.count == 1){
        GeocodeAnnotation * GA= annotations[0];
        [self.mapView setCenterCoordinate:GA.coordinate animated:YES];
    } else{
        GeocodeAnnotation * GA= annotations[0];
        [self.mapView setCenterCoordinate:GA.coordinate animated:YES];
    }
    
}

@end
