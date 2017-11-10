//
//  IAmBusinView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/30.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IAmBusinView;
@protocol IAmBusinViewDelegate <NSObject>

-(void)managementClick:(IAmBusinView *)view;

@end

/**
 *我是商家.我是车主,客服,公用的view
 */
@interface IAmBusinView : UIView

@property (nonatomic, strong)UIImageView *iconImage;
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, assign)id<IAmBusinViewDelegate>delegate;

@end
