//
//  BuyersOrderDetailsCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/2.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "BuyersOrderDetailsCell.h"

@interface BuyersOrderDetailsCell ()
/**
 *订单总价
 */
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
/**
 *运费
 */
@property (weak, nonatomic) IBOutlet UILabel *freightLabel;
/**
 *
 */
@property (weak, nonatomic) IBOutlet UILabel *invoiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *PayAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderCodingLabel;
@property (weak, nonatomic) IBOutlet UILabel *OrderTimeLanel;


@end

@implementation BuyersOrderDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(OrderDetailsModel *)model {
    self.totalPriceLabel.text = model.orderTotalPrice;
    self.freightLabel.text = model.shippingFee;
    self.PayAmountLabel.text = model.orderTotalPrice;
    self.invoiceLabel.text = @"";
    self.orderCodingLabel.text = model.orderSn;
    self.OrderTimeLanel.text = model.createTimeStr;
}
@end
