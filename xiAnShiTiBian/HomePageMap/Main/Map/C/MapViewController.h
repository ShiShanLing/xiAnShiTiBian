//
//  MapViewController.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/21.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface MapViewController : BaseViewController

@property (nonatomic, strong)NSString *SearchValue;
/**
 *存储搜索到的店铺
 */
@property (nonatomic, strong)NSMutableArray *storeArray;

@end
