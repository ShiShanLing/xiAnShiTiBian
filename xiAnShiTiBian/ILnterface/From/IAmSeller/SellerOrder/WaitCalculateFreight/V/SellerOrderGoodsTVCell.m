//
//  SellerOrderGoodsTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/10.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerOrderGoodsTVCell.h"

@interface SellerOrderGoodsTVCell()
/**
 *商品图片
 */
@property (nonatomic, strong)UIImageView *GoodsImage;
/**
 *商品名称
 */
@property (nonatomic, strong)UILabel *GoodsName;
/**
 *商品规格
 */
@property (nonatomic, strong)UILabel *GoodsTyep;
/**
 *商品价钱
 */
@property (nonatomic, strong)UILabel *GoodsPrice;
/**
 *商品数量
 */
@property (nonatomic, strong)UILabel *GoodsNum;
@end

@implementation SellerOrderGoodsTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.GoodsImage = [UIImageView new];
        _GoodsImage.image = [UIImage imageNamed:@"zly"];
        _GoodsImage.layer.cornerRadius = 3;
        _GoodsImage.layer.masksToBounds=YES;
        [self.contentView addSubview:_GoodsImage];
        _GoodsImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).centerYEqualToView(self.contentView).widthIs(kFit(76)).heightIs(kFit(kFit(76)));
        
        self.GoodsName = [UILabel new];
        _GoodsName.text = @"鳄鱼牌沙发";
        _GoodsName.textColor = MColor(51, 51, 51);
        _GoodsName.font = MFont(kFit(13));
        [self.contentView addSubview:_GoodsName];
        _GoodsName.sd_layout.leftSpaceToView(_GoodsImage, kFit(10)).topEqualToView(_GoodsImage).widthIs(kFit(185)).heightIs(kFit(13));
        
        
        self.GoodsTyep = [UILabel new];
        _GoodsTyep.text = @"颜色:灰色;尺寸:XXL;";
        _GoodsTyep.textColor = MColor(161, 161, 161);
        _GoodsTyep.font = MFont(kFit(12));
        [self.contentView addSubview:_GoodsTyep];
        _GoodsTyep.sd_layout.leftEqualToView(_GoodsName).topSpaceToView(self.contentView, kFit(38)).widthIs(kFit(185)).heightIs(kFit(12));
        
        self.GoodsPrice = [UILabel new];
        _GoodsPrice.text = @"";
        _GoodsPrice.textColor = MColor(0, 0, 0);
        _GoodsPrice.textAlignment = 2;
        _GoodsPrice.font = MFont(kFit(11));
        [self.contentView addSubview:_GoodsPrice];
        _GoodsPrice.sd_layout.rightSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(11)).leftSpaceToView(_GoodsName, kFit(12)).heightIs(kFit(11));
        
        self.GoodsNum = [UILabel new];
        _GoodsNum.text = @"X 1";
        _GoodsNum.textAlignment = 2;
        _GoodsNum.textColor = MColor(134, 134, 134);
        _GoodsNum.font = MFont(kFit(11));
        [self.contentView addSubview:_GoodsNum];
        _GoodsNum.sd_layout.rightSpaceToView(self.contentView, kFit(12)).bottomSpaceToView(self.contentView, kFit(35)).heightIs(kFit(11)).leftSpaceToView(_GoodsTyep, kFit(12));
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(255, 255, 255);
        [self.contentView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(5));
    }
    return self;
}


- (void)setModel:(SellerOrderGoodsModel *)model {
    NSLog(@"setModel%@", model);
    
    [_GoodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImage_URL, model.goodsImage]] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    _GoodsName.text = model.goodsName;
    _GoodsNum.text = [NSString stringWithFormat:@"x%@", model.goodsNum];
    _GoodsPrice.text = [NSString stringWithFormat:@"¥:%@", model.goodsPrice];
    if ([model.specInfo isKindOfClass:[NSString class]]) {//如果是NSString
        _GoodsTyep.text = [NSString stringWithFormat:@"%@", model.specInfo];
        }else {
        
        NSString *typeStr;
        NSDictionary *typeDic = (NSDictionary *)model.specInfo;
        NSArray *keyArr = [typeDic allKeys];
        NSLog(@"model.specInfo%@ typeDic%@", model.specInfo, typeDic);
        
        for (int i  = 0; i < keyArr.count; i ++) {
            
            if (i == 0) {
                _GoodsTyep.text = [NSString stringWithFormat:@"%@:%@", keyArr[i], typeDic[keyArr[i]]];
            }else {
                _GoodsTyep.text = [NSString stringWithFormat:@"%@ \n%@:%@",_GoodsTyep.text, keyArr[i], typeDic[keyArr[i]]];
            }
        }
        _GoodsTyep.text = typeStr;
    }
}


@end
