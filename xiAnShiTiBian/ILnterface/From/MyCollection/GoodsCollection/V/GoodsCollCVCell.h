//
//  GoodsCollCVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/7.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsCollCVCellDelegate <NSObject>

-(void)collGoodsEditor:(UIButton *)sender;
- (void)similarGoods:(UIButton *)sender;
@end

/**
 *我收藏的宝贝cell
 */
@interface GoodsCollCVCell : UICollectionViewCell

@property (nonatomic, assign)id<GoodsCollCVCellDelegate>delegate;

- (void)EditButtonTagAssignment:(NSIndexPath *)indexPaht;

/**
 *
 */
@property (nonatomic, strong)GoodsCollModel *model;

@end
