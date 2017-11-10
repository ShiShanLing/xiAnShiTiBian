//
//  CarChooseView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *公用封装的选择器.
 */
@protocol CarChooseViewDelegate <NSObject>
/**
 *确定
 */
- (void)ChooseCar:(NSDictionary *)carDic;
/**
 *取消
 */
- (void)deselect;

@end
//选择车型view
@interface CarChooseView : UIView

@property (nonatomic, assign)id<CarChooseViewDelegate>delegate;
@property (nonatomic, strong)NSArray *DataArray;

@end
