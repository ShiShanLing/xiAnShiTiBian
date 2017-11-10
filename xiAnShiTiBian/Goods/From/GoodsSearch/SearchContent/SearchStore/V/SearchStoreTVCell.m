
//
//  SearchStoreTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/3.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SearchStoreTVCell.h"

@interface SearchStoreTVCell ()
/**
 *商家logo
 */
@property (nonatomic, strong)UIImageView *StoreImage;
/**
 *商家名字
 */
@property (nonatomic, strong)UILabel *StoreNameLable;
/**
 *商家销量
 */
@property (nonatomic, strong)UILabel *SalesLable;
/**
 *商家商品数量
 */
@property (nonatomic, strong)UILabel *StoreGoodsNum;
/**
 *进入商店按钮
 */
@property (nonatomic, strong)OrderBtn *entranceStoreBtn;
/**
 *商店商品展示1
 */
@property (nonatomic, strong)UIImageView *StoreGoodsShowImageOne;
/**
 *商店商品展示2
 */
@property (nonatomic, strong)UIImageView *StoreGoodsShowImageTwo;
/**
 *商店商品展示3
 */
@property (nonatomic, strong)UIImageView *StoreGoodsShowImageThree;

@end

@implementation SearchStoreTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCellView];
    }
    return self;
}
- (void)configCellView {

    self.StoreImage = [UIImageView new];
    self.StoreImage.image = [UIImage imageNamed:@"zly"];
    _StoreImage.layer.cornerRadius = 3;
    _StoreImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.StoreImage];
    _StoreImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(17.5)).widthIs(kFit(53)).heightIs(kFit(53));
    
    
    self.StoreNameLable = [UILabel new];
    _StoreNameLable.text = @"🐊鳄鱼沙发专卖店";
    _StoreNameLable.textColor = MColor( 51, 51, 51);
    _StoreNameLable.font = MFont(kFit(15));
    [self.contentView addSubview:self.StoreNameLable];
    _StoreNameLable.sd_layout.leftSpaceToView (_StoreImage, kFit(15)).topSpaceToView(self.contentView, kFit(27.5)).rightSpaceToView(self.contentView,kFit(77)).heightIs(kFit(15));
    
    self.SalesLable =[UILabel new];
    _SalesLable.text = @"";
    _SalesLable.textColor = MColor(161, 161, 161);
    
    _SalesLable.font = MFont(kFit(12));
    [self.contentView addSubview:self.SalesLable];
    CGFloat width = [self getWidthWithTitle:@"" font:12];
    _SalesLable.sd_layout.leftSpaceToView(self.StoreImage, kFit(15)).topSpaceToView(_StoreNameLable, kFit(10)).widthIs(width).heightIs(kFit(12));
    
    self.StoreGoodsNum = [UILabel new];
    _StoreGoodsNum.text = @"";
    _StoreGoodsNum.textColor = MColor(161, 161, 161);
    _StoreGoodsNum.font = MFont(kFit(12));
    width = [self getWidthWithTitle:@"" font:12];
    [self.contentView addSubview:self.StoreGoodsNum];
    _StoreGoodsNum.sd_layout.leftSpaceToView(_StoreImage, kFit(15)).topEqualToView(_SalesLable).heightIs(kFit(12)).rightSpaceToView(self.contentView,kFit(77));
    
    self.entranceStoreBtn = [OrderBtn new];
    [_entranceStoreBtn setTitle:@"进店" forState:(UIControlStateNormal)];
    _entranceStoreBtn.layer.cornerRadius = 3;
    _entranceStoreBtn.layer.masksToBounds = YES;
    _entranceStoreBtn.layer.borderWidth = 0.5;
    _entranceStoreBtn.layer.borderColor = [MColor(134, 134, 134) CGColor];
    _entranceStoreBtn.titleLabel.font = MFont(kFit(14));
    [_entranceStoreBtn setTitleColor:MColor(134, 134, 134) forState:(UIControlStateNormal)];
    [_entranceStoreBtn addTarget:self action:@selector(handleEntranceStoreBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.entranceStoreBtn];
    _entranceStoreBtn.sd_layout.rightSpaceToView(self.contentView,kFit(12)).bottomEqualToView(_StoreGoodsNum).widthIs(kFit(65)).heightIs(28);

    
    //计算图片的宽度  最左,右边间距各位4.5一共9 图片之间的间距为3 一共6  图片宽度=(屏幕宽度-15) / 3
    
    CGFloat imageWidth = (kScreen_widht - kFit(15))/3;
    
    self.StoreGoodsShowImageOne = [UIImageView new];
    _StoreGoodsShowImageOne.layer.cornerRadius = 3;
    _StoreGoodsShowImageOne.layer.masksToBounds = YES;
    _StoreGoodsShowImageOne.image = [UIImage imageNamed:@"zly"];
    [self.contentView addSubview:self.StoreGoodsShowImageOne];
    _StoreGoodsShowImageOne.sd_layout.leftSpaceToView(self.contentView, kFit(4.5)).topSpaceToView(self.StoreImage, 17.5).widthIs(imageWidth).heightIs(kFit(115));
    
    self.StoreGoodsShowImageTwo = [UIImageView new];
    _StoreGoodsShowImageTwo.layer.cornerRadius = 3;
    _StoreGoodsShowImageTwo.layer.masksToBounds = YES;
    _StoreGoodsShowImageTwo.image = [UIImage imageNamed:@"zly"];
    [self.contentView addSubview:self.StoreGoodsShowImageTwo];
     _StoreGoodsShowImageTwo.sd_layout.leftSpaceToView(_StoreGoodsShowImageOne, kFit(3)).topSpaceToView(self.StoreImage, 17.5).widthIs(imageWidth).heightIs(kFit(115));
    
    
    self.StoreGoodsShowImageThree = [UIImageView new];
    _StoreGoodsShowImageThree.layer.cornerRadius = 3;
    _StoreGoodsShowImageThree.layer.masksToBounds = YES;
    _StoreGoodsShowImageThree.image = [UIImage imageNamed:@"zly"];
    [self.contentView addSubview:self.StoreGoodsShowImageThree];
    _StoreGoodsShowImageThree.sd_layout.leftSpaceToView(_StoreGoodsShowImageTwo, kFit(3)).topSpaceToView(self.StoreImage, 17.5).widthIs(imageWidth).heightIs(kFit(115));

}

- (void)handleEntranceStoreBtn:(OrderBtn *)sender {
    if ([_delegate respondsToSelector:@selector(entranceStore:)]) {
        [_delegate entranceStore:sender];
    }
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(CGFloat)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = MFont(kFit(font));
    [label sizeToFit];
    return label.frame.size.width;
}

- (void)setModel:(SellerDataModel *)model {
    _model = model;
    [_StoreImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.storeLogo] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    _StoreNameLable.text = model.storeName;
    _SalesLable.text = @"销量600";
    _StoreGoodsNum.text = [NSString stringWithFormat:@"创建时间:%@", model.createTimeStr];

}

- (void)ToControlGiveTag:(NSIndexPath *)indexPath {

    _entranceStoreBtn.indexPath = indexPath;
}

@end
