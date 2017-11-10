
//
//  SetUpPictureT|VCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SetUpPictureTVCell.h"

@interface SetUpPictureTVCell ()

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *userImage;

@end

@implementation SetUpPictureTVCell

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
    }
    return _nameLabel;
}
- (UIImageView *)userImage {
    if (!_userImage) {
        _userImage = [UIImageView new];
        _userImage.layer.cornerRadius = kFit(50) /2 ;
        _userImage.layer.masksToBounds = YES;
    }
    return _userImage;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel.text = @"头像";
        _nameLabel.textColor = MColor(51, 51, 51);
        _nameLabel.font = MFont(kFit(15));
        [self.contentView addSubview:_nameLabel];
        _nameLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).widthIs(kFit(100)).heightIs(kFit(14)).centerYEqualToView(self.contentView);
        
        UIButton *arrowBtn   = [UIButton new];
        [arrowBtn setImage:[UIImage imageNamed:@"qbddjt"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:arrowBtn];
        arrowBtn.sd_layout.rightSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(36);

        self.userImage.image = [UIImage imageNamed:@"zly"];
        [self.contentView addSubview:_userImage];
        _userImage.sd_layout.rightSpaceToView(arrowBtn, 0).widthIs(kFit(50)).heightIs(kFit(50)).centerYEqualToView(self.contentView);
        
        UILabel *segmentationlabel = [UILabel new];
        segmentationlabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationlabel];
        segmentationlabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
    }
    return self;
}
- (void)userHeadPortrait:(NSString *)image {
    [_userImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL,image] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
}
@end
