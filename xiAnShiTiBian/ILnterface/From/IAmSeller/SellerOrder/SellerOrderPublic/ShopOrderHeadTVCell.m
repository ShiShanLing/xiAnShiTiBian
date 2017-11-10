

//
//  ShopOrderHeadTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShopOrderHeadTVCell.h"

@interface ShopOrderHeadTVCell ()
/**
 *订单编号
 */
@property (nonatomic, strong)UILabel *OrderCodeLabel;
/**
 *用户信息
 */
@property (nonatomic, strong)UILabel *userDataLabel;

@end

@implementation ShopOrderHeadTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.OrderCodeLabel = [UILabel new];
        _OrderCodeLabel.text = @"1234325436456";
        _OrderCodeLabel.font = MFont(kFit(12));
        _OrderCodeLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_OrderCodeLabel];
        _OrderCodeLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).centerYEqualToView(self.contentView).heightIs(kFit(12)).widthIs(kFit(kScreen_widht/2));
        
        self.userDataLabel = [UILabel new];
        _userDataLabel.text = @"你猜我是谁";
        _userDataLabel.textAlignment = 2;
        CGFloat width =  [self getWidthWithTitle:@"你猜我是谁" font:MFont(kFit(12))];
        _userDataLabel.textColor = MColor(51, 51, 51);
        _userDataLabel.font = MFont(kFit(12));
        [self.contentView addSubview:_userDataLabel];
        _userDataLabel.sd_layout.rightSpaceToView(self.contentView, kFit(12)).centerYEqualToView(self.contentView).widthIs(width).heightIs(kFit(12));
        
        UIButton *btn = [UIButton new];
        UIImage *userImage = [UIImage imageNamed:@"wd-wssj-dfh-mj"];
        userImage = [userImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [btn setImage:userImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:btn];
        btn.sd_layout.rightSpaceToView(_userDataLabel, kFit(5)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(45);
    }
    return self;
}


-(void)setModel:(SellerOrderListModel *)model {
    CGFloat width =  [self getWidthWithTitle:model.buyerName font:MFont(kFit(12))];
    _OrderCodeLabel.text = [NSString stringWithFormat:@"订单编号:%@", model.orderSn];
    _userDataLabel.text = model.buyerName;
    _userDataLabel.sd_layout.widthIs(width);
    
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
@end
