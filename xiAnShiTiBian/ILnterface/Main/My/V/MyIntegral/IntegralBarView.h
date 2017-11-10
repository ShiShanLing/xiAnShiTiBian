//
//  IntegralBarView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/30.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolFunctionView.h"

@protocol IntegralBarViewDelegate <NSObject>

- (void)IntegralBarChoose:(int)index;

@end

@interface IntegralBarView : UIView

@property (nonatomic, assign)id<IntegralBarViewDelegate>Delegate;

@end
