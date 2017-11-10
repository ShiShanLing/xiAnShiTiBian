//
//  GuidePageView.m
//  
//
//  Created by 石山岭 on 2016/11/21.
//
//

#import "GuidePageView.h"
#define Button_Name    @"开始体验"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation GuidePageView 

- (instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置引导视图的scrollview
        self.guidePageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, kScreen_widht, kScreen_heigth+20)];
        self.guidePageView.backgroundColor = [UIColor whiteColor];
        self.guidePageView.contentSize = CGSizeMake(SCREEN_WIDTH*images.count, SCREEN_HEIGHT-20);
        self.guidePageView.bounces = NO;
        self.guidePageView.pagingEnabled = YES;
        self.guidePageView.showsHorizontalScrollIndicator = NO;
        self.guidePageView.delegate = self;
        [self addSubview:_guidePageView];
        
        //设置引导页上的跳过按钮
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.8, SCREEN_WIDTH*0.1, 50, 25)];
        [btn setTitle:@"跳过" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor grayColor];
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];

        //添加在引导视图上的多张引导图片
        for (int i=0; i<images.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            imageView.image = [UIImage imageNamed:images[i]];
            [self.guidePageView addSubview:imageView];
            //设置在最后一张图片上显示进入体验按钮
            if (i == images.count-1) {
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] init];
                singleRecognizer.numberOfTapsRequired = 1; // 单击
                [singleRecognizer addTarget:self action:@selector(removeGuidePage)];
                [imageView addGestureRecognizer:singleRecognizer];
            }
        }
        [self addSubview:self.imagePageControl];
    }
    return self;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollview {
    int page = scrollview.contentOffset.x / scrollview.frame.size.width;
    [self.imagePageControl setCurrentPage:page];
}

- (void)btn_Click:(UIButton *)sender
{
    
    [self performSelector:@selector(removeGuidePage) withObject:nil afterDelay:1];
    
    
}

- (void)removeGuidePage{
    if ([_delegate respondsToSelector:@selector(removeGuidePages)]) {
        [_delegate removeGuidePages];
    }
    [self removeFromSuperview];
}


@end
