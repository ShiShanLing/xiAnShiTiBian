//
//  StoreDetaileVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/27.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentClassScrollViewController.h"
/**
 *店铺详情信息
 */
@interface StoreDetaileVC : ParentClassScrollViewController

@property (nonatomic, strong)NSString *storeID;

@property (nonatomic, strong)StoreRankingListModel *model;

@end
