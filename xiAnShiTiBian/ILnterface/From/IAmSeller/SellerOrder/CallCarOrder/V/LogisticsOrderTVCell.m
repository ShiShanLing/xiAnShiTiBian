//
//  LogisticsOrderTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "LogisticsOrderTVCell.h"

@interface LogisticsOrderTVCell ()

@property (nonatomic, strong)UIButton * iconBtn;
@property (nonatomic, strong)UILabel  * titleLabel;
@property (nonatomic, strong)UILabel  * contentLabel;

@end

@implementation LogisticsOrderTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iconBtn = [UIButton new];
        UIImage *iconImage = [UIImage imageNamed:@"CCstartLocation"];
        iconImage = [iconImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_iconBtn setImage:iconImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:_iconBtn];
        _iconBtn.sd_layout.leftSpaceToView(self.contentView, kFit(6)).topSpaceToView(self.contentView, 0).widthIs(kFit(39)).bottomSpaceToView(self.contentView, kFit(0));
        
        self.titleLabel = [UILabel new];
        _titleLabel.text = @"";
        _titleLabel.textColor = MColor(51, 51, 51);
        _titleLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(_iconBtn, kFit(0)).topSpaceToView(self.contentView, 0).widthIs(kFit(70)).bottomSpaceToView(self.contentView, kFit(0));
        
        self.contentLabel = [UILabel new];
        _contentLabel.text = @"";
        _contentLabel.font = MFont(kFit(14));
        _contentLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_contentLabel];
        _contentLabel.sd_layout.leftSpaceToView(_titleLabel, kFit(0)).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(12)).bottomSpaceToView(self.contentView, kFit(0));
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, kFit(0)).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
    }
    return self;
}

- (void)controlsAssignment:(int)row dataArray:(NSArray *)DataArray{
   // NSLog(@"----%@", DataArray);
    UIImage *iconImage = [UIImage imageNamed:DataArray[0][row]];
    iconImage = [iconImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [_iconBtn setImage:iconImage forState:(UIControlStateNormal)];
    _titleLabel.text = DataArray[1][row];
    _contentLabel.text = DataArray[2][row];
    
}

@end
