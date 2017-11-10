//
//  MyIntegralTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/26.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "MyIntegralTVCell.h"

@interface MyIntegralTVCell()
//购买的商品图片
@property (nonatomic, strong)UIImageView *GoodsImage;
//购买的商品名称
@property (nonatomic, strong)UILabel *GoodsName;
//发票抬头
@property (nonatomic, strong)UILabel *invoiceLookedUp;
//发票内容
@property (nonatomic, strong)UILabel *invoiceContent;
//发票金额
@property (nonatomic, strong)UILabel *invoiceMoney;
//发票时间
@property (nonatomic, strong)UILabel *invoiceTime;
//发票类型
@property (nonatomic, strong)UILabel *invoiceType;

@end

@implementation MyIntegralTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.GoodsImage = [UIImageView new];
        _GoodsImage.image =[UIImage imageNamed:@"zly"];
        [self.contentView addSubview:_GoodsImage];
        _GoodsImage.sd_layout.leftSpaceToView(self.contentView, 12).topSpaceToView(self.contentView, kFit(36)).widthIs(kFit(82)).heightIs(kFit(86));
        
        
        self.invoiceType = [UILabel new];
        _invoiceType.text = @"纸质发票";
        _invoiceType.textAlignment = 1;
        _invoiceType.layer.cornerRadius = 3;
        _invoiceType.layer.masksToBounds = YES;
        _invoiceType.textColor = MColor(242, 48, 48);
        _invoiceType.font = MFont(kFit(12));
        _invoiceType.layer.borderWidth = 0.5;
        _invoiceType.layer.borderColor = [MColor(242, 48, 48) CGColor];
        [self.contentView addSubview:_invoiceType];
        _invoiceType.sd_layout.rightSpaceToView (self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(25)).widthIs(kFit(67)).heightIs(kFit(25));
        
        
        self.GoodsName = [UILabel new];
        _GoodsName.text = @"🐊鳄鱼牌沙发";
        _GoodsName.textColor = MColor(51, 51, 51);
        _GoodsName.font =MFont(kFit(15));
        [self.contentView addSubview:_GoodsName];
        _GoodsName.sd_layout.leftSpaceToView(_GoodsImage, kFit(17)).topSpaceToView(self.contentView, kFit(25)).rightSpaceToView(_invoiceType, kFit(12)).heightIs(kFit(15));
        
        
        self.invoiceLookedUp = [UILabel new];
        _invoiceLookedUp.text = @"发票抬头 :单位";
        _invoiceLookedUp.textColor = MColor(134, 134, 134);
        _invoiceLookedUp.font = MFont(kFit(12));
        [self.contentView addSubview:_invoiceLookedUp];
        _invoiceLookedUp.sd_layout.leftEqualToView(_GoodsName).topSpaceToView(_GoodsName, kFit(17)).heightIs(kFit(12)).rightSpaceToView(self.contentView, kFit(12));
        
        self.invoiceContent = [UILabel new];
        _invoiceContent.text = @"发票内容 :明细";
        _invoiceContent.textColor = MColor(134, 134, 134);
        _invoiceContent.font = MFont(kFit(12));
        [self.contentView addSubview:_invoiceContent];
        _invoiceContent.sd_layout.leftEqualToView(_GoodsName).topSpaceToView(_invoiceLookedUp, kFit(10)).heightIs(kFit(12)).rightSpaceToView(self.contentView, kFit(12));
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"发票金额 :￥720.00"];
        	[str addAttribute:NSForegroundColorAttributeName value:MColor(134, 134, 134) range:NSMakeRange(0,5)];
        
        self.invoiceMoney = [UILabel new];
        _invoiceMoney.textColor = MColor(51, 51, 51);
        _invoiceMoney.font = MFont(kFit(12));
        _invoiceMoney.attributedText = str;
        [self.contentView addSubview:_invoiceMoney];
        _invoiceMoney.sd_layout.leftEqualToView(_GoodsName).topSpaceToView(_invoiceContent, kFit(10)).heightIs(kFit(12)).rightSpaceToView(self.contentView, kFit(12));
        
        self.invoiceTime = [UILabel new];
        _invoiceTime.text = @"开票时间 :2016-12-26";
        _invoiceTime.textColor = MColor(134, 134, 134);
        _invoiceTime.font = MFont(kFit(12));
        [self.contentView addSubview:_invoiceTime];
        _invoiceTime.sd_layout.leftEqualToView(_GoodsName).topSpaceToView(_invoiceMoney, kFit(10)).heightIs(kFit(12)).rightSpaceToView(self.contentView, kFit(12));
        
      
        
        
        
    }
    return self;

}
- (void)ControlsAssignment:(NSString *)str {
    
    _invoiceType.text = str;

}

@end
