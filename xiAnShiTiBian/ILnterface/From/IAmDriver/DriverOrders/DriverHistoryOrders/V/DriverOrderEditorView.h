//
//  DriverOrderEditorView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/23.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DriverOrderEditorViewDelegate <NSObject>

- (void)handleRegionChooseBtn;

- (void)handleCarTypeChooseBtn;

@end
/**
 *订单编辑view
 */
@interface DriverOrderEditorView : UIView

@property (nonatomic, assign)id<DriverOrderEditorViewDelegate>delegate;

@property (nonatomic, strong)UIButton *regionBtn;
@property (nonatomic, strong)UIButton *carTypeBtn;
- (void)ControlsAssignment:(NSString *)str type:(int)type;
@end
