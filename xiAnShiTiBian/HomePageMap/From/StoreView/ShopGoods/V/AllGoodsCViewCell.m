//
//  AllGoodsCViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/7.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "AllGoodsCViewCell.h"

@implementation AllGoodsCViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setCreatingControls];
    }
    return self;

}


- (void)setCreatingControls {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, self.frame.size.height)];
    [self.contentView addSubview:view];
    
    self.showImage = [UIImageView new];
    self.showImage.image = [UIImage imageNamed:@"zly"];
    self.showImage.layer.cornerRadius = 3;
    self.showImage.layer.masksToBounds = YES;
    
    [view addSubview:self.showImage];
    self.showImage.sd_layout.leftSpaceToView(view, 12).topSpaceToView(view, 15).bottomSpaceToView(view, 15).widthIs(kScreen_widht *0.346667).autoHeightRatio(0.93);
   
    self.nameLabel = [UILabel new];
    self.nameLabel.text =@"绝版红尘木";
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
    [view addSubview:self.nameLabel];
    self.nameLabel.sd_layout.leftSpaceToView(self.showImage, 17).topSpaceToView(view, 25).heightIs(20).rightSpaceToView(view, 15);
    
    self.priceLabel = [UILabel new];
    self.priceLabel.text = @"￥599.00";
    self.priceLabel.font = MFont(kFit(15));
    self.priceLabel.textColor = [UIColor colorWithRed:255/256.0 green:50/256.0 blue:50/256.0 alpha:1];
    [view addSubview:self.priceLabel];
    self.priceLabel.sd_layout.leftSpaceToView(self.showImage, 17).topSpaceToView(self.nameLabel, 20).heightIs(18).rightSpaceToView(view, 15);
    
    self.originalPriceLabel = [UILabel new];
        self.originalPriceLabel.attributedText = [self fontChanges:@"¥:123"];
    [view addSubview:self.originalPriceLabel];
    self.originalPriceLabel.sd_layout.leftSpaceToView(self.showImage, 20).topSpaceToView(self.priceLabel, 10).widthIs(100).heightIs(10);
    
    self.AwardPointsLabel = [UILabel new];
    self.AwardPointsLabel.text = @"购买送500积分";
    self.AwardPointsLabel.textColor = [UIColor colorWithRed:161/256.0 green:161/256.0 blue:161/256.0 alpha:1];
    self.AwardPointsLabel.font = [UIFont systemFontOfSize:11];
    [view addSubview:self.AwardPointsLabel];
    self.AwardPointsLabel.sd_layout.leftSpaceToView(self.showImage, 17).topSpaceToView(self.originalPriceLabel, 15).widthIs(kScreen_widht/3).heightIs(7);
    
    self.heatLabel = [UILabel new];
    self.heatLabel.text = @"300W人购买";
    self.heatLabel.textAlignment =2;
    self.heatLabel.textColor = [UIColor colorWithRed:161/256.0 green:161/256.0 blue:161/256.0 alpha:1];
    self.heatLabel.font =[UIFont systemFontOfSize:11];
    [view addSubview:self.heatLabel];
    self.heatLabel.sd_layout.rightSpaceToView(view,12).topSpaceToView(self.originalPriceLabel, 15).heightIs(7).widthIs(kScreen_widht/3);
    
    UILabel *bottomLabel = [UILabel new];
    bottomLabel.backgroundColor = [UIColor colorWithRed:210/256.0 green:210/256.0 blue:210/256.0 alpha:1];

    [view addSubview:bottomLabel];
    bottomLabel.sd_layout.leftSpaceToView(view, 0).bottomSpaceToView(view, 0).rightSpaceToView(view, 0).heightIs(0.5);
    
    
}

- (void)setModel:(GoodsDetailsModel *)model {
    [self.showImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.goodsImage] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    self.nameLabel.text = model.goodsName;
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%.2f", model.goodsStorePrice];
    self.originalPriceLabel.attributedText = [self fontChanges:[NSString stringWithFormat:@"¥:%.2f", model.goodsMarketPrice]];
    if (model.giftPoints == 0) {
        
    }else {
    self.AwardPointsLabel.text = [NSString stringWithFormat:@"购买送%d积分", model.giftPoints];
    }
    self.heatLabel.text = [NSString stringWithFormat:@"%d人购买", model.salenum];
}

- (NSAttributedString *)fontChanges:(NSString *)str {
    NSAttributedString *attrStr =
    [[NSAttributedString alloc]initWithString:str
                                   attributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:13.f],
       NSForegroundColorAttributeName:[UIColor colorWithRed:161/256.0 green:161/256.0 blue:161/256.0 alpha:1],
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    return attrStr;
}

@end
