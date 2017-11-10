//
//  SmallTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "SmallTVCell.h"

@interface SmallTVCell ()
@property (nonatomic, strong)UILabel *  titleLabel;
@property (nonatomic, strong)UILabel *  DefaultState;
@property (nonatomic, strong)UIButton * arrowBtn;
@end

@implementation SmallTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel   = [UILabel new];
        _titleLabel.text  = @"税收";
        _titleLabel.textColor =MColor(51, 51, 51);
        _titleLabel.font  = MFont(kFit(15));
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(17.5)).widthIs(kFit(120)).heightIs(kFit(15));
        
        self.arrowBtn   = [UIButton new];
        _arrowBtn.userInteractionEnabled = NO;
        [_arrowBtn setImage:[UIImage imageNamed:@"xzz"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:_arrowBtn];
        _arrowBtn.sd_layout.rightSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(36);
        
        self.DefaultState = [UILabel new];
        _DefaultState.text= @"含税";
        _DefaultState.font = MFont(kFit(14));
        _DefaultState.textAlignment =2;
        _DefaultState.textColor = MColor(134, 134, 134);
        [self.contentView addSubview:_DefaultState];
        _DefaultState.sd_layout.rightSpaceToView(_arrowBtn, kFit(0)).topSpaceToView(self.contentView, kFit(18)).heightIs(kFit(14)).widthIs(kFit(120));
        
        UILabel *segmentationlabel = [UILabel new];
        segmentationlabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationlabel];
        segmentationlabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));

    }
    return self;

}
- (void)titlLabel:(NSString *)title DefaultLabel:(NSString *)Default {

    _titleLabel.text = title;
    _DefaultState.text = Default;

}
@end
