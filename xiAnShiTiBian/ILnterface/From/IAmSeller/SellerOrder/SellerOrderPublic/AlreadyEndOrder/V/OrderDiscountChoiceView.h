//
//  OrderDiscountChoiceView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderDiscountChoiceViewDelegate <NSObject>

/**
 *确定
 */
- (void)ChooseDiscount:(NSString *)discount;
/**
 *取消
 */
- (void)deselect;

@end
/**
 *折扣选择
 */
@interface OrderDiscountChoiceView : UIView

@property (nonatomic,assign)id<OrderDiscountChoiceViewDelegate>delegate;
@property (nonatomic, strong)NSArray *DataArray;

@end
