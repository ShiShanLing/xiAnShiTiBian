//
//  VendorGoodsView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VendorGoodsViewDelegate <NSObject>
/**
 *厂家产品展示view
 */
- (void)viewClick:(UIView *)tap;

@end

@interface VendorGoodsView : UIView

@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *goodsTitleLabel;
@property (nonatomic, strong) UILabel *goodsPriceLabel;
@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, assign)id<VendorGoodsViewDelegate>delegate;

- (void)assignment:(NSString *)url;

@end
