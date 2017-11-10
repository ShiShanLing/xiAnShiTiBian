//
//  ForecastPriceTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ForecastPriceTVCell.h"

@implementation ForecastPriceTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)   reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.ForecastPriceBtn = [UIButton new];
        _ForecastPriceBtn.titleLabel.font =MFont(kFit(17));
        _ForecastPriceBtn.layer.cornerRadius = 5;
        _ForecastPriceBtn.layer.masksToBounds = YES;
        [_ForecastPriceBtn setTitle:@"预估" forState:(UIControlStateNormal)];
        [_ForecastPriceBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        _ForecastPriceBtn.backgroundColor = MColor(255, 255, 255);
        _ForecastPriceBtn.userInteractionEnabled = NO;
        
        [self.contentView addSubview:_ForecastPriceBtn];
        _ForecastPriceBtn.sd_layout.centerXEqualToView(self.contentView).widthIs(kFit(300)).topSpaceToView(self.contentView,kFit(20)).heightIs(kFit(50));
        
    }
    return self;
}

@end
