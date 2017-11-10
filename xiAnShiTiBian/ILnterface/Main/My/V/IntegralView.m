//
//  IntegralView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "IntegralView.h"

@implementation IntegralView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"my_top_points_bg"];
        UIImageView *IMAGE = [[UIImageView alloc] init];//图标
        IMAGE.image = [UIImage imageNamed:@"points"];
        [self addSubview:IMAGE];
        IMAGE.sd_layout.leftSpaceToView(self, kFit(5)).topSpaceToView(self, kFit(0)).widthIs(kFit(20)).bottomSpaceToView(self, kFit(0));
        UILabel *label = [[UILabel alloc] init];//积分
        label.text = @"积分";
        label.font = MFont(kFit(12));
        label.textAlignment = 1;
        label.textColor = [UIColor colorWithRed:255/256.0 green:86/256.0 blue:0/256.0 alpha:1];
        [self addSubview:label];
        label.sd_layout.leftSpaceToView(IMAGE, kFit(3)).topSpaceToView(self, kFit(2)).bottomSpaceToView(self, kFit(2)).widthIs(kFit(30));
        UIImageView *segmentationImage = [[UIImageView alloc] init];//分割线
        segmentationImage.image = [UIImage imageNamed:@"vertical_line"];
        [self addSubview:segmentationImage];
        segmentationImage.sd_layout.leftSpaceToView(label, 3).topSpaceToView(self, 2).bottomSpaceToView(self, 2).widthIs(1);
        
        self.IntegralNumber = [UILabel new];
        self.IntegralNumber.textAlignment = 1;
        self.IntegralNumber.text = @"0";
        _IntegralNumber.font = MFont(kFit(12));
        self.IntegralNumber.textColor =[UIColor colorWithRed:255/256.0 green:86/256.0 blue:0/256.0 alpha:1];
        [self addSubview:self.IntegralNumber];
        self.IntegralNumber.sd_layout.leftSpaceToView(segmentationImage, 3).topSpaceToView(self, 3).rightSpaceToView(self, 3).bottomSpaceToView(self, 3);
        
        
    }
    return self;

}
@end
