//
//  VendorGoodsView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "VendorGoodsView.h"
#import "UIImageView+WebCache.h"

@implementation VendorGoodsView

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
        self.goodsTitleLabel.text = @"";
        [self addSubview:self.goodsTitleLabel];
        _goodsTitleLabel.sd_layout.leftSpaceToView(self, kFit(15)).topSpaceToView(_goodsImage, kFit(17.5)).rightSpaceToView(self, kFit(12)).heightIs(kFit(15));

        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"出厂价 ￥59.9"];
        [str addAttribute:NSForegroundColorAttributeName value:MColor(134, 134, 134) range:NSMakeRange(0,3)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kFit(12)] range:NSMakeRange(0, 3)];//设置字体大小
        
        self.goodsPriceLabel = [UILabel new];
        _goodsPriceLabel.font = MFont(kFit(14));
        _goodsPriceLabel.textColor = MColor(255, 50, 50);
        _goodsPriceLabel.attributedText = str;
        [self addSubview:self.goodsPriceLabel];
         _goodsPriceLabel.sd_layout.leftSpaceToView(self, kFit(15)).topSpaceToView(_goodsTitleLabel, kFit(15)).rightSpaceToView(self, kFit(12)).heightIs(kFit(14));
        
        
        self.typeLabel = [UILabel new];
        self.typeLabel.font = MFont(kFit(12));
        _typeLabel.textColor = MColor(134, 134, 134);
        self.typeLabel.text = @"";
        [self addSubview:self.typeLabel];
        _typeLabel.sd_layout.leftSpaceToView(self, kFit(15)).topSpaceToView(_goodsPriceLabel, kFit(10)).rightSpaceToView(self, kFit(12)).heightIs(kFit(14));
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(likeGoodsClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)assignment:(NSString *)url {
    
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kImage_URL, url]] placeholderImage:[UIImage imageNamed:@"zly"]];
}

- (void)likeGoodsClick:(UITapGestureRecognizer *)tap{
    
    if ([_delegate respondsToSelector:@selector(viewClick:)]) {
        [_delegate viewClick:self];
    }
}


@end
