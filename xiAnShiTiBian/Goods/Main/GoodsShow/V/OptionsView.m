//
//  OptionsView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/27.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "OptionsView.h"

@interface OptionsView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching, UICollectionViewDelegate, UIScrollViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
/**
 *让用知道在第几页的指示条
 */
@property(nonatomic,strong)UIScrollView*guideSV;


@end

@implementation OptionsView {
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
        NSArray*arr=@[@"全部发票",@"电子发票",@"纸质发票"];
        for (int i=0; i<3; i++) {
            UIButton*btn=[[UIButton alloc] initWithFrame:CGRectMake(i*187/3, 64, 187/3, kFit(44))];//在导航栏下面
            btn.tag=i;
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:kFit(15)];
            [btnArr addObject:btn];
            if (i==0) {
                [btn setTitleColor:MColor(242, 48, 48) forState:UIControlStateNormal];
                tembtn=btn;
                temRect=btn.frame;
            }
            else
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btn_clicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        

    }
    return self;

}

@end
