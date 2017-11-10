//
//  ChangePWVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ChangePWVC.h"

@interface ChangePWVC ()
//原密码
@property (nonatomic, strong)UITextField *originalPassWord;
//新密码
@property (nonatomic, strong)UITextField *NewPassWord;

@end

@implementation ChangePWVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = MColor(238, 238, 238);
    self.navigationItem.title = @"更改密码";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    
    UIView *originalView = [UIView new];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:originalView];
    originalView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, kFit(10)+64).heightIs(kFit(47.5)).rightSpaceToView(self.view, 0);
    
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"原密码";
    titleLabel.textColor = MColor(51, 51, 51);
    titleLabel.font = MFont(kFit(14));
    [originalView addSubview:titleLabel];
    titleLabel.sd_layout.leftSpaceToView(originalView, kFit(12)).topSpaceToView(originalView, 0).bottomSpaceToView(originalView, 0).widthIs(kFit(50));
    
    
    self.originalPassWord = [UITextField new];
    _originalPassWord.placeholder = @"原密码";
    _originalPassWord.font = MFont(kFit(14));
    [originalView addSubview:_originalPassWord];
    _originalPassWord.sd_layout.leftSpaceToView(titleLabel, kFit(27.5)).topSpaceToView(originalView, 0).bottomSpaceToView(originalView, 0).rightSpaceToView(originalView, 0);

    
    UIView *NewView = [UIView new];
    NewView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:NewView];
    NewView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(originalView, kFit(10)).heightIs(kFit(47.5)).rightSpaceToView(self.view, 0);
    
    UILabel *newLabel = [UILabel new];
    newLabel.text = @"新密码";
    newLabel.textColor = MColor(51, 51, 51);
    newLabel.font = MFont(kFit(14));
    [NewView addSubview:newLabel];
    newLabel.sd_layout.leftSpaceToView(NewView, kFit(12)).topSpaceToView(NewView, 0).bottomSpaceToView(NewView, 0).widthIs(kFit(50));
    
    self.NewPassWord = [UITextField new];
    _NewPassWord.placeholder = @"新密码";
    _NewPassWord.font = MFont(kFit(14));
    [NewView addSubview:_NewPassWord];
    _NewPassWord.sd_layout.leftSpaceToView(newLabel, kFit(27.5)).topSpaceToView(NewView, 0).bottomSpaceToView(NewView, 0).rightSpaceToView(NewView, 0);

    UILabel *promptLabel = [UILabel new];
    promptLabel.text = @"密码由6-20位因为字母,数字或符号组成";
    promptLabel.textColor = MColor(134, 134, 134);
    promptLabel.font = MFont(kFit(14));
    [self.view addSubview:promptLabel];
    promptLabel.sd_layout.leftSpaceToView(self.view, kFit(12)).topSpaceToView(NewView, kFit(14)).widthIs(kScreen_widht - kFit(100)).heightIs(kFit(14));
    
    UIButton *ForgotPasswordBtn = [UIButton new];
    [ForgotPasswordBtn setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
    ForgotPasswordBtn.titleLabel.font = MFont(kFit(12));
    [ForgotPasswordBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
    [self.view addSubview:ForgotPasswordBtn];
    ForgotPasswordBtn.sd_layout.rightSpaceToView(self.view, 0).topSpaceToView(NewView, 0).heightIs(kFit(40)).widthIs(kFit(75));
    
    
    UIButton *submitBtn = [UIButton new];
    submitBtn.backgroundColor = kNavigation_Color;
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
    [submitBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
    [submitBtn addTarget:self action:@selector(handleSubmitBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:submitBtn];
    submitBtn.sd_layout.widthIs(kScreen_widht-kFit(24)).heightIs(kFit(47.5)).topSpaceToView(promptLabel, kFit(14)).centerXEqualToView(self.view);

}
- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)handleSubmitBtn {

    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"恭喜!" message:@"修改成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [alertV addAction:cancle];
    // 4.控制器 展示弹框控件，完成时不做操作
    [self presentViewController:alertV animated:YES completion:^{
        nil;
    }];

    
}
- (void)handleTap {
    
    [self.originalPassWord resignFirstResponder];
    [self.NewPassWord resignFirstResponder];
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
