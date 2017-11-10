//
//  PayPopUpView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/4.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PayPopUpViewDelegate <NSObject>
/**
 *隐藏弹窗
 */
- (void)hiddenView;
/**
 *确定按钮点击时间
 */
- (void)DetermineBtnClick:(NSInteger)sender;
/**
 *帮助按钮
 */
- (void)handleHelp;
@end
@interface PayPopUpView : UIView

@property (nonatomic, assign)id<PayPopUpViewDelegate>delegate;

@property (nonatomic, assign)CGFloat OrderPrice;
@end
