//
//  UnfoldOrderTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "UnfoldOrderTVCell.h"

@interface UnfoldOrderTVCell ()

//显示订单是否展开或者关闭的label 和btn
@property (nonatomic , strong)UIButton *OrderStateBtn;

@property (nonatomic , strong)UILabel  *OrderStateLabel;

@end

@implementation UnfoldOrderTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = MColor(250, 250, 250);
        self.OrderStateBtn = [UIButton new];
        UIImage *imageOne = [UIImage imageNamed:@"wd-wssj-wldd-xjt"];
        imageOne = [imageOne imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_OrderStateBtn setImage:imageOne forState:(UIControlStateNormal)];
        [self.contentView addSubview:_OrderStateBtn];
        _OrderStateBtn.sd_layout.rightSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(33));
        
        self.OrderStateLabel = [UILabel new];
        _OrderStateLabel.text = @"查看详情";
        _OrderStateLabel.textAlignment = 2;
        _OrderStateLabel.textColor = MColor(134, 134, 134);
        _OrderStateLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_OrderStateLabel];
        _OrderStateLabel.sd_layout.rightSpaceToView(_OrderStateBtn, kFit(0)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(60));
        
        self.stateBtn = [UIButton new];
        UIImage *imageThree = [UIImage imageNamed:@"wd-wssj-ckwldd-yqx"];
        imageThree = [imageThree imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_stateBtn setImage:imageThree forState:(UIControlStateNormal)];
        [self.contentView addSubview:_stateBtn];
        _stateBtn.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(50);
        
        self.stateLabel = [UILabel new];
        _stateLabel.text = @"已取消";
        _stateLabel.textColor = MColor(134, 134, 134);
        _stateLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_stateLabel];
        _stateLabel.sd_layout.leftSpaceToView(_stateBtn, kFit(0)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(100));
    }
    return self;
}
- (void)ChangeState:(int)state {
    if (state == 2) {
        UIImage *imageOne = [UIImage imageNamed:@"wd-wssj-wldd-xjt"];
        imageOne = [imageOne imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_OrderStateBtn setImage:imageOne forState:(UIControlStateNormal)];
    }
    if (state ==11) {
        UIImage *imageTwo = [UIImage imageNamed:@"wd-wssj-wldd-sjt"];
        imageTwo = [imageTwo imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_OrderStateBtn setImage:imageTwo forState:(UIControlStateNormal)];
    }


}
@end
