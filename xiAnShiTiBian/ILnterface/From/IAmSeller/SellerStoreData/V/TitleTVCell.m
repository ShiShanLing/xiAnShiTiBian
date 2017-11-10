//
//  TitleTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "TitleTVCell.h"

@interface TitleTVCell ()
//店铺头像
@property (nonatomic, strong)UIImageView *storeImage;
//店铺名称
@property (nonatomic, strong)UILabel *storeNameLabel;
//店铺等级
@property (nonatomic, strong)UIButton *levelBtn;
//开店时间
@property (nonatomic, strong)UILabel *openTimeLabel;

@end

@implementation TitleTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.storeImage = [UIImageView new];
        _storeImage.image = [UIImage imageNamed:@"zly"];
        _storeImage.layer.cornerRadius = 3;
        _storeImage.layer.masksToBounds = YES;
        _storeImage.userInteractionEnabled = YES;
        [self.contentView addSubview:_storeImage];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
        [_storeImage addGestureRecognizer:tap];
        _storeImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).centerYEqualToView(self.contentView).widthIs(kFit(53)).heightIs(kFit(53));
        
        UILabel *backgroundLabel = [UILabel new];
        backgroundLabel.backgroundColor = [UIColor blackColor];
        backgroundLabel.alpha = 0.7;
        [_storeImage addSubview:backgroundLabel];
        backgroundLabel.sd_layout.leftSpaceToView(_storeImage, 0).rightSpaceToView(_storeImage, 0).heightIs(kFit(11)).bottomSpaceToView(_storeImage, 0);
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textAlignment = 1;
        titleLabel.text = @"更换图片";
        titleLabel.font = MFont(kFit(8));
        titleLabel.textColor = MColor(255, 255, 255);
      //  [_storeImage addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(_storeImage, 0).rightSpaceToView(_storeImage, 0).bottomSpaceToView(_storeImage, 0).heightIs(kFit(11));
        
        self.storeNameLabel = [UILabel new];
        _storeNameLabel.text = @"";
        _storeNameLabel.textColor = MColor(51, 51, 51);
        _storeNameLabel.font = MFont(kFit(17));
        [self.contentView addSubview:_storeNameLabel];
      CGFloat width = [self getWidthWithTitle:@"鳄鱼牌沙发专卖店" font:MFont(kFit(17))];
        _storeNameLabel.sd_layout.leftSpaceToView(_storeImage, kFit(10)).topSpaceToView(self.contentView, kFit(16)).widthIs(width).heightIs(kFit(17));
        
        self.levelBtn = [UIButton new];
        UIImage *levelImage = [UIImage imageNamed:@""];
        levelImage = [levelImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_levelBtn setImage:levelImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:_levelBtn];
        _levelBtn.sd_layout.leftSpaceToView(_storeNameLabel, 0).widthIs(kFit(30)).heightIs(kFit(30)).topSpaceToView(self.contentView,kFit(10));
        
        self.openTimeLabel = [UILabel new];
        _openTimeLabel.text = @"开店时间:";
        _openTimeLabel.textColor = MColor(134, 134, 134);
        _openTimeLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_openTimeLabel];
        _openTimeLabel.sd_layout.leftSpaceToView(_storeImage, kFit(10)).topSpaceToView(_storeNameLabel, kFit(10)).heightIs(kFit(14)).rightSpaceToView(self.contentView, kFit(12));
    }
    return self;
}
- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

- (void)handleTap {
    if ([_delegate respondsToSelector:@selector(PictureEditing)]) {
        [_delegate PictureEditing];
    }
}

-(void)setModel:(SellerDataModel *)model {
    [_storeImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.storeLogo] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    
    CGFloat width = [self getWidthWithTitle:model.storeName font:MFont(kFit(17))];
    _storeNameLabel.sd_layout.leftSpaceToView(_storeImage, kFit(10)).topSpaceToView(self.contentView, kFit(16)).widthIs(width).heightIs(kFit(17));
    
    _storeNameLabel.text = model.storeName;
    _openTimeLabel.text = [NSString stringWithFormat:@"开店时间:%@", model.createTimeStr];
    

}

@end
