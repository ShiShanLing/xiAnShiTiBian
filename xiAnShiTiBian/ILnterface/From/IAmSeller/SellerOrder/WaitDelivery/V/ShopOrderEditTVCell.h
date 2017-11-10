//
//  ShopOrderEditTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopOrderEditTVCellDelegate <NSObject>
/**
 *我要叫车
 */
- (void)IWantCallCar:(OrderBtn *)sender;
/**
 *已经叫过车了
 */
- (void)haveAlreadyCalledCar:(OrderBtn *)sender;

@end

/**
 *商家订单编辑
 */
@interface ShopOrderEditTVCell : UITableViewCell
@property (nonatomic, assign)id<ShopOrderEditTVCellDelegate>delegate;
@property (nonatomic, strong)SellerOrderListModel *model;
- (void)cellIndex:(NSIndexPath *)indexPath;

@end
