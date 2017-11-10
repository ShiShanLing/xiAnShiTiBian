//
//  NewSAVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/17.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "NewSAVC.h"
#import "CitySelectionView.h"


/**
 *新增收货地址
 */
@interface NewSAVC ()<UITextViewDelegate, CitySelectionViewDelegate, TakeBackKBViewDelegate, SAAddMapSymbolVCDelegate>

//模仿京东键盘上方的回收按钮
@property (nonatomic, strong)TakeBackKBView *takeBackKBView;

@property (nonatomic, strong)UIScrollView *scrollView;
//收货人
@property (nonatomic, strong)UITextField *consigneeTF;
// ContactPhoneNumber 的缩写 电话
@property (nonatomic, strong)UITextField *CPNTF;
//Details about the address的缩写  详文字
@property (nonatomic, strong)UITextView *DAATV;
//所在地区 Shipping address 缩写
@property (nonatomic, strong)UILabel *SALabel;
/**
 *判断textView里面有没有文字 如果没有就显示提示文字,因为textview没有默认提示文字的属性 所以就用label代替了
 */
@property (nonatomic, strong)UILabel *promptLabel;
@property (nonatomic, strong)UIView *additionalView;//黑色透明背景
@property (nonatomic, strong)UIView *coverNavigationView;
@property (nonatomic, strong)UIView *underlyingView;

/**
 *是否吧收货地址设为默认 0 是不默认 1是默认     初始值是 0
 */
@property (nonatomic, strong)NSString *SetToDefaultStr;


/**
 *从地图界面获取的到的收货地址字典 @{@"name":123, @"latitude":123, @"longitude":123}];
 */
@property (nonatomic, strong)NSDictionary *ShippingAddressDIc;

@end

@implementation NewSAVC
#pragma mark --- 键盘回收---
- (void) registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyboardWasShown:(NSNotification *) notif{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    int height = kScreen_heigth - keyboardSize.height;
    int CHA = 270 - height ;
    CGSize size = CGSizeMake(kScreen_widht, kScreen_heigth- 64);
    size.height += CHA;
    self.scrollView.contentSize = size;
    
    CGRect frame =  self.takeBackKBView.frame;
    if ([EstimateHeightSingleton mainSingleton].keyboardHeight==0 ||[EstimateHeightSingleton mainSingleton].keyboardHeight==1) {
        
        [EstimateHeightSingleton mainSingleton].keyboardHeight ++;
        height -= kFit(73);
        frame.origin.y = height-kFit(50);
         NSLog(@"出现 键盘的高度%ld------空白视图高度%d", [EstimateHeightSingleton mainSingleton].keyboardHeight, height);
    }else {
        frame.origin.y = height-kFit(50);
    }
    [UIView animateWithDuration:0.0001 animations:^{
        self.takeBackKBView.frame = frame;
    }];
}

- (void) keyboardWasHidden:(NSNotification *) notif {
    
    [UIView animateWithDuration:0.001 animations:^{
        self.takeBackKBView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, 50);
    } completion:^(BOOL finished) {
    }];
}
#pragma mark TakeBackKBViewDelegate
- (void)CancelKeyboard {
    [self.consigneeTF resignFirstResponder];
    [self.CPNTF resignFirstResponder];
    [self.DAATV resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _SetToDefaultStr = @"0";
    //监听键盘的出现与回收
    [self registerForKeyboardNotifications];
    
    [self configurationNavigationBar];
    self.scrollView = [UIScrollView new];
    _scrollView.backgroundColor = MColor(238, 238, 238);
    
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    _scrollView.sd_layout.leftSpaceToView(self.view , 0).topSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
  
    //创建控件
    [self setView];
    UIButton *bottomBtn = [UIButton new];
    bottomBtn.backgroundColor = kNavigation_Color;
    [bottomBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    bottomBtn.titleLabel.textColor = MColor(255, 255, 255);
    bottomBtn.titleLabel.font = MFont(kFit(18));
    [bottomBtn addTarget:self action:@selector(handleBottomBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:bottomBtn];
    bottomBtn.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(kFit(55)).bottomSpaceToView(self.view, 0);
    self.takeBackKBView = [[TakeBackKBView alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(50))];
    self.takeBackKBView.delegate=self;
    [self.view addSubview:_takeBackKBView];

}



//设置导航条
- (void)configurationNavigationBar{
    self.view.backgroundColor = MColor(134,134,134);
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];//导航条颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];//改变导航条标题的颜色与大小
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];//去除导航条上图片的渲染色
    if ([_roleStr isEqualToString:@"1"]) {
    self.navigationItem.title = @"收货地址列表";
    }else {
    self.navigationItem.title = @"发货地址列表";
    }
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
}
//返回上一界面
- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
}
//创建界面控件
- (void)setView {

    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:bottomView];
    bottomView.sd_layout.leftSpaceToView(_scrollView, 0).topSpaceToView(_scrollView, 0).rightSpaceToView(_scrollView, 0).heightIs(kFit(255));
    
    UILabel *partitionLabelOne = [UILabel new];//第一道分割线
    partitionLabelOne.backgroundColor = MColor(210, 210, 210);
    [bottomView addSubview:partitionLabelOne];
    partitionLabelOne.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(bottomView, 0).rightSpaceToView(bottomView, 0).heightIs(1);
    
    UILabel *consigneeLabel = [UILabel new];
    
    if ([_roleStr isEqualToString:@"1"]) {
        consigneeLabel.text = @"收货人";
    }else {
        consigneeLabel.text = @"发货人";
    }

    consigneeLabel.textColor = MColor(51, 51, 51);
    consigneeLabel.font = MFont(kFit(15));
    [bottomView addSubview:consigneeLabel];
    consigneeLabel.sd_layout.leftSpaceToView(bottomView, kFit(12)).topSpaceToView(partitionLabelOne, 0).widthIs(kFit(100)).heightIs(kFit(55));
    
    self.consigneeTF = [UITextField new];
    _consigneeTF.borderStyle = UITextBorderStyleNone;
    _consigneeTF.font = MFont(kFit(15));
    
    if ([_roleStr isEqualToString:@"1"]) {
        _consigneeTF.placeholder = @"收货人姓名";
    }else {
        _consigneeTF.placeholder = @"发货人姓名";
    }
    [bottomView addSubview:_consigneeTF];
    _consigneeTF.sd_layout.leftSpaceToView(consigneeLabel, kFit(0)).topSpaceToView(partitionLabelOne, 0).rightSpaceToView(bottomView, kFit(12)).heightIs(kFit(55));
    
    UILabel *partitionLabelTwo = [UILabel new];//第二道分割线
    partitionLabelTwo.backgroundColor = MColor(238, 238, 238);
    [bottomView addSubview:partitionLabelTwo];
    partitionLabelTwo.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_consigneeTF, 0).rightSpaceToView(bottomView, 0).heightIs(0.5);
    
    
    UILabel *CPNTFLabel = [UILabel new];
    CPNTFLabel.text = @"联系电话";
    CPNTFLabel.textColor = MColor(51, 51, 51);
    CPNTFLabel.font = MFont(kFit(15));
    [bottomView addSubview:CPNTFLabel];
    CPNTFLabel.sd_layout.leftSpaceToView(bottomView, kFit(12)).topSpaceToView(partitionLabelTwo, 0).widthIs(kFit(100)).heightIs(kFit(55));

    self.CPNTF = [UITextField new];
    _CPNTF.font = MFont(kFit(15));
    _CPNTF.borderStyle = UITextBorderStyleNone;
    _CPNTF.keyboardType = UIKeyboardTypeNamePhonePad;
    _CPNTF.placeholder = @"方便联系到您!";
    
    [bottomView addSubview:_CPNTF];
     _CPNTF.sd_layout.leftSpaceToView(CPNTFLabel, kFit(0)).topSpaceToView(partitionLabelTwo, 0).rightSpaceToView(bottomView, kFit(12)).heightIs(kFit(55));
    
    UILabel *partitionLabelThree = [UILabel new];//第三道分割线
    partitionLabelThree.backgroundColor = MColor(238, 238, 238);
    [bottomView addSubview:partitionLabelThree];
     partitionLabelThree.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_CPNTF, 0).rightSpaceToView(bottomView, 0).heightIs(0.5);
    
    
    UILabel *SALabel   = [UILabel new];
    SALabel.text  = @"所在地址";
    SALabel.userInteractionEnabled = YES;
    SALabel.textColor =MColor(51, 51, 51);
    SALabel.font  = MFont(kFit(15));
    [bottomView addSubview:SALabel];
    SALabel.sd_layout.leftSpaceToView(bottomView, kFit(12)).topSpaceToView(partitionLabelThree, 0).widthIs(kFit(100)).heightIs(kFit(55));
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSelectShippingAddress)];
    [SALabel addGestureRecognizer:tap1];
    
    UIButton *arrowBtn   = [UIButton new];
    [arrowBtn setImage:[UIImage imageNamed:@"xzz"] forState:(UIControlStateNormal)];
    [arrowBtn addTarget:self action:@selector(handleSelectShippingAddress) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:arrowBtn];
    arrowBtn.sd_layout.rightSpaceToView(bottomView, kFit(0)).topSpaceToView(partitionLabelThree, 0).heightIs(kFit(55)).widthIs(36);
    self.SALabel = [UILabel new];
    _SALabel.text= @"";
    _SALabel.font = MFont(kFit(15));
    _SALabel.userInteractionEnabled = YES;
    _SALabel.textAlignment =2;
    _SALabel.textColor = MColor(134, 134, 134);
    [bottomView addSubview:_SALabel];
    _SALabel.sd_layout.rightSpaceToView(arrowBtn, kFit(0)).topSpaceToView(partitionLabelThree, kFit(0)).heightIs(kFit(55)).leftSpaceToView(SALabel, kFit(12));
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSelectShippingAddress)];
    [_SALabel addGestureRecognizer:tap2];
    
    UILabel *partitionLabelFour = [UILabel new];//第四道分割线
    partitionLabelFour.backgroundColor = MColor(238, 238, 238);
    [bottomView addSubview:partitionLabelFour];
    partitionLabelFour.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(arrowBtn, 0).rightSpaceToView(bottomView, 0).heightIs(0.5);
    
    self.DAATV = [UITextView new];
    self.DAATV.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    self.DAATV.delegate = self;//设置它的委托方法
    self.DAATV.returnKeyType = UIReturnKeyDone;
     self.DAATV.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    self.DAATV.font = [UIFont systemFontOfSize:kFit(15)];
    
     self.DAATV.scrollEnabled = YES;//是否可以拖动
     self.DAATV.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度

     [bottomView addSubview:_DAATV];
    _DAATV.sd_layout.leftSpaceToView(bottomView, kFit(12)).topSpaceToView(partitionLabelFour, kFit(12)).rightSpaceToView(bottomView, kFit(12)).bottomSpaceToView(bottomView, kFit(12));
    
    self.promptLabel = [UILabel new];
    if ([_roleStr isEqualToString:@"1"]) {
        _promptLabel.text = @"请输入详情收货地址";
    }else {
        _promptLabel.text = @"请输入详情发货地址";;
    }
    _promptLabel.font = [UIFont systemFontOfSize:kFit(15)];
    _promptLabel.textColor = [UIColor lightGrayColor];
    _promptLabel.userInteractionEnabled = NO;
    [bottomView addSubview:_promptLabel];
    _promptLabel.sd_layout.leftSpaceToView(bottomView, kFit(12)).topSpaceToView(partitionLabelFour, kFit(20)).rightSpaceToView(bottomView, kFit(12)).heightIs(kFit(15));
    
    //设为默认的view
    UIView *SetDefaultView = [UIView new];
    SetDefaultView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:SetDefaultView];
    SetDefaultView.sd_layout.leftSpaceToView(_scrollView, 0).topSpaceToView(bottomView, kFit(10)).rightSpaceToView(_scrollView, 0).heightIs(kFit(55));
    
    UILabel *defaultStateLabel = [UILabel new];
    defaultStateLabel.text = @"设为默认";
    defaultStateLabel.font = [UIFont systemFontOfSize:kFit(15)];
    defaultStateLabel.textColor = MColor(51, 51, 51);
    [SetDefaultView addSubview:defaultStateLabel];
    defaultStateLabel.sd_layout.leftSpaceToView(SetDefaultView, kFit(12)).topSpaceToView(SetDefaultView, 0).bottomSpaceToView(SetDefaultView, 0).widthIs(kFit(100));
    
    UISwitch *chooseSwitch  = [UISwitch new];
    BOOL setting =  chooseSwitch.isOn;
    [chooseSwitch setOn:setting animated:YES];
    chooseSwitch.onTintColor = kNavigation_Color;
    chooseSwitch.tintColor = MColor(210, 210, 210);
    [chooseSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [SetDefaultView addSubview:chooseSwitch];
    chooseSwitch.sd_layout.rightSpaceToView(SetDefaultView, kFit(15)).centerYEqualToView(SetDefaultView).widthIs(kFit(40)).heightIs(kFit(20));
    if ([self.roleStr isEqualToString:@"1"]) {
        _consigneeTF.text = _model.trueName;
        _CPNTF.text = _model.mobPhone;
        _SALabel.text = _model.areaInfo;
        _DAATV.text = _model.address;
        _promptLabel.text=@"";
    }
    if ([self.roleStr isEqualToString:@"2"]) {
        _consigneeTF.text = _SellerModel.sellerName;
        _CPNTF.text = _SellerModel.mobPhone;
        _SALabel.text = _SellerModel.areaInfo;
        _DAATV.text = _SellerModel.address;
        _promptLabel.text=@"";
    }
}
//确定点击事件  -------- 请看这里 请求的接口在这里
- (void)handleBottomBtn {
    if ([self.roleStr isEqualToString:@"2"]) { //如果是商家添加发货地址
        if (_consigneeTF.text == nil || _CPNTF.text == nil || _SALabel.text == nil || _DAATV.text == nil) {
            [self showAlert:@"选项不能为空"];
        }else if(![RegularExpressions isMobileNumber:_CPNTF.text]){
            [self showAlert:@"手机号格式有误"];
        }else {
            NSString *url_str = [NSString stringWithFormat:@"%@/daddress/api/updateDaddress", kSHY_100];
            NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
            URL_DIC[@"storeId"]=[UserDataSingleton mainSingleton].storeID;
            URL_DIC[@"sellerName"]=_consigneeTF.text;
            URL_DIC[@"mobilePhone"]=_CPNTF.text;
            URL_DIC[@"areaInfo"]=_SALabel.text;
            URL_DIC[@"address"] =_DAATV.text;
            URL_DIC[@"zipCode"] = @"1111111";
            URL_DIC[@"telPhone"] = @"";
            URL_DIC[@"company"] = @"";
            URL_DIC[@"content"] = @"";
            URL_DIC[@"isDefault"] = _SetToDefaultStr;
            if (_ShippingAddressDIc == nil) {
                if (_model == nil) {
                    [self showAlert:@"请选择收货地址"];
                }else {
                    URL_DIC[@"longitude"]=_model.longitude;
                    URL_DIC[@"latitude"]=_model.latitude;
                }
            }else {
                URL_DIC[@"longitude"]=_ShippingAddressDIc[@"longitude"];
                URL_DIC[@"latitude"]=_ShippingAddressDIc[@"latitude"];
            }
            URL_DIC[@"isDefault"]=@"1";//是否是默认
            if (self.AddressState == 2) {
                URL_DIC[@"addressId"]=self.SellerModel.addressId;
            }
            NSLog(@"handleBottomBtn %@", URL_DIC);
            AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
            [session POST:url_str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"uploadProgress%@", uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
                if ([resultStr isEqualToString:@"1"]) {
                    NSString *msg;
                    if (self.AddressState == 1) {
                        msg = @"添加成功";
                    }else {
                        msg = @"修改成功";
                    }
                    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"恭喜!" message:msg preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }];
                    // 3.将“取消”和“确定”按钮加入到弹框控制器中
                    [alertV addAction:cancle];
                    // 4.控制器 展示弹框控件，完成时不做操作
                    [self presentViewController:alertV animated:YES completion:^{
                        nil;
                    }];
                    
                }else {
                    
                    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"抱歉!" message:responseObject[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                        
                        
                    }];
                    // 3.将“取消”和“确定”按钮加入到弹框控制器中
                    [alertV addAction:cancle];
                    // 4.控制器 展示弹框控件，完成时不做操作
                    [self presentViewController:alertV animated:YES completion:^{
                        nil;
                    }];
                    
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error%@", error);
            }];
            
                }
    }else {//否者就是买家添加收货地址
        if (_consigneeTF.text == nil || _CPNTF.text == nil || _SALabel.text == nil || _DAATV.text == nil) {
            [self showAlert:@"选项不能为空"];
        }else if(![RegularExpressions isMobileNumber:_CPNTF.text]){
            [self showAlert:@"手机号格式有误"];
        }else {
            
            NSString *url_str = [NSString stringWithFormat:@"%@/address/api/saveAddress", kSHY_100];
            NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
            URL_DIC[@"memberId"]=[UserDataSingleton mainSingleton].userID;
            URL_DIC[@"trueName"]=_consigneeTF.text;
            URL_DIC[@"mobPhone"]=_CPNTF.text;
            URL_DIC[@"areaInfo"]=_SALabel.text;
            URL_DIC[@"address"] =_DAATV.text;
            if (_ShippingAddressDIc == nil) {
                if (_model == nil) {
                    [self showAlert:@"请选择收货地址"];
                }else {
                    URL_DIC[@"longitude"]=_model.longitude;
                    URL_DIC[@"latitude"]=_model.latitude;
                }
            }else {
                URL_DIC[@"longitude"]=_ShippingAddressDIc[@"longitude"];
                URL_DIC[@"latitude"]=_ShippingAddressDIc[@"latitude"];
            }
            URL_DIC[@"isDefault"]=_SetToDefaultStr;//是否是默认
            if (self.AddressState == 2) {
                URL_DIC[@"addressId"]=self.model.addressId;
            }
            NSLog(@"handleBottomBtn %@", URL_DIC);
            AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
            [session POST:url_str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"uploadProgress%@", uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"responseObject %@", responseObject);
                NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
                if ([resultStr isEqualToString:@"1"]) {
                    NSString *msg;
                    if (self.AddressState == 1) {
                        msg = @"添加成功";
                    }else {
                        msg = @"修改成功";
                    }
                    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"恭喜!" message:msg preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }];
                    // 3.将“取消”和“确定”按钮加入到弹框控制器中
                    [alertV addAction:cancle];
                    // 4.控制器 展示弹框控件，完成时不做操作
                    [self presentViewController:alertV animated:YES completion:^{
                        nil;
                    }];
                }else {
                    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"抱歉!" message:responseObject[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                        
                        
                    }];
                    // 3.将“取消”和“确定”按钮加入到弹框控制器中
                    [alertV addAction:cancle];
                    // 4.控制器 展示弹框控件，完成时不做操作
                    [self presentViewController:alertV animated:YES completion:^{
                        nil;
                    }];

                
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error%@", error);
            }];
        
    }
    
    }
}
#pragma mark SAAddMapSymbolVCDelegate 地图界面返回的数据
-(void)ShippingAddress:(NSDictionary *)addressDic {
    self.ShippingAddressDIc = [NSDictionary dictionaryWithDictionary:addressDic];
    _SALabel.text = addressDic[@"name"];
}
//点击弹出城市选择器 创建城市选择器
- (void)handleSelectShippingAddress{
    [self.consigneeTF resignFirstResponder];
    [self.CPNTF resignFirstResponder];
    [self.DAATV resignFirstResponder];
    SAAddMapSymbolVC *VC = [[SAAddMapSymbolVC alloc] init];
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];

    
}

//设置是否设为默认地址
- (void)switchAction:(UISwitch *)sw {
    NSLog(@"%@", sw.on ? @"YES":@"NO");
    
    if (sw.on) {
       self.SetToDefaultStr = @"1";
    }else {
    self.SetToDefaultStr = @"0";
      }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
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
        
        if ([_roleStr isEqualToString:@"1"]) {
            _promptLabel.text=@"请输入详情收货地址";
        }else {
            _promptLabel.text=@"请输入详情发货地址";
        }
    }

}
//内容有变化
- (void)textViewDidChange:(UITextView *)textView {

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

- (void)setModel:(ShippingAddressModel *)model {
    _model = model;
    _consigneeTF.text = model.trueName;
    _CPNTF.text = model.mobPhone;
    _SALabel.text = model.areaInfo;
    _DAATV.text = model.address;
}

- (void)setSellerModel:(SellerShipAddressModel *)SellerModel {
    _SellerModel = SellerModel;
    
    NSLog(@"setSellerModel%@", SellerModel);
    _consigneeTF.text = SellerModel.sellerName;
    
    _CPNTF.text = SellerModel.mobPhone;
    _SALabel.text = SellerModel.areaInfo;
    _DAATV.text = SellerModel.address;


}
@end
