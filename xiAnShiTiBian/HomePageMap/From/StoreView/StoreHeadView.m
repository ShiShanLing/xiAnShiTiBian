//
//  StoreHeadView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/2.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "StoreHeadView.h"

@implementation StoreHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.storeImage = [UIImageView new];
        self.storeImage.image = [UIImage imageNamed:@"dianpubg"];
        [self addSubview:self.storeImage];
        self.storeImage.sd_layout.rightSpaceToView(self, 0).leftSpaceToView(self, 0).topSpaceToView(self, 0).heightIs(150);
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor blackColor];
        label.alpha = 0.45;
        [self.storeImage addSubview:label];
        label.sd_layout.rightSpaceToView(self.storeImage, 0).leftSpaceToView(self.storeImage, 0).topSpaceToView(self.storeImage, 0).bottomSpaceToView(self.storeImage, 0);
        
        self.userImage = [UIImageView new];
        self.userImage.image = [UIImage imageNamed:@""];
        self.userImage.layer.cornerRadius = 3;
        self.userImage.layer.masksToBounds = YES;
        [self.storeImage addSubview:self.userImage];
        self.userImage.sd_layout.leftSpaceToView(self.storeImage,24).bottomSpaceToView(self.storeImage, 17).widthIs(53).autoHeightRatio(1.0);
        
        self.nameLabel = [UILabel new];
        self.nameLabel.text = @"";
        self.nameLabel.textColor = [UIColor colorWithRed:255/256.0 green:255/256.0 blue:255/256.0 alpha:1];
        self.nameLabel.textAlignment = 1;
        [self.storeImage addSubview:self.nameLabel];
        self.nameLabel.sd_layout.leftSpaceToView(self.userImage, 15).bottomSpaceToView(self.storeImage, 44).widthIs(100).heightIs(20);
        
        self.evaluationImage = [UIImageView new];
       // self.evaluationImage.image = [UIImage imageNamed:@"3"];
        [self.storeImage addSubview:self.evaluationImage];
        self.evaluationImage.sd_layout.leftSpaceToView(self.nameLabel, 5).widthIs(22).heightIs(15).bottomSpaceToView(self.storeImage, 44);
        
        self.credibilityView = [StoreScoreView new];
        self.credibilityView.typeLabel.text = @"商家信誉";
        self.credibilityView.scoreLabel.text = @"9.9";
        self.credibilityView.levelLabel.text = @"高";
       // [self.storeImage addSubview:self.credibilityView];
        self.credibilityView.sd_layout.widthIs(200).bottomSpaceToView(self.storeImage, 17).rightSpaceToView(self.storeImage, 10).heightIs(21);
        self.credibilityView2 = [StoreScoreView new];
        self.credibilityView2.typeLabel.text = @"商家服务";
        self.credibilityView2.scoreLabel.text = @"9.9";
        self.credibilityView2.levelLabel.text = @"高";
     //   [self.storeImage addSubview:self.credibilityView2];
        self.credibilityView2.sd_layout.widthIs(200).bottomSpaceToView(self.credibilityView, 10).rightSpaceToView(self.storeImage, 10).heightIs(21);
        self.credibilityView3 = [StoreScoreView new];
        self.credibilityView3.typeLabel.text = @"商品描述";
        self.credibilityView3.scoreLabel.text = @"9.9";
        self.credibilityView3.levelLabel.text = @"高";
      //  [self.storeImage addSubview:self.credibilityView3];
        self.credibilityView3.sd_layout.widthIs(200).bottomSpaceToView(self.credibilityView2, 10).rightSpaceToView(self.storeImage, 10).heightIs(21);
        
    }
    return self;
}

-(void)setModel:(StoreRankingListModel *)model {
    //storeCredit 信誉  praiseRate评论
    [_storeImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.storeBanner] placeholderImage:[UIImage imageNamed:@"dianpubg"]];
    [_userImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL,model.storeLogo] placeholderImage:[UIImage imageNamed:@"zly"]];
    _nameLabel.text = model.storeName;
    //_evaluationImage.image = [UIImage imageNamed:@"vip8"];
}

@end
