//
//  GuidePageView.h
//  
//
//  Created by 石山岭 on 2016/11/21.
//
//

#import <UIKit/UIKit.h>
/*
 
 */
@protocol GuidePageViewDelegate <NSObject>
/**
 *界面消失的时机 界面消失时用这个方法吧主界面显示出来
 *BaseTabBarVC *BaseTBVC  = [[BaseTabBarVC alloc] init];
 *UIWindow *window =  [[UIApplication sharedApplication].delegate window];
 *window.rootViewController = BaseTBVC;
 */
- (void)removeGuidePages;

@end

/**
 *引导页封装
 */
@interface GuidePageView : UIView <UIScrollViewDelegate>

@property UIPageControl *imagePageControl;

@property UIScrollView  *guidePageView;

/**
 *创建方法
 */
- (instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray *)images;

@property (nonatomic, assign)id<GuidePageViewDelegate>delegate;

@end
