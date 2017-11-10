//
//  OriginalPhoneCodeVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "OriginalPhoneCodeVC.h"
#import "CodeView.h"
#import "SetUpViewController.h"
@interface OriginalPhoneCodeVC ()
/**
 *电话号码
 */
@property (nonatomic, strong)UILabel *phoneLabel;
@property (nonatomic, strong)CodeView *codeView;
@end

@implementation OriginalPhoneCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"获取验证码";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = MColor(238, 238, 238);
    UILabel *promptLabel = [UILabel new];
    promptLabel.textAlignment = 1;
    promptLabel.textColor = MColor(51, 51, 51);
    promptLabel.font = MFont(kFit(14));
    promptLabel.text = @"我们已经发送验证码到您的手机";
    [self.view addSubview:promptLabel];
    promptLabel.sd_layout.widthIs(kScreen_widht).heightIs(kFit(14)).topSpaceToView(self.view, kFit(15)+64).centerXEqualToView(self.view);
    
    
    self.phoneLabel = [UILabel new];
    _phoneLabel.textAlignment = 1;
    _phoneLabel.font = MFont(kFit(25));
    NSString *str = @"13673387452";
    NSString *tel = [str stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    _phoneLabel.text = tel;
    _phoneLabel.textColor = MColor(51, 51, 51);
    [self.view addSubview:_phoneLabel];
     _phoneLabel.sd_layout.widthIs(kScreen_widht).heightIs(kFit(25)).topSpaceToView(promptLabel, kFit(25)).centerXEqualToView(self.view);
    
    self.codeView = [CodeView new];
    [self.view addSubview:_codeView];
    _codeView.sd_layout.widthIs(kScreen_widht).heightIs(kFit(47.5)).topSpaceToView(_phoneLabel, kFit(15)).centerXEqualToView(self.view);
    
    UIButton *submitBtn = [UIButton new];
    submitBtn.backgroundColor = kNavigation_Color;
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
    [submitBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    [submitBtn addTarget:self action:@selector(handleSubmitBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:submitBtn];
    submitBtn.sd_layout.widthIs(kScreen_widht-kFit(24)).heightIs(kFit(47.5)).topSpaceToView(_codeView, kFit(20)).centerXEqualToView(self.view);
}

- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)handleSubmitBtn {
    
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[SetUpViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    }];
    
    // 3.将“取消”和“确定”按钮加入到弹框控制器中
    [alertV addAction:cancle];
    // 4.控制器 展示弹框控件，完成时不做操作
    [self presentViewController:alertV animated:YES completion:^{
        nil;
    }];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)handleTap {
    
    [self.codeView.CodeTF resignFirstResponder];
    
}


@end
