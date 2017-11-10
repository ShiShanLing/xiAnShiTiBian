
//
//  TaxViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/22.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "TaxViewController.h"

@interface TaxViewController ()
@property (nonatomic, strong)UIButton *chooseBtn1;
@property (nonatomic, strong)UIButton *chooseBtn2;

@end

@implementation TaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配送方式";
    NSArray *array;
    if (self.defaultState == 2) {
        array = @[@"", @"gxz"];
    }else {
        array = @[@"gxz", @""];
    }
    
    self.view.backgroundColor = MColor(238, 238, 238);
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = MColor(255, 255, 255);
    [self.view addSubview:bottomView];
    bottomView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, 64).rightSpaceToView(self.view, 0).heightIs(kFit(111));
    
    UILabel *taplabel = [UILabel new];
    taplabel.backgroundColor = MColor( 210, 210, 210);
    [bottomView addSubview:taplabel];
    taplabel.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(bottomView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(0.5));
    
    UILabel *middleLabel = [UILabel new];
    middleLabel.backgroundColor = MColor( 210, 210, 210);
    [bottomView addSubview:middleLabel];
    middleLabel.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(bottomView, kFit(kFit(55.5))).rightSpaceToView(bottomView, 0).heightIs(kFit(0.5));
    
    UILabel *bottomLabel = [UILabel new];
    bottomLabel.backgroundColor = MColor( 210, 210, 210);
    [bottomView addSubview:bottomLabel];
    bottomLabel.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(bottomView, kFit(110)).rightSpaceToView(bottomView, 0).heightIs(kFit(0.5)).bottomSpaceToView(bottomView, 0);
    
    self.chooseBtn1 = [UIButton new];
    [_chooseBtn1 setImage:[UIImage imageNamed:array[0]] forState:(UIControlStateNormal)];
    [_chooseBtn1 addTarget:self action:@selector(handleChooseBtn1) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:_chooseBtn1];
    _chooseBtn1.sd_layout.rightSpaceToView(bottomView,0).topSpaceToView(bottomView, 0).heightIs(kFit(55)).widthIs(kFit(42));
    
    
    
    self.chooseBtn2 = [UIButton new];
    [_chooseBtn2 setImage:[UIImage imageNamed:array[1]] forState:(UIControlStateNormal)];
    [_chooseBtn2 addTarget:self action:@selector(handleChooseBtn2) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:_chooseBtn2];
    _chooseBtn2.sd_layout.rightSpaceToView(bottomView,0).topSpaceToView(middleLabel, 0).heightIs(kFit(55)).widthIs(kFit(42));
    
    UILabel *titleLabel1 = [UILabel new];
    titleLabel1.textColor = MColor(51, 51, 51);
    titleLabel1.text = @"含税";
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChooseBtn1)];
    [titleLabel1 addGestureRecognizer:tap1];
    titleLabel1.userInteractionEnabled = YES;
    titleLabel1.font = MFont(kFit(15));
    [bottomView addSubview:titleLabel1];
    titleLabel1.sd_layout.leftSpaceToView(bottomView, kFit(12)).topSpaceToView(taplabel, 0).heightIs(kFit(55)).rightSpaceToView(_chooseBtn1, 0);
    
    UILabel *titleLabel2 = [UILabel new];
    titleLabel2.textColor = MColor(51, 51, 51);
    titleLabel2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChooseBtn2)];
    [titleLabel2 addGestureRecognizer:tap2];
    titleLabel2.text = @"不含税";
    titleLabel2.font = MFont(kFit(15));
    [bottomView addSubview:titleLabel2];
    titleLabel2.sd_layout.leftSpaceToView(bottomView, kFit(12)).topSpaceToView(middleLabel, 0).rightSpaceToView(_chooseBtn2, 0).bottomSpaceToView(bottomLabel, 0);
    
    
}

- (void)handleChooseBtn1{
    
    if (_TaxIndexBlock) {
        
        _TaxIndexBlock(1);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)handleChooseBtn2{
    
    if (_TaxIndexBlock) {
        
        _TaxIndexBlock(2);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
