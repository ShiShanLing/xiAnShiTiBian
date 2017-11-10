//
//  COSNTableViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "COSNTableViewCell.h"

@implementation COSNTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *grayLabel = [UILabel new];//商家上方灰色部分
        grayLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:grayLabel];
        grayLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(10));

        UIButton *iconBtn = [UIButton new];
        UIImage *iconImage = [UIImage imageNamed:@"dp"];
        iconImage = [iconImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [iconBtn setImage:iconImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:iconBtn];
        iconBtn.sd_layout.leftSpaceToView(self.contentView,kFit(12)).topSpaceToView(grayLabel, 0).widthIs(kFit(24)).bottomSpaceToView(self.contentView, 0);
        
        self.stopName = [UILabel new];
        _stopName.text = @"西安建材专业贩卖机构";
        _stopName.font = MFont(kFit(17));
        _stopName.textColor = MColor( 51, 51, 51);
        [self.contentView addSubview:_stopName];
        _stopName.sd_layout.leftSpaceToView(iconBtn, kFit(12)).topSpaceToView(grayLabel, kFit(17)).widthIs(kFit(200)).heightIs(kFit(17));
        //这两个参数暂时没用隐藏掉
//        self.stopPhone = [UILabel new];
//        _stopPhone.text = @"13673387452";
//        _stopPhone.textAlignment = 2;
//        _stopPhone.textColor = MColor(182, 182, 182);
//        _stopPhone.font = MFont(kFit(12));
//        [self.contentView addSubview:_stopPhone];
//        _stopPhone.sd_layout.leftSpaceToView(_stopName, kFit(15)).rightSpaceToView(self.contentView, kFit(15)).topSpaceToView(grayLabel, kFit(22)).heightIs(kFit(12));
//        
//        self.stopAddress = [UILabel new];
//        _stopAddress.text = @"杭州市滨江区西兴地铁站燕语林森公寓4栋二单元603";
//        _stopAddress.textColor = MColor(161, 161, 161);
//        _stopAddress.font = MFont(kFit(12));
//        [self.contentView addSubview:_stopAddress];
//        _stopAddress.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(_stopName, kFit(10)).rightSpaceToView(self.contentView, kFit(15)).heightIs(kFit(12));
        
        UILabel *segmentationlabel = [UILabel new];
        segmentationlabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationlabel];
        segmentationlabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, kFit(12)).heightIs(kFit(0.5));
        
    }
    return self;
}
@end
