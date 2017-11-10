//
//  IntegralBarView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/30.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "IntegralBarView.h"

@interface IntegralBarView()<ToolFunctionViewDelegate>

@end

@implementation IntegralBarView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *titleArray = @[@"积分提现", @"积分记录", @"积分说明", @""];
        NSArray *imageArray = @[@"jftx", @"jfjl", @"jfsm", @""];
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < 4; i++) {
            ToolFunctionView *view = [ToolFunctionView new];
            view.tag = 180 + i;
            view.delegate = self;
            view.iconImage.image = [UIImage imageNamed:imageArray[i]];
            view.nameLable.text = titleArray[i];
            [self addSubview:view];
            view.sd_layout.autoHeightRatio(1.1);
            [temp addObject:view];
        }
            // 关键步骤：设置类似collectionView的展示效果
        [self setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:4 verticalMargin:1 horizontalMargin:1 verticalEdgeInset:1 horizontalEdgeInset:0];
    }
    return self;
}

- (void)FunctionChoose:(ToolFunctionView *)view {
    
    NSLog(@"%ld--", view.tag);
    if ([_Delegate respondsToSelector:@selector(IntegralBarChoose:)]) {

        [_Delegate IntegralBarChoose:(int)view.tag];
        
    }
}


@end
