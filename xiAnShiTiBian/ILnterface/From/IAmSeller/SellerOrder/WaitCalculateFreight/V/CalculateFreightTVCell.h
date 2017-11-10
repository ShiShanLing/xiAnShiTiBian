//
//  CalculateFreightTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalculateFreightTVCellDelegate <NSObject>

- (void)CalculateFreight:(OrderBtn *)sender;

@end

/**
 *商家 计算运费cell
 */
@interface CalculateFreightTVCell : UITableViewCell

@property(nonatomic, assign)id<CalculateFreightTVCellDelegate>delegate;

@property (nonatomic, strong)SellerOrderListModel *model;

- (void)cellIndex:(NSIndexPath *)indexPath;



@end
