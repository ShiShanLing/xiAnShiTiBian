//
//  CallCarTimeChooseVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CallCarTimeChooseVCDelegate <NSObject>

/**
 *确定
 */
- (void)ChooseCallCarTime:(NSString *)car;
/**
 *取消
 */
- (void)deselect;

@end

@interface CallCarTimeChooseVC : UIView

@property (nonatomic,assign)id<CallCarTimeChooseVCDelegate>delegate;
@property (nonatomic, strong)NSArray *DataArray;

@end
