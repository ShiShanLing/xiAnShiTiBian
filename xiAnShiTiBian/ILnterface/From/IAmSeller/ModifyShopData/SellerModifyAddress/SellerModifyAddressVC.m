//
//  SellerModifyAddressVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/19.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerModifyAddressVC.h"
/**
 *记录当前地图层级
 */
static CGFloat  MapHierarchy = 15;
static CLLocationCoordinate2D Position;//存储用户当前位置
@interface SellerModifyAddressVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate, UITextViewDelegate, UITextFieldDelegate>

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
 *基本地图
 */
@property (nonatomic, strong)BMKMapView* mapView;
/**
 *定位
 */
@property (nonatomic, strong)BMKLocationService* locService;

@end

@implementation SellerModifyAddressVC {
    /**
     *这个参数用来判断用户是否移动过地图 因为 regionDidChangeAnimated方法在你没有移动地图是默认位置是北京 但是这样会影响单地理位置编码 给用户显示现在位置 所以需要在第一次进入该方法的时候将定位的经纬度给他地理位置编码
     */
    BOOL  LocateState;
}

- (void) registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyboardWasHidden:(NSNotification *) notif {
    
    self.scrollView.contentSize = CGSizeMake(kScreen_widht, kScreen_heigth - 64);
    [_scrollView setContentOffset:CGPointMake(0, - 64)];
    
}

- (void) keyboardWasShown:(NSNotification *) notif{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    int height = kScreen_heigth - keyboardSize.height;
    int CHA = height - 270 ;
    CGSize size = CGSizeMake(kScreen_widht, kScreen_heigth);
    size.height += CHA;
    self.scrollView.contentSize = size;
    [_scrollView setContentOffset:CGPointMake(0, CHA)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听键盘的出现和回收
     [self registerForKeyboardNotifications];
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


-(void)createNavigation {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color,NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    self.title = @"店铺地址";
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = MColor(238, 238, 238);
}
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
- (void)createMap {

    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kFit(200))];
    self.mapView.showMapScaleBar = YES;
    _mapView.delegate = self;
    self.mapView.zoomLevel = MapHierarchy;
    self.mapView.mapScaleBarPosition = CGPointMake(kScreen_widht-100, kFit(170));
    //打开定位服务
    self.locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    // _mapView.showsUserLocation = YES;//显示定位图层
    [_scrollView addSubview:self.mapView];

    
}
//创建视图
- (void)createView{
    UILabel *phoneLabel= [UILabel new];
    phoneLabel.text = @"请对店铺地址进行编辑";
    phoneLabel.textColor = MColor(51, 51, 51);
    phoneLabel.font = MFont(kFit(15));
    [_scrollView addSubview:phoneLabel];
    phoneLabel.sd_layout.leftSpaceToView(_scrollView, kFit(12)).topSpaceToView(_mapView, kFit(15)).widthIs(kFit(200)).heightIs(kFit(15));
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bottomView];
    bottomView.sd_layout.leftSpaceToView(_scrollView, 0).topSpaceToView(phoneLabel, kFit(20)).heightIs(kFit(47.5)).rightSpaceToView(_scrollView, 0);
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"店铺地址:";
    titleLabel.textColor = MColor(51, 51, 51);
    titleLabel.font = MFont(kFit(14));
    [bottomView addSubview:titleLabel];
    titleLabel.sd_layout.leftSpaceToView(bottomView, kFit(12)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).widthIs(kFit(60));
    
    self.AddressTF = [UITextField new];
    _AddressTF.text = @"";
    _AddressTF.font = MFont(kFit(14));
    _AddressTF.delegate = self;
    _AddressTF.returnKeyType = UIReturnKeyDone;
    [bottomView addSubview:_AddressTF];
    _AddressTF.sd_layout.leftSpaceToView(titleLabel, kFit(27.5)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).rightSpaceToView(bottomView, 0);
    
    
    self.DAATV = [UITextView new];
    self.DAATV.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    self.DAATV.delegate = self;//设置它的委托方法
    self.DAATV.returnKeyType = UIReturnKeyDone;
    self.DAATV.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    self.DAATV.font = [UIFont systemFontOfSize:kFit(15)];
    
    self.DAATV.scrollEnabled = YES;//是否可以拖动
    self.DAATV.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    [_scrollView addSubview:_DAATV];
    _DAATV.sd_layout.leftSpaceToView(_scrollView, 0).topSpaceToView(bottomView, kFit(12)).rightSpaceToView(_scrollView, 0).heightIs(kFit(70));
    
    
    self.promptLabel = [UILabel new];
    _promptLabel.text = @"请输入详情收货地址";
    _promptLabel.font = [UIFont systemFontOfSize:kFit(15)];
    _promptLabel.textColor = [UIColor lightGrayColor];
    _promptLabel.userInteractionEnabled = NO;
    [_scrollView addSubview:_promptLabel];
    _promptLabel.sd_layout.leftSpaceToView(_scrollView, kFit(12)).topEqualToView(_DAATV).rightSpaceToView(_scrollView, kFit(12)).heightIs(kFit(30));
    
    UIButton *submitBtn = [UIButton new];
    submitBtn.backgroundColor = kNavigation_Color;
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.titleLabel.font = MFont(kFit(17));
    [submitBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
    [submitBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [submitBtn addTarget:self action:@selector(handleSubmitBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [_scrollView addSubview:submitBtn];
    submitBtn.sd_layout.widthIs(kScreen_widht-kFit(24)).heightIs(kFit(47.5)).topSpaceToView(_DAATV, kFit(20)).centerXEqualToView(_scrollView);
    
    
    
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
    //storeapi/storeDescription  修改店铺简介接口  storeId：店铺id  memberId：会员id  description：修改的店铺简介
    if (_AddressTF.text.length == 0 || self.DAATV.text.length == 0) {
        [self showAlert:@"选项不能为空" time:1.0];
        return;
    }
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/storeapi/storeAddress", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"storeId"] = self.model.storeId;
    URL_Dic[@"memberId"] = self.model.memberId;
    URL_Dic[@"storeLongitude"] =[NSString stringWithFormat:@"%f", Position.longitude];
    URL_Dic[@"storeLatitude"] = [NSString stringWithFormat:@"%f", Position.latitude];
    URL_Dic[@"areaInfo"] = _AddressTF.text;
    URL_Dic[@"storeAddress"] = self.DAATV.text;
    NSLog(@"URL_Str%@--URL_Dic%@",URL_Str, URL_Dic);
    __block SellerModifyAddressVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@", responseObject);
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC showAlert:responseObject[@"msg"] time:1.0];
            [VC.navigationController popViewControllerAnimated:YES];
        }else {
            [VC showAlert:responseObject[@"msg"] time:1.0];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@", error);
        [VC showAlert:@"网络链接超时请重试!" time:1.3];
    }];
}
//view的点击事件 隐藏键盘
- (void)handleTap {
    [self.AddressTF resignFirstResponder];
    [self.DAATV resignFirstResponder];
}
#pragma mark --- 地图的代理
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
//地图区域发生变化时调用
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MapHierarchy = mapView.zoomLevel;
    NSLog(@"------------------------%f", mapView.zoomLevel);
    CLLocationCoordinate2D centerCoordinate;
    if (LocateState == YES) {
        centerCoordinate =Position;
        LocateState = NO;
    }else {
        centerCoordinate =mapView.region.center;
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

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _mapView.overlooking = -30;
    _locService.delegate = self;
    LocateState= YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//系统提示的弹出窗
- (void)timerFireMethod:(NSTimer*)theTimer {//弹出框
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message time:(CGFloat)time{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    
    [NSTimer scheduledTimerWithTimeInterval:time
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
