//
//  UIViewController+NetworkDetermineVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
//添加网络判断的分类
@interface UIViewController (NetworkDetermineVC)
/**
 *网络状态判断
 */
- (BOOL)NetworkDetermine;

- (BOOL)logInState;
/**
 *网络加载指示器出现
 */
- (void)indeterminateExample;
/**
 *网络加载指示器消失
 */
- (void)delayMethod;
- (void)showAlert:(NSString *) _message time:(CGFloat)time;
@end
