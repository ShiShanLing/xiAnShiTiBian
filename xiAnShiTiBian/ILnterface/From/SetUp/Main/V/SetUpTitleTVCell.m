//
//  SetUpTitleTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "SetUpTitleTVCell.h"

@implementation SetUpTitleTVCell

- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [UIImageView new];
    }
    return _headImage;
}
- (UILabel *)headLabel {
    if (!_headLabel) {
        _headLabel = [UILabel new];
    }
    return _headLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = MColor(238, 238, 238);
        self.headImage.image = [UIImage imageNamed:@"sz-grzl"];
        [self.contentView addSubview:self.headImage];
        _headImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).widthIs(kFit(24)).heightIs(kFit(24)).centerYEqualToView(self.contentView);
        
        self.headLabel.textColor = MColor(51, 51, 51);
        _headLabel.text = @"个人资料";
        _headLabel.font = MFont(kFit(15));
        [self.contentView addSubview:self.headLabel];
        _headLabel.sd_layout.leftSpaceToView(_headImage, kFit(10)).widthIs(kFit(100)).heightIs(kFit(24)).centerYEqualToView(self.contentView);
        
       

    }
    return self;
    
}

- (void)titleLabel:(NSString *)title headImage:(NSString *)image {
    _headImage.image = [UIImage imageNamed:image];
    _headLabel.text = title;

}
@end
