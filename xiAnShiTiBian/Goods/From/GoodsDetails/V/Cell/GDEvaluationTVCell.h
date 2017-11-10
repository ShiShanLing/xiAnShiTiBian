//
//  GDEvaluationTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/10.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *商品详情下方模块选择cell
 */
@protocol GDEvaluationTVCellDelegate <NSObject>

- (void)ChooseClick:(NSInteger)index;

@end

@interface GDEvaluationTVCell : UITableViewCell

@property (nonatomic, assign)id<GDEvaluationTVCellDelegate>delegate;

@end
