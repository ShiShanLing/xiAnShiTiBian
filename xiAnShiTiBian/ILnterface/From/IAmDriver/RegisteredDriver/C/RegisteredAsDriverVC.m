//
//  RegisteredAsDriverVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/10.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "RegisteredAsDriverVC.h"
#import "InputView.h" //输入框view

static BOOL agreement;//判断是否接受协议 设置默认为NO;

@interface RegisteredAsDriverVC ()<UITextFieldDelegate,UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,DPImagePickerDelegate, CarChooseViewDelegate>

/**
 *汽车型号选择 Fahrzeugmodell
 */
@property (nonatomic, strong) CarChooseView *FPickerView;
/**
 *车型选择时的背景色
 */
@property (nonatomic, strong)UIView *backImageView;

@property (nonatomic, strong)UIScrollView *scrollView;
/**
 *和在UIScrollView上层的UIView 承载控件用的
 */
@property (nonatomic, strong)UIView *wrapperView;
/**
 *开店协议 view
 */
@property (nonatomic, strong)UIView *OpenShopAgreementView;
/**
 *个人信息 view
 */
@property (nonatomic, strong)UIView *PersonalInformationView;
//输入用户名
@property (nonatomic, strong)InputView *personalNameInputView;
//输入联系方式
@property (nonatomic, strong)InputView *personalPhoneInputView;
//输入身份证
@property (nonatomic, strong)InputView *personalIdCardInputView;
/**
 *店铺信息 view
 */
@property (nonatomic, strong)UIView *StoreInformationView;
//输入车牌号
@property (nonatomic, strong)InputView *LicensePlateNumberInputView;
//输入车辆类型
@property (nonatomic, strong)InputView *CarTypeInputView;
//输入车辆品牌
@property (nonatomic, strong)InputView *CarBrandInputView;
//输入车辆所有人
@property (nonatomic, strong)InputView *CarBelongInputView;
//输入车辆注册时间 VehicleRegistrationTime
@property (nonatomic, strong)InputView *VehicleRegistrationTimeInputView;
/**
 *提交按钮
 */
@property (nonatomic, strong)UIButton *submitButton;


@property (nonatomic, strong)UIImagePickerController *picker;
//  上传图片数组
@property (nonatomic, strong)NSMutableArray *picArray;
//  上传图片字典
@property (nonatomic, strong)NSMutableDictionary *picDictionary;


/**
 *存储车辆类型的 数组
 */
@property (nonatomic, strong)NSMutableArray *VehicleTypeArray;
/**
 *存储用户选择的当前车型
 */
@property (nonatomic, strong)NSMutableDictionary *chooseCarTypeDic;
@end

@implementation RegisteredAsDriverVC{
    /**
     *这个参数用来判断用户是否移动过地图 因为 regionDidChangeAnimated方法在你没有移动地图是默认位置是北京 但是这样会影响单地理位置编码 给用户显示现在位置 所以需要在第一次进入该方法的时候将定位的经纬度给他地理位置编码
     */
    BOOL  LocateState;
    //身份证 image1
    UIButton *IdCardBtnOne;
    //身份证 image2
    UIButton *IdCardBtnTwo;
    //驾驶证
    UIButton *driverLicenseBtnOne;
    UIButton *driverLicenseBtnTwo;
    //行驶证
    UIButton *drivingLicenseBtnOne;
    UIButton *drivingLicenseBtnTwo;
    NSInteger btnTag;
    
}

- (NSMutableArray *)VehicleTypeArray {
    if (!_VehicleTypeArray) {
        _VehicleTypeArray  = [NSMutableArray array];
    }
    return _VehicleTypeArray;
}
- (NSMutableDictionary *)chooseCarTypeDic {
    if (!_chooseCarTypeDic) {
        _chooseCarTypeDic = [NSMutableDictionary dictionary];
    }
    return _chooseCarTypeDic;
}
- (NSMutableDictionary *)picDictionary {
    if (_picDictionary == nil) {
        _picDictionary = [NSMutableDictionary dictionary];
    }
    return _picDictionary;
}
- (NSMutableArray *)picArray {
    if (_picArray == nil) {
        _picArray = [NSMutableArray arrayWithCapacity:6];
    }
    return _picArray;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
        _scrollView.sd_layout.topSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    }
    return _scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"成为司机";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = MColor(238, 238, 238);
    [self createScrollView];
    NSLog(@"%f---测试数据---%f", self.scrollView.frame.size.height, self.scrollView.contentSize.height);
}
-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
    agreement = NO;
    
}
- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//创建 UIScrollView
- (void)createScrollView {
    
    self.wrapperView = [UIView new];
    _wrapperView.backgroundColor = MColor(238, 238, 238);
    [self.scrollView addSubview:self.wrapperView];
    [self.scrollView setupAutoContentSizeWithBottomView:self.wrapperView bottomMargin:0];
    //协议
    [self createOpenShopAgreement];
    //个人信息
    [self createPersonalInformation];
    //店铺信息
    [self createStoreInformation];
    
    self.submitButton = [UIButton new];
    _submitButton.titleLabel.font = MFont(kFit(17));
    _submitButton.backgroundColor = [UIColor whiteColor];
    _submitButton.layer.cornerRadius = 3;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton setTitle:@"提交申请" forState:(UIControlStateNormal)];
    [_submitButton setTitleColor:MColor(60, 186, 153) forState:(UIControlStateNormal)];
    [_submitButton addTarget:self action:@selector(SubmitDriverRegistrationData) forControlEvents:(UIControlEventTouchUpInside)];
    [self.scrollView addSubview:_submitButton];
    _submitButton.sd_layout.topSpaceToView(self.StoreInformationView, kFit(10)).widthIs(kFit(300)).heightIs(kFit(50)).centerXEqualToView(self.scrollView);
    
    self.wrapperView.sd_layout.
    leftEqualToView(self.scrollView)
    .rightEqualToView(self.scrollView)
    .topEqualToView(self.scrollView)
    .heightIs(kScreen_heigth * 3);
    [self.wrapperView setupAutoHeightWithBottomView:_submitButton bottomMargin:10];
    
}
//创建开店协议模块
- (void)createOpenShopAgreement{
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.wrapperView addSubview:bottomView];
    self.OpenShopAgreementView = bottomView;
    bottomView.sd_layout
    .leftSpaceToView(_wrapperView, 0)
    .topSpaceToView(_wrapperView, kFit(10))
    .rightSpaceToView(_wrapperView, 0)
    .heightIs(kFit(221));
    {
        UIView *agreementView = [UIView new];
        agreementView.backgroundColor = [UIColor yellowColor];
        agreementView.layer.borderWidth = 1;
        agreementView.layer.borderColor = MColor(134, 134, 134).CGColor;
        agreementView.layer.cornerRadius = 3;
        agreementView.layer.masksToBounds = YES;
        [bottomView addSubview:agreementView];
        agreementView.sd_layout.centerXEqualToView(bottomView).centerYEqualToView(bottomView).widthIs(kFit(351)).heightIs(kFit(200));
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.font = MFont(kFit(14));
        titleLabel.text = @"成为司机须知";
        titleLabel.textAlignment = 1;
        [agreementView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(agreementView, 0).topSpaceToView(agreementView, kFit(5)).rightSpaceToView(agreementView, 0).heightIs(kFit(14));
        UITextView *contentTV = [UITextView new];
        contentTV.text = @"1.1111111111111111111 \n2.22222222222222 \n3.3333333333333333333 \n4.4444444444444444444 \n5.555555555555555555 \n6.666666666666666666666 \n7.7777777777777777 \n8.8888888888888888 \n9.999999999999999999999 \n9.999999999999999999999 \n9.999999999999999999999 \n9.999999999  999999999999 \n9.999999999999999999999";
        contentTV.editable = NO;
        contentTV.textColor = MColor(51, 51, 51);
        contentTV.font = MFont(kFit(12));
        [agreementView addSubview:contentTV];
        contentTV.sd_layout.leftSpaceToView(agreementView, kFit(5)).topSpaceToView(titleLabel, kFit(5)).rightSpaceToView(agreementView, kFit(5)).bottomSpaceToView(agreementView, kFit(25));
        UIButton *AgreeDealBtn = [UIButton new];
        [AgreeDealBtn setTitle:@"我已阅读并且同意协议内容" forState:(0)];
        [AgreeDealBtn setTitleColor:MColor(51, 51, 51) forState:0];
        AgreeDealBtn.titleLabel.font = MFont(kFit(14));
        [agreementView addSubview:AgreeDealBtn];
        AgreeDealBtn.sd_layout.heightIs(kFit(15)).widthIs(190).centerXEqualToView(agreementView).topSpaceToView(contentTV, kFit(5));
        UIButton *chooseBtn = [UIButton new];
        [chooseBtn setImage:[UIImage imageNamed:@"wd-wssj-cwsj-xy"] forState:(UIControlStateNormal)];
        [chooseBtn setImage:[UIImage imageNamed:@"wd-cwsj-xygx"] forState:(UIControlStateSelected)];
        [chooseBtn addTarget:self action:@selector(handleAgreeDeal:) forControlEvents:(UIControlEventTouchUpInside)];
        [agreementView addSubview:chooseBtn];
        chooseBtn.sd_layout.bottomSpaceToView(agreementView, 5).widthIs(kFit(15)).heightIs(kFit(15)).rightSpaceToView(AgreeDealBtn, kFit(0));
    }
}

- (void)handleAgreeDeal:(UIButton *)sender {
    NSLog(@"handleAgreeDeal%@", sender.selected?@"YES":@"NO");
    btnTag = sender.tag;
    agreement = !sender.selected;
    sender.selected = !sender.selected;
}
//创建个人信息模块
- (void)createPersonalInformation {
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    self.PersonalInformationView = bottomView;
    [self.wrapperView addSubview:bottomView];
    
    bottomView.sd_layout
    .leftSpaceToView(_wrapperView, 0)
    .topSpaceToView(_OpenShopAgreementView, kFit(10))
    .rightSpaceToView(_wrapperView, 0)
    .heightIs(kFit(241));
    {
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"个人信息填写";
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.font = MFont(kFit(15));
        [bottomView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(bottomView,kFit(12)).topSpaceToView(bottomView, kFit(11)).widthIs(kFit(200)).heightIs(kFit(15));
        
        self.personalNameInputView = [InputView new];
        _personalNameInputView.titleLabel.text = @"真实姓名:";
        _personalNameInputView.dataTF.placeholder = @"请输入真实姓名";
        _personalNameInputView.dataTF.delegate = self;
        [bottomView addSubview:_personalNameInputView];
        _personalNameInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(titleLabel, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
        
        self.personalPhoneInputView = [InputView new];
        _personalPhoneInputView.titleLabel.text = @"联系电话:";
        _personalPhoneInputView.dataTF.placeholder = @"您的联系方式";
        _personalPhoneInputView.dataTF.delegate = self;
        [bottomView addSubview:_personalPhoneInputView];
        _personalPhoneInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_personalNameInputView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
        
        self.personalIdCardInputView = [InputView new];
        _personalIdCardInputView.titleLabel.text = @"身份证号码:";
        _personalIdCardInputView.dataTF.placeholder = @"请输入您的身份证号";
        _personalIdCardInputView.dataTF.delegate = self;
        [bottomView addSubview:_personalIdCardInputView];
        _personalIdCardInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_personalPhoneInputView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
        
        UILabel *IdCardLabel = [UILabel new];
        IdCardLabel.text = @"上传身份证正反面";
        IdCardLabel.textColor = MColor(51, 51, 51);
        IdCardLabel.font = MFont(kFit(14));
        [bottomView addSubview:IdCardLabel];
        IdCardLabel.sd_layout.leftSpaceToView(bottomView, kFit(22)).topSpaceToView(_personalIdCardInputView, kFit(5)).widthIs(kFit(200)).heightIs(kFit(14));
        
        IdCardBtnOne = [UIButton new];
        IdCardBtnOne.backgroundColor = MColor(238, 238, 238);
        IdCardBtnOne.tag = 101;
        [IdCardBtnOne addTarget:self action:@selector(GetPhotoBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [IdCardBtnOne setImage:[UIImage imageNamed:@"wd-cwdj-tjzp"] forState:(UIControlStateNormal)];
        [bottomView addSubview:IdCardBtnOne];
        IdCardBtnOne.sd_layout.leftSpaceToView(bottomView, kFit(20)).topSpaceToView(IdCardLabel, kFit(11)).widthIs(kFit(160)).heightIs(kFit(100));
        
        IdCardBtnTwo = [UIButton new];
        IdCardBtnTwo.tag = 102;
        [IdCardBtnTwo addTarget:self action:@selector(GetPhotoBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        IdCardBtnTwo.backgroundColor = MColor(238, 238, 238);
        [IdCardBtnTwo setImage:[UIImage imageNamed:@"wd-cwdj-tjzp"] forState:(UIControlStateNormal)];
        [bottomView addSubview:IdCardBtnTwo];
        IdCardBtnTwo.sd_layout.rightSpaceToView(bottomView, kFit(20)).topSpaceToView(IdCardLabel, kFit(11)).widthIs(kFit(160)).heightIs(kFit(100));
    }
}
//创建司机信息模块
- (void)createStoreInformation {
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    self.StoreInformationView = bottomView;
    [self.wrapperView addSubview:bottomView];
    
    bottomView.sd_layout
    .leftSpaceToView(_wrapperView, 0)
    .topSpaceToView(_PersonalInformationView, kFit(10))
    .rightSpaceToView(_wrapperView, 0)
    .heightIs(kFit(405));
    {
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"店铺信息填写";
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.font = MFont(kFit(15));
        [bottomView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(bottomView,kFit(12)).topSpaceToView(bottomView, kFit(11)).widthIs(kFit(200)).heightIs(kFit(15));
        
        self.LicensePlateNumberInputView = [InputView new];
        _LicensePlateNumberInputView.titleLabel.text = @"车牌号:";
        _LicensePlateNumberInputView.dataTF.placeholder = @"请输入您的车牌";
        _LicensePlateNumberInputView.dataTF.delegate = self;
        [bottomView addSubview:_LicensePlateNumberInputView];
        _LicensePlateNumberInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(titleLabel, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
        
        self.CarTypeInputView = [InputView new];
        _CarTypeInputView.titleLabel.text = @"车辆类型:";
        _CarTypeInputView.dataTF.placeholder = @"您的车辆类型";
        _CarTypeInputView.dataTF.delegate = self;
        _CarTypeInputView.dataTF.userInteractionEnabled = NO;
        UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCarTypeTap:)];
        [_CarTypeInputView addGestureRecognizer:gesTap];
        [bottomView addSubview:_CarTypeInputView];
        _CarTypeInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_LicensePlateNumberInputView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
        
        self.CarBrandInputView = [InputView new];
        _CarBrandInputView.titleLabel.text = @"车辆品牌:";
        _CarBrandInputView.dataTF.placeholder = @"请输入您的车辆品牌";
        _CarBrandInputView.dataTF.delegate = self;
        [bottomView addSubview:_CarBrandInputView];
        _CarBrandInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_CarTypeInputView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
        
        self.CarBelongInputView = [InputView new];
        _CarBelongInputView.titleLabel.text = @"车辆所有人:";
        _CarBelongInputView.dataTF.placeholder = @"请输入车辆的所有人";
        _CarBelongInputView.dataTF.delegate = self;
        [bottomView addSubview:_CarBelongInputView];
        _CarBelongInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_CarBrandInputView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
        
        self.VehicleRegistrationTimeInputView = [InputView new];
        _VehicleRegistrationTimeInputView.titleLabel.text = @"车辆注册时间:";
        _VehicleRegistrationTimeInputView.dataTF.placeholder = @"请输入";
        _VehicleRegistrationTimeInputView.dataTF.delegate = self;
        [bottomView addSubview:_VehicleRegistrationTimeInputView];
        _VehicleRegistrationTimeInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_CarBelongInputView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
        
        UILabel *driverLicenseLabel = [UILabel new];
        driverLicenseLabel.text = @"上传个人驾驶证";
        driverLicenseLabel.textColor = MColor(51, 51, 51);
        driverLicenseLabel.font = MFont(kFit(14));
        [bottomView addSubview:driverLicenseLabel];
        driverLicenseLabel.sd_layout.leftSpaceToView(bottomView, kFit(22)).topSpaceToView(_VehicleRegistrationTimeInputView, kFit(5)).widthIs(kFit(200)).heightIs(kFit(14));
        
        driverLicenseBtnOne = [UIButton new];
        driverLicenseBtnOne.tag = 103;
        [driverLicenseBtnOne addTarget:self action:@selector(GetPhotoBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        driverLicenseBtnOne.backgroundColor = MColor(238, 238, 238);
        [driverLicenseBtnOne setImage:[UIImage imageNamed:@"wd-cwdj-tjzp"] forState:(UIControlStateNormal)];
        [bottomView addSubview:driverLicenseBtnOne];
        driverLicenseBtnOne.sd_layout.leftSpaceToView(bottomView, kFit(20)).topSpaceToView(driverLicenseLabel, kFit(5)).widthIs(kFit(160)).heightIs(kFit(100));
        
        driverLicenseBtnTwo = [UIButton new];
        driverLicenseBtnTwo.tag = 104;
        [driverLicenseBtnTwo addTarget:self action:@selector(GetPhotoBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        driverLicenseBtnTwo.backgroundColor = MColor(238, 238, 238);
        [driverLicenseBtnTwo setImage:[UIImage imageNamed:@"wd-cwdj-tjzp"] forState:(UIControlStateNormal)];
        [bottomView addSubview:driverLicenseBtnTwo];
        driverLicenseBtnTwo.sd_layout.rightSpaceToView(bottomView, kFit(20)).topSpaceToView(driverLicenseLabel, kFit(5)).widthIs(kFit(160)).heightIs(kFit(100));
        
        UILabel *drivingLicenseLabel = [UILabel new];
        drivingLicenseLabel.text = @"上传车辆行驶证";
        drivingLicenseLabel.textColor = MColor(51, 51, 51);
        drivingLicenseLabel.font = MFont(kFit(14));
        [bottomView addSubview:drivingLicenseLabel];
        drivingLicenseLabel.sd_layout.leftSpaceToView(bottomView, kFit(22)).topSpaceToView(driverLicenseBtnOne, kFit(5)).widthIs(kFit(200)).heightIs(kFit(14));
        
        drivingLicenseBtnOne = [UIButton new];
        drivingLicenseBtnOne.tag = 105;
        [drivingLicenseBtnOne addTarget:self action:@selector(GetPhotoBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        drivingLicenseBtnOne.backgroundColor = MColor(238, 238, 238);
        [drivingLicenseBtnOne setImage:[UIImage imageNamed:@"wd-cwdj-tjzp"] forState:(UIControlStateNormal)];
        [bottomView addSubview:drivingLicenseBtnOne];
        drivingLicenseBtnOne.sd_layout.leftSpaceToView(bottomView, kFit(20)).topSpaceToView(drivingLicenseLabel, kFit(5)).widthIs(kFit(160)).heightIs(kFit(100));
        
        drivingLicenseBtnTwo = [UIButton new];
        drivingLicenseBtnTwo.tag = 106;
        [drivingLicenseBtnTwo addTarget:self action:@selector(GetPhotoBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        drivingLicenseBtnTwo.backgroundColor = MColor(238, 238, 238);
        [drivingLicenseBtnTwo setImage:[UIImage imageNamed:@"wd-cwdj-tjzp"] forState:(UIControlStateNormal)];
        [bottomView addSubview:drivingLicenseBtnTwo];
        drivingLicenseBtnTwo.sd_layout.rightSpaceToView(bottomView, kFit(20)).topSpaceToView(drivingLicenseLabel, kFit(5)).widthIs(kFit(160)).heightIs(kFit(100));
    }
}
//获取车辆类型的方法
- (void)handleCarTypeTap:(UITapGestureRecognizer *)tap {

    NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/selectCarCost", kSHY_100];
    __block RegisteredAsDriverVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:URL_Str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadProgress%@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[NSString stringWithFormat:@"%@", responseObject[@"result"] ] isEqualToString:@"1"]) {
            VC.VehicleTypeArray = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            [VC ChooseCarClickEvent];
        }else {
            
            [VC showAlert:@"车辆信息获取失败,请重试"];
            
        }
        NSLog(@"responseObject%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"网络超时请重试"];
    }];



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

- (void)ChooseCarClickEvent{//
    
    //xia面是弹窗的初始化
    UIViewController *topVC = [self appRootViewController];
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.3f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
        tapGesture.numberOfTapsRequired=1;
        [self.backImageView addGestureRecognizer:tapGesture];
    }
    [topVC.view addSubview:self.backImageView];
    
    self.FPickerView = [[CarChooseView alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200))];
    _FPickerView.delegate = self;
    _FPickerView.DataArray = self.VehicleTypeArray;
    [topVC.view addSubview:_FPickerView];
    
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth-kFit(200), kScreen_widht, kFit(200));
    }];
    
}
-(void)hiddenView {
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
}
/**
 *确定
 */
- (void)ChooseCar:(NSDictionary *)carDic {
    
    self.chooseCarTypeDic = [NSMutableDictionary dictionaryWithDictionary:carDic];
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    self.chooseCarTypeDic = [NSMutableDictionary dictionaryWithDictionary:carDic];
    _CarTypeInputView.dataTF.text = carDic[@"carType"];
}
/**
 *取消
 */
- (void)deselect {
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return YES;
    }
    return YES;
}

- (void)GetPhotoBtn:(UIButton *)sender {
    btnTag = sender.tag;
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"选择照片" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *TakingPicturesCancle = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.picker = [[UIImagePickerController alloc]init];
            self.picker.delegate = self;
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:self.picker animated:YES];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"failed to camera"
                                  message:@""
                                  delegate:nil
                                  cancelButtonTitle:@"OK!"
                                  otherButtonTitles:nil];
            [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        }
        
    }];
    UIAlertAction *PhotoAlbumConfirm = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        DPImagePickerVC *vc = [[DPImagePickerVC alloc]init];
        vc.delegate = self;
        vc.isDouble = NO;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    // 3.将“取消”和“确定”按钮加入到弹框控制器中
    [alertV addAction:cancle];
    [alertV addAction:TakingPicturesCancle];
    [alertV addAction:PhotoAlbumConfirm];
    // 4.控制器 展示弹框控件，完成时不做操作
    [self presentViewController:alertV animated:YES completion:^{
        nil;
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *sourceImage = info[UIImagePickerControllerOriginalImage];
    
    switch (btnTag) {
            
            //   如何获取从相机拍摄到的照片并且存到字典
        case 101: {
            [IdCardBtnOne setImage:sourceImage forState:(UIControlStateNormal)];
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"isImage"]) {
                
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"isImage"];
                [self.picDictionary setObject:sourceImage forKey:@"isImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"isImage"];
            }
            
            break;
        }
        case 102:
        {
            [IdCardBtnTwo setImage:sourceImage forState:(UIControlStateNormal)];
            
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"theImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"theImage"];
                [self.picDictionary setObject:sourceImage forKey:@"theImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"theImage"];
            }
            break;
        }
        case 103:
        {
            [driverLicenseBtnOne setImage:sourceImage forState:(UIControlStateNormal)];
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }
        case 104:
        {
            [driverLicenseBtnTwo setImage:sourceImage forState:(UIControlStateNormal)];
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }
        case 105:
        {
            [drivingLicenseBtnOne setImage:sourceImage forState:(UIControlStateNormal)];
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }
        case 106:
        {
            [drivingLicenseBtnTwo setImage:sourceImage forState:(UIControlStateNormal)];
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }

        default:
            break;
    }
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark 绘制图片
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.picker dismissModalViewControllerAnimated:YES];
}

//用相册获取头像
- (void)getCutImage:(UIImage *)image{
    [self.navigationController popViewControllerAnimated:YES];
    UIImage *sourceImage = image;
    
    switch (btnTag) {
            
            //   如何获取从相机拍摄到的照片并且存到字典
        case 101: {
            [IdCardBtnOne setImage:sourceImage forState:(UIControlStateNormal)];
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"isImage"]) {
                
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"isImage"];
                [self.picDictionary setObject:sourceImage forKey:@"isImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"isImage"];
            }
            
            break;
        }
        case 102:
        {
            [IdCardBtnTwo setImage:sourceImage forState:(UIControlStateNormal)];
            
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"theImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"theImage"];
                [self.picDictionary setObject:sourceImage forKey:@"theImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"theImage"];
            }
            break;
        }
        case 103:
        {
            [driverLicenseBtnOne setImage:sourceImage forState:(UIControlStateNormal)];
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }
        case 104:
        {
            [driverLicenseBtnTwo setImage:sourceImage forState:(UIControlStateNormal)];
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }
        case 105:
        {
            [drivingLicenseBtnOne setImage:sourceImage forState:(UIControlStateNormal)];
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }
        case 106:
        {
            [drivingLicenseBtnTwo setImage:sourceImage forState:(UIControlStateNormal)];
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }
        default:
            break;
    }
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}
//提交注册资料
- (void)SubmitDriverRegistrationData {

    
    if (_personalNameInputView.dataTF.text.length == 0 || _personalPhoneInputView.dataTF.text.length == 0 || _personalIdCardInputView.dataTF.text.length == 0 || _LicensePlateNumberInputView.dataTF.text.length == 0||_CarTypeInputView.dataTF.text.length == 0 ||_CarBrandInputView.dataTF.text.length == 0 || _CarBelongInputView.dataTF.text.length == 0 || _VehicleRegistrationTimeInputView.dataTF.text.length == 0) {
        
        [self showAlert:@"资料不能为空"];
        
        return;
    }
    if (agreement == NO) {
        [self showAlert:@"请同意成为司机的协议"];
        
        return;
    }
    //司机注册
    NSString *UrL_Two = [NSString stringWithFormat:@"%@/carowner/api/saveCarowner", kSHY_100];
    
    //carownerapi/ save_carowner
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:20.0];
    
    //把版本号信息传导请求头中
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"iOS-%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"MM-Version"];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",nil];
    
    NSMutableDictionary *MDIC = [NSMutableDictionary dictionary];
    {
        MDIC[@"memberId"] = [UserDataSingleton mainSingleton].userID;
        MDIC[@"carOwnerName"] = _personalNameInputView.dataTF.text;//车主昵称
        MDIC[@"memberMobile"] = _personalPhoneInputView.dataTF.text;//车辆所有人
        MDIC[@"idCardNo"] = _personalIdCardInputView.dataTF.text;//身份证号
        MDIC[@"carLicenseNumber"] = _LicensePlateNumberInputView.dataTF.text;//联系电话
        MDIC[@"carId"] = self.chooseCarTypeDic[@"id"];
        MDIC[@"carVehicleBrand"] = _CarBrandInputView.dataTF.text;//车辆型号
        MDIC[@"registrationDate"] = _CarBelongInputView.dataTF.text;//注册时间
        MDIC[@"carMotorVehicles"] =_VehicleRegistrationTimeInputView.dataTF.text;//车辆所有人
    }
    __block RegisteredAsDriverVC *VC = self;
    [manager POST:UrL_Two parameters:MDIC constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSArray *imageArray = [self.picDictionary allKeys];
        for (int i = 0; i < imageArray.count; i ++) {
            //图片上传
            UIImage *images = self.picDictionary[imageArray[i]];
            
            NSData *picData = UIImageJPEGRepresentation(images, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSArray *nameArray = @[@"id_card_front", @"id_card_back", @"vehicle_registration_front", @"vehicle_registration_back", @"driving_license_front", @"driving_license_back"];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", nameArray[i]];
            [formData appendPartWithFileData:picData name:[NSString stringWithFormat:@"myfiles"]
                                    fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"获取注册返回数据responseObject%@", responseObject);
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"提交成功,工作人员会在七个工作日内联系您" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [VC.navigationController popViewControllerAnimated:YES];
            }];
            // 3.将“取消”和“确定”按钮加入到弹框控制器中
            [alertV addAction:cancle];
            // 4.控制器 展示弹框控件，完成时不做操作
            [self presentViewController:alertV animated:YES completion:^{
                nil;
            }];
        }else {
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:responseObject[@"msg"]  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [VC.navigationController popViewControllerAnimated:YES];
            }];
            // 3.将“取消”和“确定”按钮加入到弹框控制器中
            [alertV addAction:cancle];
            // 4.控制器 展示弹框控件，完成时不做操作
            [self presentViewController:alertV animated:YES completion:^{
                nil;
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误信息=====%@", error.description);
        [MBProgressHUD hideHUDForView:self.view animated:YES];

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
