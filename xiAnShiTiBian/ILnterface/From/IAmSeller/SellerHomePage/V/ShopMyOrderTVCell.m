//
//  ShopMyOrderTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShopMyOrderTVCell.h"
#import "ToolFunctionView.h"
#import "IconView.h"
#define kWidth 50



@interface ShopMyOrderTVCell ()<IconViewDelegate>


@end

@implementation ShopMyOrderTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
      
        UILabel *titleLabel =[UILabel new];
        titleLabel.text = @"我的订单";
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.font = MFont(kFit(15));
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(16)).widthIs(kFit(100)).heightIs(kFit(15));
        
        UILabel *dividerLabel = [UILabel new];
        dividerLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:dividerLabel];
        dividerLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(titleLabel, kFit(16)).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
        
        IconView *WaitingCallcarV = [IconView new];
        WaitingCallcarV.tag = 202;
        WaitingCallcarV.iconImage.image = [UIImage imageNamed:@"wd-wssj-djc"];
        WaitingCallcarV.nameLabel.text = @"待叫车";
        WaitingCallcarV.delegate = self;
        [self.contentView addSubview:WaitingCallcarV];
        WaitingCallcarV.sd_layout.topSpaceToView(dividerLabel, kFit(5)).centerXEqualToView(dividerLabel).widthIs(kFit(kWidth)).heightIs(kFit(kWidth));
        
        IconView *WaitingPaymentV = [IconView new];
        WaitingPaymentV.tag = 201;
        WaitingPaymentV.iconImage.image = [UIImage imageNamed:@"dfk"];
        WaitingPaymentV.nameLabel.text = @"待付款";
        WaitingPaymentV.delegate = self;
        [self.contentView addSubview:WaitingPaymentV];
        WaitingPaymentV.sd_layout.topSpaceToView(dividerLabel, kFit(5)).rightSpaceToView(WaitingCallcarV, kFit(15)).widthIs(kFit(kWidth)).heightIs(kFit(kWidth));
        
        IconView *WaitDeliveryV = [IconView new];
        WaitDeliveryV.tag = 203;
        WaitDeliveryV.iconImage.image = [UIImage imageNamed:@"dfh"];
        WaitDeliveryV.nameLabel.text = @"待发货";
        WaitDeliveryV.delegate = self;
        [self.contentView addSubview:WaitDeliveryV];
        WaitDeliveryV.sd_layout.topSpaceToView(dividerLabel, kFit(5)).leftSpaceToView(WaitingCallcarV, kFit(15)).widthIs(kFit(kWidth)).heightIs(kFit(kWidth));
        
        IconView *WaitingGoodsV = [IconView new];
        WaitingGoodsV.tag = 204;
        WaitingGoodsV.iconImage.image = [UIImage imageNamed:@"dsh"];
        WaitingGoodsV.nameLabel.text = @"待收货";
        WaitingGoodsV.delegate = self;
        [self.contentView addSubview:WaitingGoodsV];
        WaitingGoodsV.sd_layout.topEqualToView(WaitDeliveryV).leftSpaceToView(WaitDeliveryV, kFit(15)).widthIs(kFit(kWidth)).heightIs(kFit(kWidth));
        
        IconView *WaitSureV = [IconView new];
        WaitSureV.tag = 200;
        WaitSureV.iconImage.image = [UIImage imageNamed:@"wd-wssj-yfqr"];
        WaitSureV.nameLabel.text = @"待定运费";
        WaitSureV.delegate = self;
        [self.contentView addSubview:WaitSureV];
        WaitSureV.sd_layout.topEqualToView(WaitDeliveryV).rightSpaceToView(WaitingPaymentV, kFit(15)).widthIs(kFit(kWidth)).heightIs(kFit(kWidth));
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(10));
        }
    return self;
}
- (void)FunctionChoose:(ToolFunctionView *)view {
    NSLog(@"你点击的tag值是%ld", view.tag);
    if ([_delegate respondsToSelector:@selector(SelectOrderStatus:)]) {
        [_delegate SelectOrderStatus:(int)view.tag];
    }
}
@end
