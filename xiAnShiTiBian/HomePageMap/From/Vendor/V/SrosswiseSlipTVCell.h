//
//  SrosswiseSlipTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SrosswiseSlipTVCellDelegate <NSObject>

- (void)ClickStoreIndex:(int)index;

@end

/**
 *厂家下面的经销商(卖有厂家商品)  这个界面实现的方法在UITbaleViewCell 里面创建了一个UICollectionViewCell
 */
@interface SrosswiseSlipTVCell : UITableViewCell

@property (nonatomic, assign)id<SrosswiseSlipTVCellDelegate>delegate;

@property (nonatomic, strong)FactoryDataModel *model;
- (void)deliveryData:(NSArray *)array;
@end
