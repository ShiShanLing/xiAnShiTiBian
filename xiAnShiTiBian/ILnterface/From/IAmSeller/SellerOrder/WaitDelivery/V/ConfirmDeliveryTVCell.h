//
//  ConfirmDeliveryTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfirmDeliveryTVCellDelegate <NSObject>
/**
 *确认发货
 */
- (void)ConfirmDeliveryBtn:(OrderBtn *)sender;
/**
 *查看叫车订单详情
 */
- (void)SeeCallCarDetails:(OrderBtn *)sender;
@end

/**
 *确定发货 view
 */
@interface ConfirmDeliveryTVCell : UITableViewCell

@property (nonatomic, assign)id<ConfirmDeliveryTVCellDelegate>delegate;

@property (nonatomic, strong)SellerOrderListModel *model;

@end
