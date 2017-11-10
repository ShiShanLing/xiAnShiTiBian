//
//  VendorEngineeringCVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/27.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "VendorEngineeringCVCell.h"

@interface VendorEngineeringCVCell ()

@property (nonatomic, strong) UIImageView *goodsImage;

@end

@implementation VendorEngineeringCVCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = MColor(238, 238, 238);
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
        self.goodsImage = [[UIImageView alloc]init];
        self.goodsImage.image = [UIImage imageNamed:@"zly"];
        
        [self addSubview:self.goodsImage];
        _goodsImage.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);

    }
    return self;
}


@end
