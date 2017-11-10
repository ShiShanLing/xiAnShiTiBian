//
//  PayWayTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/4.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "PayWayTVCell.h"

@interface PayWayTVCell ()
/**
 *显示支付方式的图片
 */
@property (nonatomic, strong)UIButton *payWayBtn;
/**
 *支付方式的文字显示
 */
@property (nonatomic, strong)UILabel *payWayLabel;
/**
 *支付方式选择状态
 */
@property (nonatomic, strong)UIButton *selectedBtn;
@end

@implementation PayWayTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.payWayBtn = [UIButton new];
        [_payWayBtn setImage: [UIImage imageNamed:@"jf"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:_payWayBtn];
        _payWayBtn.sd_layout.leftSpaceToView(self.contentView, kFit(12)).centerYEqualToView(self.contentView).widthIs(kFit(30)).heightIs(kFit(55));

        self.payWayLabel = [UILabel new];
        _payWayLabel.text = @"积分支付";
        _payWayLabel.textColor = MColor(51, 51, 51);
        _payWayLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_payWayLabel];
        _payWayLabel.sd_layout.leftSpaceToView(_payWayBtn, kFit(15)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(100));
        self.selectedBtn = [UIButton new];
        [self.contentView addSubview:_selectedBtn];
         _selectedBtn.sd_layout.rightSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(18));
        UILabel *label = [UILabel new];
        label.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:label];
        label.sd_layout.leftSpaceToView(self.contentView, kFit(12)).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(12)).heightIs(0.5);
    }
    return self;
}

-(void)ChoosePayWay:(BOOL)state {
    if (!state) {
         [_selectedBtn setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    }else {
         [_selectedBtn setImage:[UIImage imageNamed:@"gxz"] forState:(UIControlStateNormal)];
    }
}

- (void)ControlsAssignment:(int)index {
//    _payWayLabel.text = @"支付宝支付";
//    [_payWayBtn setImage: [UIImage imageNamed:@"zfb"] forState:(UIControlStateNormal)];
    switch (index) {
//        case 2:
//        _payWayLabel.text = @"积分支付";
//        [_payWayBtn setImage: [UIImage imageNamed:@"jf"] forState:(UIControlStateNormal)];
//            break;
        case 2:
            //zfb
            _payWayLabel.text = @"支付宝支付";
            [_payWayBtn setImage: [UIImage imageNamed:@"zfb"] forState:(UIControlStateNormal)];
            break;
        case 3:
        _payWayLabel.text = @"微信支付";
        [_payWayBtn setImage: [UIImage imageNamed:@"wxzf"] forState:(UIControlStateNormal)];
            break;
            
        default:
            break;
    }


}

@end
