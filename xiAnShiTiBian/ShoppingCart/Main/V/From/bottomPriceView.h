//
//  bottomPriceView.h
//  meidianjie
//
//  Created by HYS on 16/1/6.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class bottomPriceView;
@protocol bottomPriceViewDelegate <NSObject>
/**
 *商品全选
 */
- (void)bottomPriceView:(BOOL)bottonView;
/**
 *结算
 */
- (void)SettlementClick:(UIButton *)sender;

@end
/**
 *显示购物车内多少商品被选一共多少钱
 */
@interface bottomPriceView : UIView
/**全选btn*/
@property (nonatomic, strong) UIButton *selectedBtn;
/**结算btn*/
@property (nonatomic, strong) UIButton *payBtn;
/**合计label*/
@property (nonatomic, strong) UILabel *allPriceLabel;
/**结算字符串*/
@property (nonatomic, copy) NSString *payStr;
/**合计字符串*/
@property (nonatomic, strong) NSString *attAllStr;
@property (nonatomic, strong) NSString *changeStr;
@property (nonatomic, assign) BOOL isSelectBtn;

@property (weak, nonatomic) id<bottomPriceViewDelegate> delegate;

@end
