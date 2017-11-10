//
//  CityListViewController.m
//  ChinaCityList
//
//  Created by zjq on 15/10/27.
//  Copyright © 2015年 zhengjq. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol CityListViewControllerDelegate <NSObject>

- (void)didClickedWithCityName:(RecentSearchCity*)cityName;

@end

/**
 *地图中的城市选择
 */
@interface CityListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) id<CityListViewControllerDelegate>delegate;


@property (strong, nonatomic) NSMutableArray *arrayLocatingCity;//定位城市数据
/**
 *热门城市数据
 */
@property (strong, nonatomic) NSMutableArray *arrayHotCity;//热门城市数据
/**
 *常用城市数据
 */
@property (strong, nonatomic) NSMutableArray *arrayHistoricalCity;//常用城市数据

@property(nonatomic,strong)UITableView *tableView;

@end
