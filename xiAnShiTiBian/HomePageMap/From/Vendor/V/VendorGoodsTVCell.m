//
//  VendorGoodsTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "VendorGoodsTVCell.h"
#import "VendorGoodsView.h"

@interface VendorGoodsTVCell ()

@property (nonatomic, strong)VendorGoodsView *VendorGoodsOne;
@property (nonatomic, strong)VendorGoodsView *VendorGoodsTwo;
@property (nonatomic, strong)VendorGoodsView *VendorGoodstThree;
@property (nonatomic, strong)VendorGoodsView *VendorGoodsFour;


@end

@implementation VendorGoodsTVCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UILabel *segmentationLabel = [UILabel new];
        segmentationLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:segmentationLabel];
        segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, kFit(0)).rightSpaceToView(self.contentView, 0).heightIs(kFit(10));
        
        UILabel *tilteLabel = [UILabel new];
        tilteLabel.text = @"产品";
        tilteLabel.textColor = MColor(51, 51, 51);
        tilteLabel.font = MFont(kFit(17));
        [self.contentView addSubview:tilteLabel];
        tilteLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(segmentationLabel,kFit(17.5)).widthIs(kFit(100)).heightIs(kFit(17.5));
        
        
        UIButton *moreBtn = [UIButton new];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:kFit(14)];
        [moreBtn setTitle:@"更多" forState:(UIControlStateNormal)];
        [moreBtn setTitleColor:MColor(134, 134, 134) forState:(UIControlStateNormal)];
        UIImage *buttonimage = [UIImage imageNamed:@"jt"];
        buttonimage = [buttonimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [moreBtn setImage:buttonimage forState:(UIControlStateNormal)];
        UIEdgeInsets imageframe;
        imageframe = moreBtn.imageEdgeInsets;
        imageframe.right -= 40;
        moreBtn.imageEdgeInsets = imageframe;
        UIEdgeInsets titleframe;
        titleframe = moreBtn.titleEdgeInsets;
        titleframe.left -=42;
        moreBtn.titleEdgeInsets = titleframe;
        [moreBtn addTarget:self action:@selector(handleMoreBtn) forControlEvents:(UIControlEventTouchUpInside)];
      //  [self.contentView addSubview:moreBtn];
        moreBtn.sd_layout.rightSpaceToView(self.contentView, 0).topSpaceToView(segmentationLabel, kFit(5)).heightIs(kFit(42)).widthIs(kFit(50));
        
        
        self.VendorGoodsOne = [VendorGoodsView new];
        _VendorGoodsOne.hidden = YES;
        [self.contentView addSubview:_VendorGoodsOne];
        _VendorGoodsOne.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(tilteLabel, kFit(17.5)).widthIs(kFit(173)).heightIs(kFit(253));
        
        self.VendorGoodsTwo = [VendorGoodsView new];
        _VendorGoodsTwo.hidden = YES;
        [self.contentView addSubview:_VendorGoodsTwo];
        _VendorGoodsTwo.sd_layout.leftSpaceToView(_VendorGoodsOne, kFit(5)).topSpaceToView(tilteLabel, kFit(17.5)).widthIs(kFit(173)).heightIs(kFit(253));
        
        self.VendorGoodstThree = [VendorGoodsView new];
        _VendorGoodstThree.hidden = YES;
        [self.contentView addSubview:_VendorGoodstThree];
        _VendorGoodstThree.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(_VendorGoodsOne, kFit(5)).widthIs(kFit(173)).heightIs(kFit(253));
        
        self.VendorGoodsFour = [VendorGoodsView new];
         _VendorGoodsFour.hidden = YES;
        [self.contentView addSubview:_VendorGoodsFour];
        _VendorGoodsFour.sd_layout.leftSpaceToView(_VendorGoodsOne, kFit(5)).topSpaceToView(_VendorGoodsOne, kFit(5)).widthIs(kFit(173)).heightIs(kFit(253));
    }
    return self;
}
- (void)handleMoreBtn {
    if ([_delegate respondsToSelector:@selector(MoreProducts)]) {
        [_delegate MoreProducts];
    }
}

- (void)setModel:(FactoryDataModel *)model {
    NSArray *goodsArray = model.listGoods;
    NSLog(@"FactoryDataModel%@", goodsArray);
    for (int i = 0 ;i < goodsArray.count ; i++) {
        if (i == 0) {
            GoodsDetailsModel *model = goodsArray[0];
            [self.VendorGoodsOne.goodsImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.goodsImage] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
            self.VendorGoodsOne.goodsTitleLabel.text = model.goodsName;
            self.VendorGoodsOne.goodsPriceLabel.text = [NSString stringWithFormat:@"¥:%.2f", model.goodCostPrice];
            self.VendorGoodsOne.typeLabel.text = [NSString stringWithFormat:@"店铺名字:%@", model.storeName];
            self.VendorGoodsOne.hidden = NO;
        }
        if (i == 1) {
            GoodsDetailsModel *model = goodsArray[1];
            [self.VendorGoodsTwo.goodsImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.goodsImage] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
            self.VendorGoodsTwo.goodsTitleLabel.text = model.goodsName;
            self.VendorGoodsTwo.goodsPriceLabel.text = [NSString stringWithFormat:@"¥:%.2f", model.goodCostPrice];
            self.VendorGoodsTwo.typeLabel.text = [NSString stringWithFormat:@"店铺名字:%@", model.storeName];
            self.VendorGoodsTwo.hidden = NO;
        }
        if (i == 2) {
            GoodsDetailsModel *model = goodsArray[2];
            [self.VendorGoodstThree.goodsImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.goodsImage] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
            self.VendorGoodstThree.goodsTitleLabel.text = model.goodsName;
            self.VendorGoodstThree.goodsPriceLabel.text = [NSString stringWithFormat:@"¥:%.2f", model.goodCostPrice];
            self.VendorGoodstThree.typeLabel.text = [NSString stringWithFormat:@"店铺名字:%@", model.storeName];
            self.VendorGoodstThree.hidden = NO;
        }
        if (i == 3) {
            GoodsDetailsModel *model = goodsArray[3];
            [self.VendorGoodsFour.goodsImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.goodsImage] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
            self.VendorGoodsFour.goodsTitleLabel.text = model.goodsName;
            self.VendorGoodsFour.goodsPriceLabel.text = [NSString stringWithFormat:@"¥:%.2f", model.goodCostPrice];
            self.VendorGoodsFour.typeLabel.text = [NSString stringWithFormat:@"店铺名字:%@", model.storeName];
            self.VendorGoodsFour.hidden = NO;
        }
    }
    
    


}

@end
