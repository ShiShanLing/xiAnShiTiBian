//
//  ClassificationView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/6.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ClassificationView.h"

@implementation ClassificationView  {
    UIButton*tembtn;
    NSMutableArray*labArr;
    NSMutableArray*btnArr;
    UIPageControl* page;
    NSMutableArray*imgarr;
    CGRect temRect;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setCreatingControls];
    }
    return self;
}
- (void)setCreatingControls {
    NSMutableArray *temp = [NSMutableArray new];
    NSArray*arr=@[@"热门",@"销量",@"新品", @"价格", @"zl"];
    for (int i = 0 ; i < 5; i ++) {
        UIButton *btn = [UIButton new];
        btn.tag=11000+i;
        btn.backgroundColor = [UIColor whiteColor];
        if (i != 4) {
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        }else {
            [btn setImage:[UIImage imageNamed:@"zl"] forState:(UIControlStateNormal)];
            [btn setImage:[UIImage imageNamed:@"hxl"] forState:UIControlStateSelected];
        }
        btn.titleLabel.font=MFont(kFit(14));
        [self addSubview:btn];
        btn.sd_layout.autoHeightRatio(0.53);
        [temp addObject:btn];
        [btn addTarget:self action:@selector(btn_clicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [btn setTitleColor:[UIColor colorWithRed:60/256.0 green:186/256.0 blue:153/256.0 alpha:1] forState:UIControlStateNormal];
            tembtn=btn;
        }else {
            [btn setTitleColor:[UIColor colorWithRed:134/256.0 green:134/256.0 blue:134/256.0 alpha:1] forState:UIControlStateNormal];
        }
    }
    [self setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:5 verticalMargin:1 horizontalMargin:0 verticalEdgeInset:1 horizontalEdgeInset:0];
    
    UILabel *shadowLabel = [UILabel new];
    
    shadowLabel.backgroundColor = [UIColor colorWithRed:210/256.0 green:210/256.0 blue:210/256.0 alpha:1];
    
    [self addSubview:shadowLabel];
    
    shadowLabel.sd_layout.leftSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(kScreen_widht).heightIs(0.5);
    
}

-(void)btn_clicked:(UIButton*)btn{
    if (btn.tag != 11004) {
        UIButton *myButton1 = (UIButton *)[self viewWithTag:11000];
        [myButton1 setTitleColor:[UIColor colorWithRed:134/256.0 green:134/256.0 blue:134/256.0 alpha:1] forState:UIControlStateNormal];
        UIButton *myButton2 = (UIButton *)[self viewWithTag:11001];
        [myButton2 setTitleColor:[UIColor colorWithRed:134/256.0 green:134/256.0 blue:134/256.0 alpha:1] forState:UIControlStateNormal];
        UIButton *myButton3 = (UIButton *)[self viewWithTag:11002];
        [myButton3 setTitleColor:[UIColor colorWithRed:134/256.0 green:134/256.0 blue:134/256.0 alpha:1] forState:UIControlStateNormal];
        UIButton *myButton4 = (UIButton *)[self viewWithTag:11003];
        [myButton4 setTitleColor:[UIColor colorWithRed:134/256.0 green:134/256.0 blue:134/256.0 alpha:1] forState:UIControlStateNormal];
    
        [btn setTitleColor:[UIColor colorWithRed:60/256.0 green:186/256.0 blue:153/256.0 alpha:1] forState:UIControlStateNormal];
    }else {
         btn.selected = !btn.selected;        
    }
    
    if ([_delegate respondsToSelector:@selector(btn_classification:)]) {
        [_delegate btn_classification:btn];
    }

    
    
}



@end
