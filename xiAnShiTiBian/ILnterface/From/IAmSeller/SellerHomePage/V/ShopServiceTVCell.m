//
//  ShopServiceTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShopServiceTVCell.h"

@interface ShopServiceTVCell ()

@property (nonatomic, strong)UIButton *iconBtn;
@property (nonatomic, strong)UILabel *titleLabel;
/**
 *为了实现UI给的效果所以判断这条线在前两个cell(2和3)上出现最后一个cell(4)不出现
 */
@property (nonatomic, strong)UILabel *bottomLabel;

@end

@implementation ShopServiceTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.iconBtn = [UIButton new];
        [self.contentView addSubview:self.iconBtn];
        self.iconBtn.sd_layout.leftSpaceToView(self.contentView, kFit(15)).topSpaceToView(self.contentView, kFit(10)).bottomSpaceToView(self.contentView, kFit(10)).widthEqualToHeight();
        self.titleLabel = [UILabel new];
        _titleLabel.textColor = MColor(51, 51, 51);
        _titleLabel.font = MFont(kFit(12));
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.sd_layout.leftSpaceToView(self.iconBtn, kFit(15)).topSpaceToView(self.contentView, kFit(15)).bottomSpaceToView(self.contentView, kFit(15)).rightSpaceToView(self.contentView, kFit(15));
        
        self.bottomLabel = [UILabel new];
        _bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:_bottomLabel];
        _bottomLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(0.5));
        
    
    }
    return self;
}
- (void)ControlsAssignment:(NSArray *)array indexPath:(NSIndexPath *)indexPath{
    
    UIImage *iconImage = [UIImage imageNamed:array[0]];
    iconImage = [iconImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [_iconBtn setImage:iconImage forState:(UIControlStateNormal)];
    self.titleLabel.text = array[1];

    if (indexPath.row == 5) {
        _bottomLabel.backgroundColor = [UIColor whiteColor];
    }
}
@end
