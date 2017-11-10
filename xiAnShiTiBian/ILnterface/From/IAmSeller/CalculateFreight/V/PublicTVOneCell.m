//
//  PublicTVOneCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "PublicTVOneCell.h"

@implementation PublicTVOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *middleLabel = [UILabel new];
        middleLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:middleLabel];
        middleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
        
        self.titleBtn = [UIButton new];
        [self.contentView addSubview:_titleBtn];
        _titleBtn.sd_layout.leftSpaceToView(self.contentView, kFit(5)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(40));
        
        self.tItleLabel = [UILabel new];
        _tItleLabel.textColor = MColor(51, 51, 51);
        _tItleLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_tItleLabel];
        _tItleLabel.sd_layout.leftSpaceToView(_titleBtn, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(60));
        
        self.contentLabel = [UILabel new];
        _contentLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_contentLabel];
        _contentLabel.sd_layout.leftSpaceToView (_tItleLabel, kFit(5)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0);
    }
    return self;
}

- (void)CellControlsAssignment:(NSIndexPath *)indexPath content:(NSString *)content{
    NSArray *titleArray = @[@[@"origin", @"始发地"], @[@"endPoint", @"目的地"], @[@"SelectModelsTwo", @"选择车型"], @[@"EstimateMoney", @"预估价钱"]];
    UIImage *titleImage = [UIImage imageNamed:titleArray[indexPath.row][0]];
    titleImage = [titleImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_titleBtn setImage:titleImage forState:(UIControlStateNormal)];
    
    _tItleLabel.text = titleArray[indexPath.row][1];
    _contentLabel.text = content;
    if (indexPath.row == 2 || indexPath.row == 3) {
    _contentLabel.textColor = MColor(255, 51, 51);
    }
}
@end
