//
//  CitySelectionView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapCitySelectionViewDelegate <NSObject>
/**
 *地图上的城市选择点击事件
 */
-(void)CitySelectionClick;

@end

/**
 *地图上的城市选择
 */
@interface MapCitySelectionView : UIView
@property (nonatomic, strong)UILabel *citySearchLabel;
@property(nonatomic, assign)id<MapCitySelectionViewDelegate>delegate;

@end
