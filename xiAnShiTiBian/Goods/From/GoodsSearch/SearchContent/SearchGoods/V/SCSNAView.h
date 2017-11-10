//
//  SCSNAView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/28.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCSNAViewDelegate <NSObject>
/**
 *0是返回按钮 1是点击搜索框 也是返回  2是消息按钮
 */
- (void)SelectedObjects:(int)index;

@end

/**
 *这是搜索结果公用的模拟导航条
 */
@interface SCSNAView : UIView

@property (nonatomic, strong)id<SCSNAViewDelegate>delegate;

@end
