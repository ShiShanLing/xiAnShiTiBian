//
//  TitleCViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/1.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "TitleCViewCell.h"

@implementation TitleCViewCell
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleImage = [UIImageView new];
        self.titleImage.image = [UIImage imageNamed:@"bann"];
        [self.contentView addSubview:self.titleImage];
        self.titleImage.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).widthIs(kScreen_widht).autoHeightRatio(0.53333);
    }
    return self;
}

@end
