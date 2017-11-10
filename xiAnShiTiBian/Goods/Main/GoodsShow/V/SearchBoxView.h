//
//  SearchBoxView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/27.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *搜索框点击事件
 */
@protocol SearchBoxViewDelegate <NSObject>
- (void)SearchJump;
@end
/**
 *自定的搜索框
 */
@interface SearchBoxView : UIView

@property (nonatomic, assign)id<SearchBoxViewDelegate>Delegate;

@property (nonatomic, strong)UILabel *titleLabel;

@end
