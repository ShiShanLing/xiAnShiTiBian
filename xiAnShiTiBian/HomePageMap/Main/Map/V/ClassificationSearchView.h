//
//  ClassificationSearchView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassificationSearchViewDelegate <NSObject>
/**
 *地图上的分类搜索点击事件
 */
- (void)MapClassSearchClick;

@end

/**
 *地图上的分类搜索
 */
@interface ClassificationSearchView : UIView

@property (nonatomic, assign)id<ClassificationSearchViewDelegate>delegate;

@end
