//
//  VendorAllGoodsCVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/27.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "VendorAllGoodsCVCell.h"

@interface VendorAllGoodsCVCell ()

@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *goodsTitleLabel;
@property (nonatomic, strong) UILabel *goodsPrice;
@property (nonatomic, strong) UILabel *typeLabel;

@end

@implementation VendorAllGoodsCVCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = MColor(238, 238, 238);
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
        self.goodsImage = [[UIImageView alloc]init];
        self.goodsImage.image = [UIImage imageNamed:@"zly"];
        
        [self addSubview:self.goodsImage];
        _goodsImage.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).autoHeightRatio(0.916);
        
        self.goodsTitleLabel =[UILabel new];
        self.goodsTitleLabel.font = MFont(kFit(15));
        self.goodsTitleLabel.textColor = MColor(51, 51, 51);
        self.goodsTitleLabel.text = @"商品标题";
        [self addSubview:self.goodsTitleLabel];
        _goodsTitleLabel.sd_layout.leftSpaceToView(self, kFit(15)).topSpaceToView(_goodsImage, kFit(17.5)).rightSpaceToView(self, kFit(12)).heightIs(kFit(15));
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"价格￥59.9"];
        [str addAttribute:NSForegroundColorAttributeName value:MColor(134, 134, 134) range:NSMakeRange(0,2)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kFit(12)] range:NSMakeRange(0, 2)];//设置字体大小
        
        self.goodsPrice = [UILabel new];
        _goodsPrice.font = MFont(kFit(14));
        _goodsPrice.textColor = MColor(255, 50, 50);
        _goodsPrice.attributedText = str;
        [self addSubview:self.goodsPrice];
        _goodsPrice.sd_layout.leftSpaceToView(self, kFit(15)).topSpaceToView(_goodsTitleLabel, kFit(15)).rightSpaceToView(self, kFit(12)).heightIs(kFit(14));
        
        
        self.typeLabel = [UILabel new];
        self.typeLabel.font = MFont(kFit(12));
        _typeLabel.textColor = MColor(134, 134, 134);
        //self.typeLabel.text = @"规格 : 230*130*50";
        [self addSubview:self.typeLabel];
        _typeLabel.sd_layout.leftSpaceToView(self, kFit(15)).topSpaceToView(_goodsPrice, kFit(10)).rightSpaceToView(self, kFit(12)).heightIs(kFit(14));
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(likeGoodsClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setModel:(GoodsDetailsModel *)model {
    
    [_goodsImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kSHY_100, model.goodsImage] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.goodsTitleLabel.text = model.goodsName;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"价格￥%.2f", model.goodsStorePrice]];
    [str addAttribute:NSForegroundColorAttributeName value:MColor(134, 134, 134) range:NSMakeRange(0,2)];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kFit(12)] range:NSMakeRange(0, 2)];//设置字体大小
    _goodsPrice.attributedText = str;
    
}

@end
