//
//  IRTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/15.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "IRTVCell.h"
#import "IntegralListModel+CoreDataProperties.h"
@implementation IRTVCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.StoreImage = [UIImageView new];
        self.StoreImage.image = [UIImage imageNamed:@"zly"];
        _StoreImage.layer.cornerRadius = 6;
        _StoreImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_StoreImage];
        _StoreImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(25)).widthIs(kFit(53)).heightIs(kFit(53));
        
        
        self.IntegralNumber = [UILabel new];
        _IntegralNumber.text = @"+ 50000";
        _IntegralNumber.textAlignment = 2;
        _IntegralNumber.textColor = kNavigation_Color;
        _IntegralNumber.font =MFont(kFit(15));
        [self.contentView addSubview:_IntegralNumber];
        _IntegralNumber.sd_layout.rightSpaceToView(self.contentView, kFit(12)).widthIs(kFit(110)).topSpaceToView(self.contentView, kFit(32)).heightIs(kFit(15));
        
        self.instructionsLabel = [UILabel new];
        _instructionsLabel.textAlignment = 2;
        _instructionsLabel.text = @"交易成功";
        _instructionsLabel.textColor = MColor(134, 134, 134);
        _instructionsLabel.font = MFont(kFit(12));
        [self.contentView addSubview:_instructionsLabel];
        _instructionsLabel.sd_layout.rightSpaceToView(self.contentView, kFit(12)).widthIs(kFit(110)).topSpaceToView(_IntegralNumber, kFit(12)).heightIs(kFit(12));
        
        self.StoreName = [UILabel new];
        _StoreName.text = @"零软家具城";
        _StoreName.textColor = MColor(51, 51, 51);
        _StoreName.font = MFont(kFit(15));
        [self.contentView addSubview:_StoreName];
        _StoreName.sd_layout.leftSpaceToView(_StoreImage, kFit(15)).topSpaceToView(self.contentView, kFit(32)).rightSpaceToView(self.IntegralNumber, kFit(15)).heightIs(kFit(15));
         self.GoodsName = [UILabel new];
        
        _GoodsName.textColor = MColor(134, 134, 134);
        _GoodsName.font = MFont(kFit(14));
        [self.contentView addSubview:_GoodsName];
        _GoodsName.sd_layout.leftSpaceToView(self.StoreImage, kFit(15)).topSpaceToView(self.StoreName, kFit(10)).rightSpaceToView(self.instructionsLabel, kFit(15)).heightIs(kFit(14));
        
        UILabel *segmentationLabel = [UILabel new];
        segmentationLabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationLabel];
        segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, 0).heightIs(0.5);
    }
    return self;
}

- (void)IntegralType:(NSDictionary *)describe type:(int)type {
    _IntegralNumber.text = describe[@"IntegralNumber"];
    _instructionsLabel.text = describe[@"instructionsLabel"];
    switch (type) {
        case 0:
            _IntegralNumber.textColor = kNavigation_Color;
            break;
        case 1:
            _IntegralNumber.textColor = MColor(255, 51, 52);
            break;
        case 2:
            _StoreImage.image = [UIImage imageNamed:@"wd-jfjl-jftx"];
            _StoreName.text = @"积分提现";
            _GoodsName.text = @"金额:￥1000";
            _IntegralNumber.textColor = MColor(255, 51, 52);
            
            break;
            
        default:
            break;
    }
}

-(void)setModel:(IntegralListModel *)model {
    
    _IntegralNumber.textColor = MColor(255, 51, 52);
    _StoreImage.image = [UIImage imageNamed:@"wd-jfjl-jftx"];
    int state = model.operationType.intValue;
    switch (state) {
        case 1:
            _StoreName.text = @"购物送积分";
            _IntegralNumber.text = [NSString stringWithFormat:@"+%@", model.operationPoint];
            break;
        case 2:
            _StoreName.text = @"推荐用户送积分";
            _IntegralNumber.text = [NSString stringWithFormat:@"+%@", model.operationPoint];
            break;
        case 3:
            _StoreName.text = @"使用积分购买东西";
            _IntegralNumber.text = [NSString stringWithFormat:@"-%@", model.operationPoint];
            
            break;
        case 4:
            _StoreName.text = @"";
            
            break;
        case 5:
            _StoreName.text = @"积分提现";
            int money = model.operationPoint.intValue / 100;
            _GoodsName.text = [NSString stringWithFormat:@"提现金额:%d", money];
            
            _IntegralNumber.text = [NSString stringWithFormat:@"-%@", model.operationPoint];
            break;
        case 6:
            _StoreName.text = @"您推荐的人购买商品送积分";
            _IntegralNumber.text = [NSString stringWithFormat:@"+%@", model.operationPoint];
            break;
        case 7:
            _StoreName.text = @"提现完成";
            _IntegralNumber.text = [NSString stringWithFormat:@"-%@", model.operationPoint];
            break;
        default:
            break;
    }

    
    
    
    /**  `operation_id` varchar(32) NOT NULL COMMENT '操作记录ID',
     `member_id` varchar(32) DEFAULT NULL COMMENT '操作用户ID',
     `operation_point` int(11) DEFAULT NULL COMMENT '操作积分',
     `operation_type` int(11) DEFAULT NULL COMMENT '操作类型(1.支付宝支付 2.推荐用户 3.积分支付 4.积分收款 5.积分提现申请 6.被推荐用户消费一定额度送推荐人积分 7.积分提现完成)',
     `operation_timt` bigint(13) DEFAULT NULL COMMENT '操作时间',**/
    
}

@end
