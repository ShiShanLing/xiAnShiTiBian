//
//  ChangeUserVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ChangeUserVC.h"

@interface ChangeUserVC ()
@property (nonatomic, strong)UITextField *phoneTF;


@end

@implementation ChangeUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改昵称";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = MColor(238, 238, 238);
    
    UILabel *phoneLabel= [UILabel new];
    phoneLabel.text = @"请输入新的用户名";
    phoneLabel.textColor = MColor(51, 51, 51);
    phoneLabel.font = MFont(kFit(15));
    [self.view addSubview:phoneLabel];
    phoneLabel.sd_layout.leftSpaceToView(self.view, kFit(12)).topSpaceToView(self.view, kFit(15)+64).widthIs(kFit(200)).heightIs(kFit(15));
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    bottomView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(phoneLabel, kFit(15)).heightIs(kFit(47.5)).rightSpaceToView(self.view, 0);
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"用户名";
    titleLabel.textColor = MColor(51, 51, 51);
    titleLabel.font = MFont(kFit(14));
    [bottomView addSubview:titleLabel];
    titleLabel.sd_layout.leftSpaceToView(bottomView, kFit(12)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).widthIs(kFit(50));
    
    self.phoneTF = [UITextField new];
    _phoneTF.placeholder = @"新的用户名";
    _phoneTF.font = MFont(kFit(14));
    [bottomView addSubview:_phoneTF];
    _phoneTF.sd_layout.leftSpaceToView(titleLabel, kFit(27.5)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).rightSpaceToView(bottomView, 0);
    
    UIButton *submitBtn = [UIButton new];
    submitBtn.backgroundColor = kNavigation_Color;
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
    [submitBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [submitBtn addTarget:self action:@selector(handleSubmitBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:submitBtn];
    submitBtn.sd_layout.widthIs(kScreen_widht-kFit(24)).heightIs(kFit(47.5)).topSpaceToView(bottomView, kFit(20)).centerXEqualToView(self.view);
    
    
}
- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)handleSubmitBtn {
    if (_phoneTF.text.length == 0) {
        [self showAlert:@"昵称不能为空" time:1.0];
        return;
    }
    [self performSelector:@selector(indeterminateExample)];
    [self.phoneTF resignFirstResponder];
    //司机注册
    NSString *UrL_Two = [NSString stringWithFormat:@"%@/memberapi/updateMember", kSHY_100];
    NSMutableDictionary *MDIC = [NSMutableDictionary dictionary];
    MDIC[@"memberId"] = self.userID;
    MDIC[@"nichen"] = _phoneTF.text;
    MDIC[@"birthday"] = @"";
    MDIC[@"sex"] = @"";
    MDIC[@"areaInfo"] = @"";

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block ChangeUserVC *VC = self;
    [session POST:UrL_Two parameters:MDIC progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultStr = [NSString stringWithFormat:@"%@",responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC AnalysisUserData:self.userID];
        }else {
        
            [VC showAlert:@"修改失败,请重试" time:1.0];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"请求失败请重试" time:1.0];
        [VC performSelector:@selector(delayMethod)];
    }];
}
//获取用户详情信息 用来存储到本地判断登录状态
- (void)AnalysisUserData:(NSString *)memberId{
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/memberapi/memberDetail",kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"memberId"] = memberId;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block ChangeUserVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        [VC AnalyticalDataDetails:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"请求失败请重试" time:1.0];
        [VC performSelector:@selector(delayMethod)];
    }];
}
//解析用户详情数据 并且存储到本地一份
- (void)AnalyticalDataDetails:(NSDictionary *)dic {
    
    NSString *state = [NSString stringWithFormat:@"%@", dic[@"result"]];
    if ([state isEqualToString:@"1"]) {
        NSDictionary *urseDataDic = dic[@"data"][0];

        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserLogInData" ofType:@"plist"];
        NSMutableDictionary *userData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        [userData  removeAllObjects];
        
        for (NSString *key in urseDataDic[@"member"]) {
            
            [userData setObject:urseDataDic[@"member"][key] forKey:key];
            
        }
        //获取应用程序沙盒的Documents目录
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        
        //得到完整的文件名
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"UserLogInData.plist"];
        //输入写入
        [userData writeToFile:filename atomically:YES];
        
        //那怎么证明我的数据写入了呢？读出来看看
        NSMutableDictionary *userData2 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
        NSLog(@"userData2%@", userData2);
        //添加一项内容
        [self showAlert:@"修改成功" time:1.0];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self showAlert:@"修改失败请重试" time:1.0];
    
    }
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)handleTap {
    [self.phoneTF resignFirstResponder];
    
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
