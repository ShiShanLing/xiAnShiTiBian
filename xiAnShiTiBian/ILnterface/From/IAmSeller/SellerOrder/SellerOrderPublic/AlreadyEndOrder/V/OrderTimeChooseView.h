//
//  OrderTimeChooseView.h
//  timeSelectorView
//
//  Created by 石山岭 on 2017/1/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderTimeChooseViewDelegate <NSObject>

- (void)deselect;

- (void)ChooseOrderTime:(NSString *)sender;

@end

/**
 *选择展示订单的时间(什么时候的订单)
 */
@interface OrderTimeChooseView : UIView

@property (nonatomic, assign)id<OrderTimeChooseViewDelegate>delegate;



@end
