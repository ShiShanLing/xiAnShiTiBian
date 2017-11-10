//
//  MyOrderViewController.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/10.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *我的订单界面    ->有五个选项 因为设计不可滑动 所以使用一个uitableIView来实现的  订单的列表是由三部分组成 -- 商店名字  商品 和订单的属性(运费 多少数量多少钱 之类的)
 一个订单是一个分组 每个分组的里面的cell数量是 商品数量+2 (商品名字cell 和 订单的属性cell + 商品数量)
 
 ※重点 这个界面是通过是否有订单来判断是否使用那种视图 有订单使用UITableView 没订单使用集合视图
 */
@interface MyOrderViewController : UIViewController
@property (nonatomic, assign)NSInteger index;
@end
