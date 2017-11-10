//
//  ColumnsView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/6.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *分栏
 */
@protocol ColumnsViewDelegate <NSObject>

-(void)btn_clickeds:(UIButton*)btn;

@end

@interface ColumnsView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *ScrollView;
@property (nonatomic, assign)id<ColumnsViewDelegate>delegate;


@end
