//
//  ToolTitleView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ToolTitleView.h"

@implementation ToolTitleView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:self.titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, 15).widthIs(100).bottomSpaceToView(self, 15);
        
        _iconImage = [[UIImageView alloc] init];
        [self addSubview:self.iconImage];
        _iconImage.sd_layout.rightSpaceToView(self, 15).topSpaceToView(self, 15).bottomSpaceToView(self, 15).widthIs(12);
        
        self.functionLabel = [[UILabel alloc] init];
        _functionLabel.font =[UIFont systemFontOfSize:13];
        _functionLabel.textAlignment = 2;
        [self addSubview:_functionLabel];
        _functionLabel.sd_layout.leftSpaceToView(_titleLabel, 20).topSpaceToView(self, 15).bottomSpaceToView(self, 15).rightSpaceToView(self.iconImage, 15);
        
    }
    return self;
    
}

@end
