
//
//  ColorTypeTableViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/10.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ColorTypeTableViewCell.h"

@implementation ColorTypeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    
        
        self.colorLabel = [UILabel new];
        _colorLabel.text = @"选择 :";
        _colorLabel.textColor = MColor(51, 51, 51);
        _colorLabel.font = MFont(kFit(15));
        [self.contentView addSubview:_colorLabel];
        _colorLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 5).widthIs(kFit(40));
        
        self.typeLabel  = [UILabel new];
        _typeLabel.textColor = MColor(134, 134, 134);
        _typeLabel.font = MFont(kFit(14));
        _typeLabel.text = @"颜色 规格";
        [self.contentView addSubview:self.typeLabel];
        _typeLabel.sd_layout.leftSpaceToView(self.colorLabel, kFit(12)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, kFit(35));
        UIButton *btn= [UIButton new];
        [btn setImage: [UIImage imageNamed:@"xzz"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:btn];
        btn.sd_layout.leftSpaceToView(self.typeLabel, kFit(12)).topSpaceToView(self.contentView, 0).widthIs(kFit(10)).bottomSpaceToView(self.contentView, 5).rightSpaceToView(self.contentView, kFit(12));
        
        UILabel *segmentationLabel = [UILabel new];
        segmentationLabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationLabel];
        segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, 0).heightIs(0.5);
    }
    return self;

}
@end
