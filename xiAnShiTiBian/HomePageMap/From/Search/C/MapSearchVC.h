//
//  MapSearchVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapSearchVCDelegate <NSObject>

- (void)searchResults:(NSString *)str storeArray:(NSArray *)array;

@end

/**
 *地图中的关键字搜索
 */
@interface MapSearchVC : UIViewController

@property (nonatomic, assign)id<MapSearchVCDelegate>delegate;

@property (nonatomic, assign)CLLocationCoordinate2D Position;

@end
