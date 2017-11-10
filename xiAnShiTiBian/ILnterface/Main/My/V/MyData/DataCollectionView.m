//
//  DataCollectionView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/30.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "DataCollectionView.h"

@interface DataCollectionView ()<IconViewDelegate>

@end

@implementation DataCollectionView

-(instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
        NSArray *TitleArray = @[@"全部订单",@"待付款", @"待发货", @"待收货",@"待评价"];
        NSArray *imageArray = @[@"qbdd",@"dfk", @"dsh",@"dfh", @"dpj"];
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < 5; i++) {
            IconView *view = [IconView new];
            view.tag = 160 +i;
            view.delegate = self;
            view.iconImage.image = [UIImage imageNamed:imageArray[i]];
            view.nameLabel.text = TitleArray[i];
            [self addSubview:view];
            view.sd_layout.autoHeightRatio(1.0);
            [temp addObject:view];
        }
        // 关键步骤：设置类似collectionView的展示效果
        [self setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:5 verticalMargin:1 horizontalMargin:15 verticalEdgeInset:1 horizontalEdgeInset:20];

    }
    return self;
}

- (void)FunctionChoose:(IconView *)view {

    if ([_Delegate respondsToSelector:@selector(OrderChoose:)]) {
        [_Delegate OrderChoose:(int)view.tag];
    }

}

@end
