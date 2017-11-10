//
//  VendorStoreCVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "VendorStoreCVCell.h"

@implementation VendorStoreCVCell

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
        
        
    }
    return self;

}
- (void)configureCellWithPostURL:(NSString *)posterURL {


}

-(void)setModel:(SellerDataModel *)model {
    NSLog(@"SellerDataModel%@", model);
    [_storeImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.storeLogo] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    _storeName.text = model.storeName;
}

@end
