//
//  PopUpView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/13.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailsModel;
@protocol PopUpViewDelegate <NSObject>
/**
 *隐藏弹窗
 */
- (void)hiddenView;
/**
 *确定按钮点击时间
 */
- (void)DetermineBtnClick:(UIButton *)sender typeID:(NSArray *)typeID typeName:(NSArray *)typeName goodsNum:(NSInteger)goodsNum;

@end
/**
 *商品详情界面和购物车界面 公用的 商品规格选择弹窗
 */
@interface PopUpView : UIView
/**
 *弹窗确定按钮点击事件  和 弹窗显示的代理方法
 */
@property (nonatomic, assign)id<PopUpViewDelegate>delegate;
/**
 *商品详情的model 用来展示商品的信息 和商品给规格用  这里要说明的是 商品 规格的显示 和商品规格判断剩余库存的数据是来自两个存储器里面 这个是用来展示的    specIDArray 是用来判断你点击的 规格还有多少库存的
 */
@property (nonatomic,strong)GoodsDetailsModel *model;
/**
 *存储需要对比的商品规格 ..需要计算出来那种规格的商品还有多少个
 */
@property (nonatomic, strong)NSMutableArray *specIDArray;
/**
 *存储需要显示的商品数量 这个属性存在的意义在于  当商品详情调用的时候显示 商品数量默认为一 当购物车调用的时候需要显示当前商品数量
 */
@property (nonatomic, assign)NSInteger goodsNum;

@end
