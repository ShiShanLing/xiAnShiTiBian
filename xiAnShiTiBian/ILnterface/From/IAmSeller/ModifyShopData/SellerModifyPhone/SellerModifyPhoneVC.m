//
//  SellerModifyPhoneVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/19.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerModifyPhoneVC.h"

@interface SellerModifyPhoneVC ()
@property (nonatomic, strong)UITextField *phoneTF;
@end

@implementation SellerModifyPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
      [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color,NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];
    self.navigationItem.title = @"更换店铺联系电话";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = MColor(238, 238, 238);
    
    UILabel *phoneLabel= [UILabel new];
    phoneLabel.text = @"请输入店铺新的联系电话";
    phoneLabel.textColor = MColor(51, 51, 51);
    phoneLabel.font = MFont(kFit(15));
    [self.view addSubview:phoneLabel];
    phoneLabel.sd_layout.leftSpaceToView(self.view, kFit(12)).topSpaceToView(self.view, kFit(15)+64).widthIs(kFit(200)).heightIs(kFit(15));
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    bottomView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(phoneLabel, kFit(15)).heightIs(kFit(47.5)).rightSpaceToView(self.view, 0);
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"手机号";
    titleLabel.textColor = MColor(51, 51, 51);
    titleLabel.font = MFont(kFit(14));
    [bottomView addSubview:titleLabel];
    titleLabel.sd_layout.leftSpaceToView(bottomView, kFit(12)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).widthIs(kFit(50));
    
    self.phoneTF = [UITextField new];
    _phoneTF.placeholder = @"新手机号";
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

- (void)handleTap {
    [self.phoneTF resignFirstResponder];
    
}

- (void)handleSubmitBtn {

    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"恭喜您!" message:@"更换成功" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"朕知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
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
    // Dispose of any resources that can be recreated.
}


@end
