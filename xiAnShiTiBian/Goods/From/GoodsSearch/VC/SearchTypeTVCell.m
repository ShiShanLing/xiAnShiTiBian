//
//  SearchTypeTVCell.m
//  模仿QQ下拉菜单
//
//  Created by 石山岭 on 2016/12/28.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "SearchTypeTVCell.h"

@interface SearchTypeTVCell ()

@property (nonatomic, strong)UIButton *titleImage;
@property (nonatomic, strong)UILabel *titleLabel;
@end

@implementation SearchTypeTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = MColor(73, 72, 75);
        self.titleImage = [UIButton new];
        [_titleImage setImage:[UIImage imageNamed:@"dianpu"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:_titleImage];
        _titleImage.sd_layout.leftSpaceToView(self.contentView, kFit(7)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(49));
        
        self.titleLabel = [UILabel new];
        self.titleLabel.text =  @"店铺";
        _titleLabel.textColor = MColor(238, 238, 238);
        _titleLabel.font = MFont(kFit(15));
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(_titleImage, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0);
        
        UILabel *segmentationLabel = [UILabel new];
        segmentationLabel.backgroundColor = MColor(91, 91, 93);
        [self.contentView addSubview:segmentationLabel];
        segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, 0).heightIs(0.5);

        
    }
    return self;

}
- (void)titleImage:(UIImage *)image  titleStr:(NSString *)str {
[_titleImage setImage:image forState:(UIControlStateNormal)];
 self.titleLabel.text =  str;
}

@end
