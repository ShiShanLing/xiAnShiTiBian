//
//  GuidePageVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/21.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "GuidePageVC.h"
#import "GuidePageView.h"

@interface GuidePageVC ()<GuidePageViewDelegate>

@end

@implementation GuidePageVC


- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSArray *dataArray =  @[@"image1.jpg",@"image2.jpg", @"image3.jpg", @"image4.jpg",@"image5.jpg"];
    
    GuidePageView *GPV = [[GuidePageView alloc] initWithFrame:CGRectMake(0, 22, kScreen_widht, kScreen_heigth-22) WithImages:dataArray];
    GPV.delegate = self;
    [self.view addSubview:GPV];
}

- (void)removeGuidePages {//把界面显示出来
    
    BaseTabBarVC *BaseTBVC  = [[BaseTabBarVC alloc] init];
    UIWindow *window =  [[UIApplication sharedApplication].delegate window];
    window.rootViewController = BaseTBVC;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
