
//
//  GoodsShowCViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/1.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "GoodsShowCViewCell.h"

@implementation GoodsShowCViewCell
-(instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = MColor(242 , 242, 242);
        self.contentView.layer.cornerRadius = 3;
        self.contentView.layer.masksToBounds = YES;
        [self CreatingControls];
    }
    return self;
}
- (void)CreatingControls {
    
    self.goodsImage = [UIImageView new];
    self.goodsImage.image = [UIImage imageNamed:@"zly"];
    [self.contentView addSubview:self.goodsImage];
    self.goodsImage.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).autoHeightRatio(1.0);
    
    self.goodsName = [UILabel new];
    self.goodsName.text = @"获取失败!";
    self.goodsName.font = MFont(kFit(13));
    
    [self.contentView addSubview:self.goodsName];
    self.goodsName.sd_layout.leftSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, 5).topSpaceToView(self.goodsImage, 5).heightIs(15);
    
    self.goodsOPrice = [UILabel new];
    self.goodsOPrice.textColor = [UIColor redColor];
    self.goodsOPrice.font = MFont(kFit(13));
    self.goodsOPrice.text = @"￥:3500";
    [self.contentView addSubview:self.goodsOPrice];
    self.goodsOPrice.sd_layout.leftSpaceToView(self.contentView, 5).topSpaceToView(self.goodsName, 5).heightIs(15).widthIs(self.frame.size.width/2);
    
    self.goodsPPrice = [UILabel new];
    self.goodsPPrice.textColor = [UIColor lightGrayColor];
    self.goodsPPrice.font = MFont(kFit(11));
    
    self.goodsPPrice.attributedText = [self customFont:@"¥:&&&"];;
    [self.contentView addSubview:self.goodsPPrice];
    self.goodsPPrice.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.goodsOPrice, 0).heightIs(15).widthIs(self.frame.size.width/2);
    
    self.GoodsAwardPoints = [UILabel new];
    self.GoodsAwardPoints.textColor = [UIColor lightGrayColor];
    self.GoodsAwardPoints.text = @"购买送&&&积分";
    self.GoodsAwardPoints.font = MFont(kFit(11));
    self.GoodsAwardPoints.textAlignment = 2;
    [self.contentView addSubview:self.GoodsAwardPoints];
    self.GoodsAwardPoints.sd_layout.rightSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 5).heightIs(15).widthIs(self.frame.size.width/2);
    
    self.GoodsPeopleBuy = [UILabel new];
    self.GoodsPeopleBuy.textColor = [UIColor lightGrayColor];
    self.GoodsPeopleBuy.text = @"20000人购买";
    self.GoodsPeopleBuy.font = MFont(kFit(11));
    self.GoodsPeopleBuy.textAlignment = 2;
    [self.contentView addSubview:self.GoodsPeopleBuy];
    self.GoodsPeopleBuy.sd_layout.rightSpaceToView(self.contentView, 5).bottomSpaceToView(self.GoodsAwardPoints, 5).heightIs(15).widthIs(self.frame.size.width/2);
    
}

- (void)setModel:(GoodsDetailsModel *)model {
    
   // NSLog(@"setModel%@", model);
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImage_URL, model.goodsImage]] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.goodsName.text = model.goodsName;
    self.goodsOPrice.text = [NSString stringWithFormat:@"¥:%.2f", model.goodsStorePrice];
    self.goodsPPrice.attributedText = [self customFont:[NSString stringWithFormat:@"¥:%.2f",model.goodsMarketPrice]];
    if (model.giftPoints == 0) {
        self.GoodsAwardPoints.text = @"";
    }else {
        self.GoodsAwardPoints.text = [NSString stringWithFormat:@"购买送%d积分", model.giftPoints];
    }
    
    if (model.salenum == 0) {
        self.GoodsPeopleBuy.text = @"";
    }else {
        self.GoodsPeopleBuy.text = [NSString stringWithFormat:@"%d人购买", model.salenum];
    }
    
}

- (void)configureCellWithPostURL:(NSString *)posterURL {
    
    self.goodsImage.image = [UIImage imageNamed:posterURL];
}

- (NSAttributedString *)customFont:(NSString *)str {
    NSAttributedString *attrStr =
    [[NSAttributedString alloc]initWithString:str
                                   attributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:11.f],
       NSForegroundColorAttributeName:[UIColor lightGrayColor],
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    return attrStr;
}

@end
