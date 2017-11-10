//
//  SpecialListCViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/30.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "SpecialListCViewCell.h"

@interface SpecialListCViewCell ()<IAmBusinViewDelegate>

@end

@implementation SpecialListCViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MColor(210, 210, 210);
        [self CreatingControls];
    }
    return self;
}

- (void)CreatingControls {

    NSArray *titleArray = @[@"我是车主", @"我是商家", @"客服"];
    NSArray *imageArray = @[@"wscz", @"wssj", @"wskf"];
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < 3; i++) {
        IAmBusinView *view = [IAmBusinView new];
        view.tag = 150 + i;
        view.delegate = self;
        view.iconImage.image = [UIImage imageNamed:imageArray[i]];
        view.titleLabel.text = titleArray[i];
        [self addSubview:view];
        view.sd_layout.autoHeightRatio(0.12666);
        [temp addObject:view];
    }
    // 关键步骤：设置类似collectionView的展示效果
    [self setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:1 verticalMargin:0.5 horizontalMargin:1 verticalEdgeInset:0 horizontalEdgeInset:0];

}
-(void)managementClick:(IAmBusinView *)view {
    if ([_delegate respondsToSelector:@selector(managementFunctionClick:)]) {
        [_delegate managementFunctionClick:(int)view.tag];
    }



}
@end
