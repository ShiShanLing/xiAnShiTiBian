//
//  VendorIntroduceTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "VendorIntroduceTVCell.h"

@interface VendorIntroduceTVCell()

@property (nonatomic, strong)UIImageView *backdropImage;
@property (nonatomic, strong)UIImageView *titleImage;
@property (nonatomic, strong)UILabel *VendorNameLabel;
@property (nonatomic, strong)UILabel *VendorPhoneLabel;
@property (nonatomic, strong)UILabel *addressLabel;

@property (nonatomic, strong)UILabel *VendorProfileLabel;

@end

@implementation VendorIntroduceTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backdropImage = [UIImageView new];
        _backdropImage.image = [UIImage imageNamed:@"beijingtu"];
        [self.contentView addSubview:_backdropImage];
        _backdropImage.sd_layout.leftSpaceToView(self.contentView , 0).topSpaceToView(self.contentView,0).rightSpaceToView(self.contentView, 0).heightIs(kFit(150));
        
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor blackColor];
        label.alpha = 0.45;
        [self.backdropImage addSubview:label];
        label.sd_layout.rightSpaceToView(self.backdropImage, 0).leftSpaceToView(self.backdropImage, 0).topSpaceToView(self.backdropImage, 0).bottomSpaceToView(self.backdropImage, 0);

        
        self.titleImage = [UIImageView new];
        self.titleImage.image = [UIImage imageNamed:@"zly"];
        [self.backdropImage addSubview:self.titleImage];
        _titleImage.sd_layout.leftSpaceToView(self.backdropImage , kFit(12)).bottomSpaceToView(self.backdropImage,kFit(17.5)).widthIs(kFit(53)).autoHeightRatio(1);
        
        
        self.addressLabel = [UILabel new];
        _addressLabel.text = @"地址 : 浙江大学第一医学院西兴分院";
        
        _addressLabel.textColor = MColor(188, 188, 188);
        _addressLabel.font= MFont(kFit(12));
        [self.backdropImage addSubview:_addressLabel];
        _addressLabel.sd_layout.leftSpaceToView(_titleImage, kFit(17.5)).bottomEqualToView(_titleImage).rightSpaceToView(_backdropImage, kFit(15)).heightIs(kFit(12));
        
        self.VendorPhoneLabel = [UILabel new];
        _VendorPhoneLabel.font = MFont(kFit(12));
        _VendorPhoneLabel.textColor = MColor(188, 188, 188);
        _VendorPhoneLabel.text = @"电话 : 13673387452";
        [self.backdropImage addSubview:_VendorPhoneLabel];
        _VendorPhoneLabel.sd_layout.leftSpaceToView(_titleImage, kFit(17.5)).bottomSpaceToView(_addressLabel, kFit(5)).heightIs(kFit(12)).rightSpaceToView(_backdropImage, kFit(15));
        
        
        self.VendorNameLabel = [UILabel new];
        self.VendorNameLabel.text = @"海澜之家";
        self.VendorNameLabel.font = MFont(kFit(15));
        _VendorNameLabel.textColor = MColor(255, 255, 255);
        [self.backdropImage addSubview:_VendorNameLabel];
        _VendorNameLabel.sd_layout.leftEqualToView(_addressLabel).bottomSpaceToView(_VendorPhoneLabel, kFit(15)).heightIs(kFit(15));
       
        UILabel *titleLabel1 = [UILabel new];
        titleLabel1.text = @"厂家简介 :";
        titleLabel1.textColor = MColor(51, 51, 51);
        titleLabel1.font = MFont(kFit(15));
        [self.contentView addSubview:titleLabel1];
        titleLabel1.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(_backdropImage, kFit(17.5)).widthIs(kFit(70)).heightIs(kFit(15));
        
        self.VendorProfileLabel =[UILabel new];//这个需要自适应高度
        _VendorProfileLabel.textColor = MColor(134, 134, 134);
        _VendorProfileLabel.font = MFont(kFit(15));
        _VendorProfileLabel.numberOfLines = 0;
        _VendorProfileLabel.text = @"";
        CGFloat height = [self getHeightByWidth:kScreen_widht - kFit(135) title:@"世界男人的衣橱, 世界男人的衣橱, 世界男人的衣橱, 世界男人的衣橱, 世界男人的衣橱" font:MFont(kFit(15))];
        [self.contentView addSubview:_VendorProfileLabel];
        _VendorProfileLabel.sd_layout.leftSpaceToView(titleLabel1, kFit(10)).topEqualToView(titleLabel1).rightSpaceToView(self.contentView, kFit(15)).heightIs(height);
        
    }
    return self;

}

- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

- (void)setModel:(FactoryDataModel *)model {
    _addressLabel.text = [NSString stringWithFormat:@"厂家地址:%@ %@", model.factoryAddress, model.factoryDescription];
    _VendorPhoneLabel.text = [NSString stringWithFormat:@"电话 : %@", model.factoryTel];
    _VendorNameLabel.text = model.factoryName;
    if ([model.factoryType length] == 0) {
        _VendorProfileLabel.text = [NSString stringWithFormat:@"厂家很懒什么都没有留下!"];
    }else {
        _VendorProfileLabel.text = [NSString stringWithFormat:@"店铺简介:%@",model.factoryType];
    }
  
}

@end
