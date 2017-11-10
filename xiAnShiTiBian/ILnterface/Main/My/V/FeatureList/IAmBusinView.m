//
//

//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/30.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "IAmBusinView.h"

@implementation IAmBusinView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.iconImage = [UIImageView new];
        [self addSubview:self.iconImage];
        self.iconImage.sd_layout.leftSpaceToView(self, kFit(15)).topSpaceToView(self, kFit(10)).bottomSpaceToView(self, kFit(10)).widthEqualToHeight();

        self.titleLabel = [UILabel new];
        _titleLabel.font = MFont(kFit(14));
        _titleLabel.textColor = MColor(51, 51, 51);
        [self addSubview:self.titleLabel];
        
        self.titleLabel.sd_layout.leftSpaceToView(self.iconImage, kFit(15)).topSpaceToView(self, kFit(15)).bottomSpaceToView(self, kFit(15)).rightSpaceToView(self, kFit(15));
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
        }
    return self;
}
-(void)handleTap:(UITapGestureRecognizer *)tap {

    if ([_delegate respondsToSelector:@selector(managementClick:)]) {
        [_delegate managementClick:self];
    }

}

@end
