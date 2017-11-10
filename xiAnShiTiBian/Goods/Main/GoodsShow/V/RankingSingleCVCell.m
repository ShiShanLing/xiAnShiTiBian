//
//  RankingSingleCVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/27.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "RankingSingleCVCell.h"

@interface RankingSingleCVCell ()

@property (nonatomic, strong)UILabel *numLabel;

@end

@implementation RankingSingleCVCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.storeImage = [UIImageView new];
        _storeImage.image = [UIImage imageNamed:@"zly"];
        _storeImage.layer.cornerRadius = 3;
        _storeImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_storeImage];
        _storeImage.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
        
        UILabel *lucencyLabel = [UILabel new];
        lucencyLabel.backgroundColor = [UIColor blackColor];
        lucencyLabel.alpha = 0.4;
        [self.storeImage addSubview:lucencyLabel];
        lucencyLabel.sd_layout.leftSpaceToView(_storeImage, 0).bottomSpaceToView(_storeImage, 0).rightSpaceToView(_storeImage, 0).heightIs(kFit(25));
        
        self.storeName = [UILabel new];
        _storeName.text = @"双虎家私";
        _storeName.textColor = MColor(203, 203, 203);
        _storeName.font = MFont(kFit(12));
        _storeName.textAlignment = 1;
        [self.storeImage addSubview:_storeName];
        _storeName.sd_layout.leftSpaceToView(_storeImage, 0).bottomSpaceToView(_storeImage, 0).rightSpaceToView(_storeImage, 0).heightIs(kFit(25));
        //
        UIImageView *rankingImage = [UIImageView new];
        rankingImage.image = [UIImage imageNamed:@"paihang"];

        [self.storeImage addSubview:rankingImage];
        rankingImage.sd_layout.leftSpaceToView(_storeImage, kFit(7)).topSpaceToView(_storeImage, 0).widthIs(16.5).heightIs(kFit(21));
        
        self.numLabel = [UILabel new];
        _numLabel.text = @"1";
        _numLabel.textAlignment = 1;
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.font = MFont(kFit(11));
        [rankingImage addSubview:_numLabel];
        _numLabel.sd_layout.leftSpaceToView(rankingImage, 0).topSpaceToView(rankingImage, 0).rightSpaceToView(rankingImage, 0).bottomSpaceToView(rankingImage, 0);
    }
    return self;
}

-(void)setModel:(StoreRankingListModel *)model {
    
    [_storeImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.storeLogo] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    
    _storeName.text = model.storeName;
}

- (void)configureRanking:(NSInteger)index {
    
    _numLabel.text = [NSString stringWithFormat:@"%ld", (long)index+1];
}

@end
