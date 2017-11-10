//
//  submitView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol submitViewDelegate <NSObject>

- (void)ConfirmpayBtn;

@end

/**
 *确认订单界面 提交订单View
 */
@interface submitView : UIView

@property (nonatomic, strong)UIButton *submitBtn;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic,assign)id<submitViewDelegate>delegate;
@end
