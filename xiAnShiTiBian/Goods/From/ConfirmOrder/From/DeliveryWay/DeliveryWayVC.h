//
//  DeliveryWayVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/21.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^DeliveryWayIndexBlock)(NSInteger index);
/**
 *货运方式
 */
@interface DeliveryWayVC : UIViewController

@property (nonatomic, copy) DeliveryWayIndexBlock returnTextBlock;

@property (nonatomic, assign)NSInteger DefaultDeliveryWayIndex;

@end
