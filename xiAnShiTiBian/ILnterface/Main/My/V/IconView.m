//
//  IconView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "IconView.h"

@implementation IconView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImage = [[UIImageView alloc] init];
        
        [self addSubview:self.iconImage];
        _iconImage.sd_layout.leftSpaceToView(self, kFit(10)).rightSpaceToView(self, kFit(10)).topSpaceToView(self, kFit(10)).autoHeightRatio(1.0);

        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textAlignment = 1;
        self.nameLabel.font = [UIFont systemFontOfSize:kFit(11)];
        [self addSubview:self.nameLabel];
        _nameLabel.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self.iconImage, kFit(5)).rightSpaceToView(self, 0).heightIs(kFit(10));
        UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)handleTap:(IconView *)tap {
    
    if ([_delegate respondsToSelector:@selector(FunctionChoose:)]) {
        [_delegate FunctionChoose:self];
    }
    
}
@end
