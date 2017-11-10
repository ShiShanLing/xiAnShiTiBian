//
//  CityButton.h
//  ChinaCityList
//
//  Created by zjq on 15/10/27.
//  Copyright © 2015年 zhengjq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityItem.h"
@interface CityButton : UIButton

@property (nonatomic, assign) NSInteger index;
/**
 *城市名称
 */
@property (nonatomic, strong) CityItem *cityItem;
/**
 *城市经度
 */
@property (nonatomic,strong)NSString *longitude;
/**
 *城市纬度
 */
@property (nonatomic,strong)NSString *latitude;

@end
