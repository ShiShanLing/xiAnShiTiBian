//
//  BuyPatternsTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "BuyPatternsTVCell.h"

@implementation BuyPatternsTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"匿名购买";
        titleLabel.textColor =MColor(51, 51, 51);
        titleLabel.font  = MFont(kFit(15));
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(17.5)).widthIs(kFit(80)).heightIs(kFit(15));
        
        UISwitch *chooseSwitch  = [UISwitch new];
        BOOL setting =  chooseSwitch.isOn;
        [chooseSwitch setOn:setting animated:YES];
        chooseSwitch.onTintColor = kNavigation_Color;
        chooseSwitch.tintColor = MColor(210, 210, 210);
        [chooseSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:chooseSwitch];
        chooseSwitch.sd_layout.rightSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(12)).widthIs(kFit(47)).heightIs(kFit(25));
        
        UILabel *segmentationlabel = [UILabel new];
        segmentationlabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationlabel];
        segmentationlabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
    }
    return self;
}

- (void)switchAction:(UISwitch *)sw {



}

@end
