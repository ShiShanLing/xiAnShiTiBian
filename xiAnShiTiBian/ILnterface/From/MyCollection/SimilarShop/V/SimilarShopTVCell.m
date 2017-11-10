//
//  SimilarShopTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/10.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SimilarShopTVCell.h"

@interface SimilarShopTVCell ()

/**
 *店铺logo
 */
@property (nonatomic, strong)UIImageView *ShopImage;
/**
 *店铺名称
 */
@property (nonatomic, strong)UILabel *ShopName;
/**
 *店铺等级
 */
@property (nonatomic, strong)UIButton *levelBtn;
/**
 *店铺收藏次数
 */
@property (nonatomic, strong)UILabel *collectionNumLabel;
/**
 *商品展示1
 */
@property (nonatomic, strong)UIImageView *GoodsShowOne;
/**
 *商品展示2
 */
@property (nonatomic, strong)UIImageView *GoodsShowTwo;
/**
 *商品展示3
 */
@property (nonatomic, strong)UIImageView *GoodsShowThree;


@end

@implementation SimilarShopTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.ShopImage = [UIImageView new];
        _ShopImage.image = [UIImage imageNamed:@"zly"];
        [self.contentView addSubview:_ShopImage];
        _ShopImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(12)).widthIs(kFit(48)).heightIs(kFit(48));
        
        self.ShopName = [UILabel new];
        _ShopName.text = @"鳄鱼牌沙发专卖店";
        _ShopName.font = MFont(kFit(12));
        _ShopName.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_ShopName];
        _ShopName.sd_layout.leftSpaceToView(_ShopImage, kFit(13)).topEqualToView(_ShopImage).rightSpaceToView(self.contentView, kFit(12)).heightIs(kFit(12));
        
        
        self.levelBtn = [UIButton new];
        UIImage *LevelImage = [UIImage imageNamed:@"vip3"];
        LevelImage = [LevelImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_levelBtn setImage:LevelImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:_levelBtn];
        _levelBtn.sd_layout.leftEqualToView(_ShopName).topSpaceToView(_ShopName,kFit(5)).widthIs(kFit(20)).heightIs(kFit(15));
        
        self.collectionNumLabel = [UILabel new];
        _collectionNumLabel.textColor = MColor(161, 161, 161);
        _collectionNumLabel.text = @"已经被收藏3333次";
        _collectionNumLabel.font = MFont(kFit(12));
        [self.contentView addSubview:_collectionNumLabel];
        _collectionNumLabel.sd_layout.leftEqualToView(_ShopName).topSpaceToView(_levelBtn, kFit(8)).heightIs(kFit(12)).rightSpaceToView(self.contentView, kFit(12));

        //计算宽度
        self.GoodsShowOne = [UIImageView new];
        _GoodsShowOne.image = [UIImage imageNamed:@"zly"];
        [self.contentView addSubview:_GoodsShowOne];
        _GoodsShowOne.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(_ShopImage, kFit(13)).widthIs(kFit(115)).heightIs(kFit(115));
        
        self.GoodsShowTwo = [UIImageView new];
        _GoodsShowTwo.image = [UIImage imageNamed:@"zly"];
        [self.contentView addSubview:_GoodsShowTwo];
        _GoodsShowTwo.sd_layout.leftSpaceToView(_GoodsShowOne, kFit(3.5)).topEqualToView(_GoodsShowOne).widthIs(kFit(115)).heightIs(kFit(115));
        
        
        self.GoodsShowThree = [UIImageView new];
        _GoodsShowThree.image = [UIImage imageNamed:@"zly"];
        [self.contentView addSubview:_GoodsShowThree];
        _GoodsShowThree.sd_layout.leftSpaceToView(_GoodsShowTwo, kFit(3.5)).topEqualToView(_GoodsShowOne).widthIs(kFit(115)).heightIs(kFit(115));
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(0.5);
    }
    return self;
}
@end
