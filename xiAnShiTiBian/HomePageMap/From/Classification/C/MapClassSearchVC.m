//
//  MapClassSearchVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MapClassSearchVC.h"
#import "ClassCVCell.h"
static int SearchClass;
@interface MapClassSearchVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching>

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSArray *titleArray;

@end

@implementation MapClassSearchVC

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"分类搜索";
    
    UIImage *buttonimage = [UIImage imageNamed:@"baidiganhui"];
    //[tapButton setImage:buttonimage forState:(UIControlStateNormal)];
    //设置图像渲染方式
    buttonimage = [buttonimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:buttonimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;

    SearchClass = 1;
    self.titleArray = @[@"热门排行", @"实体店", @"全民店", @"便民查询", @"厂家"];
    self.view.backgroundColor = MColor(238, 238, 238);
    [self setCollectionView];
}
- (void)handleReturn {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)setCollectionView {

    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = MColor(238, 238, 238);
    [self.view addSubview:bottomView];
    bottomView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(self.view, 64).widthIs(kFit(83.5)).heightIs(kScreen_heigth - 64);
    
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton new];
        btn.tag = 201+i;
        if (i == 0) {
            btn.backgroundColor = MColor(238, 238, 238);
            [btn setTitleColor:MColor(60, 186, 153) forState:(UIControlStateNormal)];

        }else {
        
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        
        }
        [bottomView addSubview:btn];
        btn.sd_layout.autoHeightRatio(0.42);
        [btn setTitle:_titleArray[i] forState:(UIControlStateNormal)];
        
        [btn addTarget:self action:@selector(handleClassChoose:) forControlEvents:(UIControlEventTouchUpInside)];
        [temp addObject: btn];
    }
    // 关键步骤：设置类似collectionView的展示效果
    [bottomView setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:1 verticalMargin:0.5 horizontalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //添加页眉
    // [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);//设置页眉的高度
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(kScreen_widht, kFit(15));
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kFit(93.5), 64, kScreen_widht-kFit(93.5), kScreen_heigth-64 - 5) collectionViewLayout:layout];
    _collectionView .dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = MColor(238, 238, 238);
    [_collectionView registerClass:[ClassCVCell class] forCellWithReuseIdentifier:@"ClassCVCell"];
    [self.view addSubview:_collectionView];
    
}
- (void)handleClassChoose:(UIButton *)sender {
    NSLog(@"----->>>>%ld", sender.tag);
    sender.backgroundColor = MColor(238, 238, 238);
    [sender setTitleColor:MColor(60, 186, 153) forState:(UIControlStateNormal)];
    
    SearchClass = (int)sender.tag - 200;
    
    for (int i  = 1; i < 6; i ++) {
        if (sender.tag != 200 + i) {
            UIButton *btn = [self.view viewWithTag:200 + i];
            btn.backgroundColor = MColor(255, 255, 255);
            [btn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        }
    }
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassCVCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = _titleArray[SearchClass-1];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"警告!" message:@"测试数据请勿当真?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    
    // 3.将“取消”和“确定”按钮加入到弹框控制器中
    [alertV addAction:cancle];
    // 4.控制器 展示弹框控件，完成时不做操作
    [self presentViewController:alertV animated:YES completion:^{
        nil;
    }];
}
//返回每个cell的布局左右上下间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return  UIEdgeInsetsMake(-10, kFit(5), 0, kFit(5));
    
}
//单独返回每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kFit(86.5), kFit(30));
    
}


@end
