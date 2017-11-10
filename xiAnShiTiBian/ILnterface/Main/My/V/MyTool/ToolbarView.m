//
//  ToolbarView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ToolbarView.h"



@interface ToolbarView ()<ToolFunctionViewDelegate>


@end


@implementation ToolbarView


-(instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *TitleArray = @[@"收藏宝贝", @"收藏店铺", @"我的评价",@""];
        NSArray *imageArray = @[@"scbb", @"scdp", @"wdpj", @""];
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < 4; i++) {
            ToolFunctionView *view = [ToolFunctionView new];
            view.tag = 170 + i;
            view.delegate = self;
            view.iconImage.image = [UIImage imageNamed:imageArray[i]];
            view.nameLable.text = TitleArray[i];
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
    if ([_Delegate respondsToSelector:@selector(ToolbarChoose:)]) {
        [_Delegate ToolbarChoose:(int)view.tag];
    }
    
}

@end
