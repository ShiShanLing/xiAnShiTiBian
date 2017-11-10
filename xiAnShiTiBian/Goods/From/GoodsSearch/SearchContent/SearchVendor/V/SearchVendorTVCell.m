//
//  SearchVendorTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/14.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SearchVendorTVCell.h"

@interface SearchVendorTVCell ()
/**
 *厂家logo
 */
@property (nonatomic, strong)UIImageView *StoreImage;
/**
 *厂家名字
 */
@property (nonatomic, strong)UILabel *StoreNameLable;
/**
 *厂家下面的经销商
 */
@property (nonatomic, strong)UILabel *SalesLable;


/**
 *厂家经销商展示1
 */
@property (nonatomic, strong)UIImageView *StoreShowImageOne;
/**
 *厂家经销商展示1名字
 */
@property (nonatomic, strong)UILabel *StoreNameOne;
/**
 *厂家经销商展示2
 */
@property (nonatomic, strong)UIImageView *StoreShowImageTwo;
/**
 *厂家经销商展示2名字
 */
@property (nonatomic, strong)UILabel *StoreNameTwo;
/**
 *厂家经销商展示3
 */
@property (nonatomic, strong)UIImageView *StoreShowImageThree;
/**
 *厂家经销商展示3名字
 */
@property (nonatomic, strong)UILabel *StoreNameThree;



@end

@implementation SearchVendorTVCell



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
    _StoreNameLable.text = @"🐊鳄鱼沙发批发厂";
    _StoreNameLable.textColor = MColor( 51, 51, 51);
    _StoreNameLable.font = MFont(kFit(15));
    [self.contentView addSubview:self.StoreNameLable];
    _StoreNameLable.sd_layout.leftSpaceToView (_StoreImage, kFit(15)).topSpaceToView(self.contentView, kFit(27.5)).rightSpaceToView(self.contentView,kFit(77)).heightIs(kFit(15));
    
    self.SalesLable =[UILabel new];
    //_SalesLable.text = @"30家经销商";
    _SalesLable.textColor = MColor(161, 161, 161);
    
    _SalesLable.font = MFont(kFit(12));
    [self.contentView addSubview:self.SalesLable];
    
    _SalesLable.sd_layout.leftSpaceToView(self.StoreImage, kFit(15)).topSpaceToView(_StoreNameLable, kFit(10)).widthIs(kFit(200)).heightIs(kFit(12));
    
    self.entranceStoreBtn = [OrderBtn new];
    [_entranceStoreBtn setTitle:@"进厂" forState:(UIControlStateNormal)];
    _entranceStoreBtn.layer.cornerRadius = 3;
    _entranceStoreBtn.layer.masksToBounds = YES;
    
    _entranceStoreBtn.layer.borderWidth = 0.5;
    _entranceStoreBtn.layer.borderColor = [MColor(134, 134, 134) CGColor];
    _entranceStoreBtn.titleLabel.font = MFont(kFit(14));
    [_entranceStoreBtn setTitleColor:MColor(134, 134, 134) forState:(UIControlStateNormal)];
    [_entranceStoreBtn addTarget:self action:@selector(handleEntranceStoreBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.entranceStoreBtn];
    _entranceStoreBtn.sd_layout.rightSpaceToView(self.contentView,kFit(12)).bottomEqualToView(_StoreNameLable).widthIs(kFit(65)).heightIs(28);
    
    self.navigationBtn = [OrderBtn new];
    [_navigationBtn setTitle:@"导航" forState:(UIControlStateNormal)];
    _navigationBtn.layer.cornerRadius = 3;
    _navigationBtn.layer.masksToBounds = YES;
    
    _navigationBtn.layer.borderWidth = 0.5;
    _navigationBtn.layer.borderColor = [MColor(134, 134, 134) CGColor];
    _navigationBtn.titleLabel.font = MFont(kFit(14));
    [_navigationBtn setTitleColor:MColor(134, 134, 134) forState:(UIControlStateNormal)];
    [_navigationBtn addTarget:self action:@selector(handleNavigationBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_navigationBtn];
    _navigationBtn.sd_layout.rightSpaceToView(self.contentView,kFit(12)).topSpaceToView(_entranceStoreBtn, kFit(12)).widthIs(kFit(65)).heightIs(28);
    
        //计算图片的宽度  最左,右边间距各位4.5一共9 图片之间的间距为3 一共6  图片宽度=(屏幕宽度-15) / 3
    
    CGFloat imageWidth = (kScreen_widht - kFit(15))/3;
    
    self.StoreShowImageOne = [UIImageView new];
    _StoreShowImageOne.layer.cornerRadius = 3;//这是对图片的圆角度进行调整
    _StoreShowImageOne.layer.masksToBounds = YES;
    _StoreShowImageOne.userInteractionEnabled = NO;
    _StoreShowImageOne.image = [UIImage imageNamed:@"zly"];
    [self.contentView addSubview:self.
     StoreShowImageOne];
    _StoreShowImageOne.sd_layout.leftSpaceToView(self.contentView, kFit(4.5)).topSpaceToView(self.StoreImage, 17.5).widthIs(imageWidth).heightIs(kFit(115));
    
    UILabel *TransparentBackgroundLabelOne = [UILabel new];
    TransparentBackgroundLabelOne.alpha = 0.7;
    TransparentBackgroundLabelOne.backgroundColor = [UIColor whiteColor];
    [_StoreShowImageOne addSubview:TransparentBackgroundLabelOne];
    TransparentBackgroundLabelOne.sd_layout.leftSpaceToView(_StoreShowImageOne, 0).bottomSpaceToView(_StoreShowImageOne, 0).heightIs(kFit(15)).rightSpaceToView(_StoreShowImageOne, 0);
    
    self.StoreNameOne = [UILabel new];
    _StoreNameOne.font = MFont(kFit(15));
    _StoreNameOne.textAlignment = 1;
    [_StoreShowImageOne addSubview:_StoreNameOne];
     _StoreNameOne.sd_layout.leftSpaceToView(_StoreShowImageOne, 0).bottomSpaceToView(_StoreShowImageOne, 0).heightIs(kFit(15)).rightSpaceToView(_StoreShowImageOne, 0);
    
    self.StoreShowImageTwo = [UIImageView new];
    _StoreShowImageTwo.layer.cornerRadius = 3;
    _StoreShowImageTwo.layer.masksToBounds = YES;
    _StoreShowImageTwo.image = [UIImage imageNamed:@"zly"];
    [self.contentView addSubview:self.StoreShowImageTwo];
    _StoreShowImageTwo.sd_layout.leftSpaceToView(_StoreShowImageOne, kFit(3)).topSpaceToView(self.StoreImage, 17.5).widthIs(imageWidth).heightIs(kFit(115));
    
    UILabel *TransparentBackgroundLabelTwo = [UILabel new];
    TransparentBackgroundLabelTwo.alpha = 0.7;
    TransparentBackgroundLabelTwo.backgroundColor = [UIColor whiteColor];
    [_StoreShowImageTwo addSubview:TransparentBackgroundLabelTwo];
    TransparentBackgroundLabelTwo.sd_layout.leftSpaceToView(_StoreShowImageTwo, 0).bottomSpaceToView(_StoreShowImageTwo, 0).heightIs(kFit(15)).rightSpaceToView(_StoreShowImageTwo, 0);
    
    self.StoreNameTwo = [UILabel new];
    _StoreNameTwo.font = MFont(kFit(15));
    _StoreNameTwo.textAlignment = 1;
    [_StoreShowImageTwo addSubview:_StoreNameTwo];
    _StoreNameTwo.sd_layout.leftSpaceToView(_StoreShowImageTwo, 0).bottomSpaceToView(_StoreShowImageTwo, 0).heightIs(kFit(15)).rightSpaceToView(_StoreShowImageTwo, 0);
    
    
    self.StoreShowImageThree = [UIImageView new];
    _StoreShowImageThree.layer.cornerRadius = 3;
    _StoreShowImageThree.layer.masksToBounds = YES;
    _StoreShowImageThree.image = [UIImage imageNamed:@"zly"];
    [self.contentView addSubview:self.StoreShowImageThree];
    _StoreShowImageThree.sd_layout.leftSpaceToView(_StoreShowImageTwo, kFit(3)).topSpaceToView(self.StoreImage, 17.5).widthIs(imageWidth).heightIs(kFit(115));
    
    UILabel *TransparentBackgroundLabelTherr = [UILabel new];
    TransparentBackgroundLabelTherr.alpha = 0.7;
    TransparentBackgroundLabelTherr.backgroundColor = [UIColor whiteColor];
    [_StoreShowImageThree addSubview:TransparentBackgroundLabelTherr];
    TransparentBackgroundLabelTherr.sd_layout.leftSpaceToView(_StoreShowImageThree, 0).bottomSpaceToView(_StoreShowImageThree, 0).heightIs(kFit(15)).rightSpaceToView(_StoreShowImageThree, 0);
    
    self.StoreNameThree = [UILabel new];
    _StoreNameThree.font = MFont(kFit(15));
    _StoreNameThree.textAlignment = 1;
    [_StoreShowImageThree addSubview:_StoreNameThree];
    _StoreNameThree.sd_layout.leftSpaceToView(_StoreShowImageThree, 0).bottomSpaceToView(_StoreShowImageThree, 0).heightIs(kFit(15)).rightSpaceToView(_StoreShowImageThree, 0);
}

- (void)handleEntranceStoreBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(EnterVendor:)]) {
        [_delegate EnterVendor:sender];
    }
}

- (void)handleNavigationBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(navigationToShop:)]) {
        [_delegate navigationToShop:sender];
    }

}
- (CGFloat)getWidthWithTitle:(NSString *)title font:(CGFloat)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = MFont(kFit(font));
    [label sizeToFit];
    return label.frame.size.width;
}

-(void)setModel:(FactoryDataModel *)model {
//[self.StoreImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kSHY_100, model.storeLogo] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]]
    _StoreNameLable.text = [NSString stringWithFormat:@"厂家名字:%@", model.factoryName];
    _SalesLable.text = [NSString stringWithFormat:@"联系电话:%@", model.factoryTel];
    NSArray *storeArray = (NSArray *)model.listStore;
    SellerDataModel *model0 = storeArray[0];
    [_StoreShowImageOne sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model0.storeLogo] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    _StoreNameOne.text = model0.storeName;
    SellerDataModel *model1 = storeArray[1];
    [_StoreShowImageTwo sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model1.storeLogo] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    _StoreNameTwo.text = model1.storeName;
    SellerDataModel *model2 = storeArray[2];
    [_StoreShowImageThree sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model2.storeLogo] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    _StoreNameThree.text = model2.storeName;
    
}

@end
