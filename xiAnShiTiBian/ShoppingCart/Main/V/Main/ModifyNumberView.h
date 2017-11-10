//
//  ModifyNumberView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/9.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModifyNumberView;
@protocol ModifyNumberViewDelegate <NSObject>
/**
 *数量修改 tag201 减  202 加
 */
- (void)GoodsNumberChange:(UIButton*)sender view:(ModifyNumberView *)view;
/**
 *该VIew点击事件
 */
- (void)GoodsNumberEditorClickTag:(UITapGestureRecognizer *)tap;

@end

@interface ModifyNumberView : UIView

@property (nonatomic , strong)NSIndexPath *indexPath;
@property (nonatomic, strong)UIButton *AddBtn;
@property (nonatomic, strong)UIButton *reductionBtn;
@property (nonatomic, strong)UITextField *numberTF;

@property (nonatomic, assign)id<ModifyNumberViewDelegate>delegate;

@end
