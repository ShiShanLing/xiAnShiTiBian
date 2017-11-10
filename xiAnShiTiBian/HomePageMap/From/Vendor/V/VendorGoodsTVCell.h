//
//  VendorGoodsTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VendorGoodsView;
/**
 *厂家产品展示界面  因为暂时固定为四个所以用了4个UIView拼接而成  这样做的原因是  我他妈就是想这样做 你咬我啊(感觉集合视图布局太麻烦,)
 */
@protocol VendorGoodsTVCellDelegate <NSObject>

- (void)MoreProducts;


@end

/**
 *厂家商品展示
 */
@interface VendorGoodsTVCell : UITableViewCell

@property (nonatomic, assign)id<VendorGoodsTVCellDelegate>delegate;

@property (nonatomic, strong)FactoryDataModel *model;

@end
