//
//  YouLikeTableViewCell.h
//  meidianjie
//
//  Created by HYS on 16/2/22.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuessLikeView.h"


@protocol YouLikeTableViewCellDelegate <NSObject>
- (void)handleLikeViewClick:(GuessLikeView *)index;
@end

/**
 *一排两个cell
 */
@interface YouLikeTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *shopArray;//最多存2个存GuessLikeGoodsModel
@property (nonatomic, strong) GuessLikeView *likeViewL;
@property (nonatomic, strong) GuessLikeView *likeViewR;
@property (nonatomic, strong)GoodsDetailsModel *modelL;
@property (nonatomic, strong)GoodsDetailsModel *modelR;


/**
 *
 */
@property (nonatomic, weak)id<YouLikeTableViewCellDelegate>delegate;

- (void)grantLikeViewAddCode:(NSIndexPath *)indexPath;

@end
