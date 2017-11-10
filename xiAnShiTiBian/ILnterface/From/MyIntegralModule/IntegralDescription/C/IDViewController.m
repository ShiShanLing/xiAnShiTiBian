//
//  IDViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/15.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "IDViewController.h"

@interface IDViewController ()

@property (nonatomic, strong)NSString *explainStr;

@end

@implementation IDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.explainStr = @"身份证绑定,                        9.9折优惠 \n会员等级1(消费2000元),   9.8折优惠 \n会员等级2(消费两万元),    9.5折优惠 \n会员等级3(消费五万元),    9.2折优惠 \n会员等级4(消费十万元),    9.0折优惠\n会员等级5(消费五十万元), 8.8折优惠";
    
    [self  configurationNavigationBar];
    [self setView];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
   
}

- (void)configurationNavigationBar{
    self.view.backgroundColor = MColor(238,238,238);
    
    self.navigationController.navigationBar.barTintColor = kNavigation_whrColor;//导航条颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color, NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];//改变导航条标题的颜色与大小
    self.navigationItem.title = @"积分说明";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色

    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
}

//返回上一界面
- (void)handleReturn {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super.navigationController setNavigationBarHidden:NO];
    
}
- (void)setView {

    UIView *bottomViewOne = [UIView new];
    bottomViewOne.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bottomViewOne];
    bottomViewOne.sd_layout.leftSpaceToView(self.view , 0).topSpaceToView(self.view, 64).rightSpaceToView(self.view, 0).heightIs(kFit(400));
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.textColor = MColor(51, 51, 51);
    titleLabel.text = @"积分规则";
    titleLabel.font = [UIFont systemFontOfSize:kFit(17)];
    [bottomViewOne addSubview:titleLabel];
    titleLabel.sd_layout.leftSpaceToView(bottomViewOne, kFit(25)).topSpaceToView(bottomViewOne, kFit(37)).widthIs(200).heightIs(kFit(17));
    
    UILabel *rulesLabel = [UILabel new];
    rulesLabel.font = MFont(kFit(15));
    rulesLabel.textColor = MColor(51, 51, 51);
    rulesLabel.numberOfLines = 0;
    rulesLabel.text = @"100积分是一元钱! \n      可一用积分直接购买商品(购买时只能选择全积分购买或者不使用积分购买,也就是说积分和金钱不能同时使用)";
    
    [bottomViewOne addSubview:rulesLabel];
    rulesLabel.sd_layout.leftSpaceToView(bottomViewOne, kFit(25)).topSpaceToView(titleLabel, kFit(25)).rightSpaceToView(bottomViewOne, kFit(25)).heightIs(kFit(80));
    
    UILabel *preferentialLabel = [UILabel new];
    preferentialLabel.textColor = MColor(51, 51, 51);
    preferentialLabel.text = @"优惠比例";
    preferentialLabel.font = [UIFont systemFontOfSize:kFit(17)];
    [bottomViewOne addSubview:preferentialLabel];
    preferentialLabel.sd_layout.leftSpaceToView(bottomViewOne, kFit(25)).topSpaceToView(rulesLabel, kFit(37)).widthIs(200).heightIs(kFit(17));
    
    UILabel *explainLabel = [UILabel new];
    explainLabel.textColor = MColor(51, 51, 51);
    explainLabel.font = MFont(kFit(15));
    explainLabel.text = _explainStr;
    explainLabel.numberOfLines = 0;
    
    [bottomViewOne addSubview:explainLabel];
    explainLabel.sd_layout.leftSpaceToView(bottomViewOne, kFit(25)).topSpaceToView(preferentialLabel, kFit(25)).rightSpaceToView(bottomViewOne, kFit(25)).bottomSpaceToView(bottomViewOne, kFit(25));
    
    
}


@end
