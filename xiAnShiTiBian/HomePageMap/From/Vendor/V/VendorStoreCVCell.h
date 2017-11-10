//
//  VendorStoreCVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *厂家里面的商家介绍界面
 */
@interface VendorStoreCVCell : UICollectionViewCell

/**
 *商品图片
 */
@property (nonatomic, strong)UIImageView *storeImage;
/**
 *商品名称
 */
@property (nonatomic, strong)UILabel *storeName;
- (void)configureCellWithPostURL:(NSString *)posterURL;

@property (nonatomic, strong)SellerDataModel *model;

@end
