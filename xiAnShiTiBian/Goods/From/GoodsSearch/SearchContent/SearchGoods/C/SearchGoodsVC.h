//
//  SearchGoodsVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/28.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
/**
 *搜索到的商品展示
 */
@interface SearchGoodsVC : BaseViewController
/**
 *商品关键字
 */
@property (nonatomic, strong)NSArray *searchResultArray;

@end
