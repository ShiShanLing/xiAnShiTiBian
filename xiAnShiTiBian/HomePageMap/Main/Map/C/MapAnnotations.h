//
//  MapAnnotations.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/15.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>

@interface MapAnnotations : BMKPinAnnotationView 
/**
 *地图上展示的点分为两种 一是 店铺 二是厂家  所以都用这个来存储 不要在意名字 要看他的内在
 */
@property (nonatomic, strong)NSString *storeID;
/**
 *
 */
@property (nonatomic, strong)NSString *storeName;
/**
 *
 */
@property (nonatomic, strong)NSString *storeLogo;
/**
 *
 */
@property (nonatomic, strong)NSString *storeAddress;
/**
 *
 */
@property (nonatomic, strong)NSString *storeLvel;
@end
