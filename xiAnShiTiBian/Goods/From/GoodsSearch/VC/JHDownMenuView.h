//
//  JHDownMenuView.h
//  模仿QQ下拉菜单
//
//  Created by zhou on 16/7/21.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHDownMenuViewDelegate <NSObject>

- (void)SearchTypeIndex:(int)index;

@end

@interface JHDownMenuView : UIView

@property (nonatomic, assign)id<JHDownMenuViewDelegate>delegate;

@end
