//
//  StoreScoreView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/2.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "StoreScoreView.h"

@implementation StoreScoreView

-(instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
        
        
        self.levelLabel = [UILabel new];
        self.levelLabel.textColor = kDark;
        self.levelLabel.backgroundColor = kNavigation_Color;
        self.levelLabel.layer.cornerRadius = 3;
        self.levelLabel.font = MFont(kFit(13));
        self.levelLabel.layer.masksToBounds = YES;
        self.levelLabel.textAlignment = 1;
        [self addSubview:self.levelLabel];
        self.levelLabel.sd_layout.rightSpaceToView(self, 5).topSpaceToView(self, 3).widthIs(15).bottomSpaceToView(self, 3).autoHeightRatio(1.0);
        
        self.scoreLabel = [UILabel new];
        self.scoreLabel.textAlignment = 1;
        self.scoreLabel.font = MFont(kFit(12));
        self.scoreLabel.textColor = kNavigation_Color;
        [self addSubview:self.scoreLabel];
        self.scoreLabel.sd_layout.rightSpaceToView(self.levelLabel, 5).widthIs(25).bottomSpaceToView(self, 3).topSpaceToView(self, 3);

        self.typeLabel = [UILabel new];
        self.typeLabel.textColor = kDark;
        
        self.typeLabel.textAlignment = 2;
        [self addSubview:self.typeLabel];
        self.typeLabel.sd_layout.rightSpaceToView(self.scoreLabel, 5).topSpaceToView(self, 5).widthIs(70).bottomSpaceToView(self, 5);

        
    }
    return self;
}

@end
