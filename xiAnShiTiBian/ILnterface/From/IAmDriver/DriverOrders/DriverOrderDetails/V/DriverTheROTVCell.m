//
//  DriverTheRunningOrderTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/23.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverTheROTVCell.h"

@implementation DriverTheROTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton *ConfirmDeliveryBtn = [UIButton new];
        [ConfirmDeliveryBtn setTitle:@"确认送达" forState:(UIControlStateNormal)];
        [ConfirmDeliveryBtn setTitleColor:MColor(249, 117, 29) forState:(UIControlStateNormal)];
        ConfirmDeliveryBtn.layer.cornerRadius = 3;
        ConfirmDeliveryBtn.layer.masksToBounds =YES;
        ConfirmDeliveryBtn.layer.borderWidth = 1;
        ConfirmDeliveryBtn.layer.borderColor = MColor(249, 117, 29).CGColor;
        ConfirmDeliveryBtn.titleLabel.font = MFont(kFit(14));
        [ConfirmDeliveryBtn addTarget:self action:@selector(handleConfirmDeliveryBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:ConfirmDeliveryBtn];
        ConfirmDeliveryBtn.sd_layout.rightSpaceToView(self.contentView, kFit(12)).centerYEqualToView (self.contentView).widthIs(kFit(63)).heightIs(kFit(27));
        
        UIButton *navigationBtn = [UIButton new];
        [navigationBtn setTitle:@"导航" forState:(UIControlStateNormal)];
        [navigationBtn setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
        navigationBtn.layer.cornerRadius = 3;
        navigationBtn.layer.masksToBounds =YES;
        navigationBtn.layer.borderWidth = 1;
        navigationBtn.layer.borderColor = kNavigation_Color.CGColor;
        navigationBtn.titleLabel.font = MFont(kFit(14));
        [navigationBtn addTarget:self action:@selector(handleNavigationBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:navigationBtn];
        navigationBtn.sd_layout.rightSpaceToView(ConfirmDeliveryBtn, kFit(12)).centerYEqualToView (self.contentView).widthIs(kFit(63)).heightIs(kFit(27));

    }
    return self;
}

- (void)handleConfirmDeliveryBtn:(OrderBtn *)sender {
    if ([_delegate respondsToSelector:@selector(ConfirmDelivery:)]) {
        [_delegate ConfirmDelivery:sender];
    }
}

- (void)handleNavigationBtn:(OrderBtn*)sender {
    
    if ([_delegate respondsToSelector:@selector(navigation:)]) {
        [_delegate navigation:sender];
    }
}

-(void)setModel:(DriverCarOrderModel *)model {
    


}
@end
