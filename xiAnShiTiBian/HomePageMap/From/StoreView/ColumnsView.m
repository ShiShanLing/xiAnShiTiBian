//
//  ColumnsView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/6.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ColumnsView.h"

@implementation ColumnsView {
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
 NSArray*arr=@[@"店铺首页",@"全部商品",@"店铺信息"];
    for (int i = 0 ; i < 3; i ++) {
        UIButton *btn = [UIButton new];
        btn.tag=10000+i;
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font=MFont(kFit(14));
        [self addSubview:btn];
        btn.sd_layout.autoHeightRatio(0.39);
        [temp addObject:btn];
        [btn addTarget:self action:@selector(btn_clicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [btn setTitleColor:[UIColor colorWithRed:60/256.0 green:186/256.0 blue:153/256.0 alpha:1] forState:UIControlStateNormal];
            tembtn=btn;
        }else {
            [btn setTitleColor:[UIColor colorWithRed:134/256.0 green:134/256.0 blue:134/256.0 alpha:1] forState:UIControlStateNormal];
        }
        }
    [self setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:3 verticalMargin:1 horizontalMargin:0 verticalEdgeInset:1 horizontalEdgeInset:0];
    UILabel *shadowLabel = [UILabel new];
    shadowLabel.backgroundColor = [UIColor colorWithRed:210/256.0 green:210/256.0 blue:210/256.0 alpha:1];
    [self addSubview:shadowLabel];
    shadowLabel.sd_layout.leftSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(kScreen_widht).heightIs(0.5);
    self.ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 47.5, kScreen_widht/3, 2)];//这个47后面适配需要改掉
    self.ScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.ScrollView];
    self.ScrollView.backgroundColor=[UIColor colorWithRed:0.95f green:0.56f blue:0.11f alpha:1.00f];
    _ScrollView.delegate=self;
    _ScrollView.contentSize=CGSizeMake(kScreen_widht*2, 2);
    _ScrollView.showsHorizontalScrollIndicator=NO;
    _ScrollView.showsVerticalScrollIndicator=NO;
    
}

-(void)btn_clicked:(UIButton*)btn{
    long a = btn.tag - 10000;
    _ScrollView.contentOffset=CGPointMake(kScreen_widht/3 * a, 0);
    
    [tembtn setTitleColor:[UIColor colorWithRed:134/256.0 green:134/256.0 blue:134/256.0 alpha:1] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor colorWithRed:60/256.0 green:186/256.0 blue:153/256.0 alpha:1] forState:UIControlStateNormal];
    tembtn=btn;
    if (btn.tag==10000) {//1
        
        _ScrollView.frame=CGRectMake(0, CGRectGetMaxY(tembtn.frame)-2, kScreen_widht/3, 2);

           }
    if (btn.tag==10001) {//2
    
             _ScrollView.frame = CGRectMake(kScreen_widht/3, CGRectGetMaxY(tembtn.frame)-2, kScreen_widht/3, 2);

    }
    if (btn.tag==10002) {//3
        
        _ScrollView.frame = CGRectMake(kScreen_widht/3 * 2, CGRectGetMaxY(tembtn.frame)-2, kScreen_widht/3, 2);

    }
    
    if ([_delegate respondsToSelector:@selector(btn_clickeds:)]) {
        [_delegate btn_clickeds:btn];
    }

}


@end
