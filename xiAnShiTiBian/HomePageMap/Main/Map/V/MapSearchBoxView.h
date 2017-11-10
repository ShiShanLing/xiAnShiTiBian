//
//  MapSearchBoxView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapSearchBoxViewDelegate <NSObject>
/**
 *地图上的关键字搜索点击事件
 */
- (void)MapMainSearchClick;

@end
/**
 *地图上的搜索框
 */
@interface MapSearchBoxView : UIView

@property (nonatomic, assign)id<MapSearchBoxViewDelegate>delegate;

@property (nonatomic, strong)UILabel *SearchContentLabel;

@end
