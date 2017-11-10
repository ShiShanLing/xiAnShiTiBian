//
//  MyIntegralVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/26.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "MyIntegralVC.h"
#import "MyIntegralTVCell.h"
#import "ThereNoInternetTVCell.h"
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kGroupNumber  3

static int networkStatus;


@interface MyIntegralVC ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate, ThereNoInternetTVCellDelegate>
/**
 *让用知道在第几页的指示条
 */
@property(nonatomic,strong)UIScrollView*guideSV;
/**
 *底层的UIScrollView
 */
@property(nonatomic,strong)UIScrollView*MainSV;
/**
 *全部
 */
@property (nonatomic, strong)UITableView *AllTV;
/**
 *电子发票
 */
@property (nonatomic, strong)UITableView *electronicTV;
/**
 *纸质发票
 */
@property (nonatomic, strong)UITableView *paperTV;
//存储目前在UIScrollView的第几页
@property (nonatomic, assign)NSInteger  WhatPage;


@end

@implementation MyIntegralVC

{
    UIButton*tembtn;
    NSMutableArray*labArr;
    NSMutableArray*btnArr;
    UIPageControl* page;
    NSMutableArray*imgarr;
    CGRect temRect;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 0;
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    self.navigationItem.title = @"我的发票";
    self.navigationController.navigationBar.barTintColor = kNavigation_whrColor;//导航条颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color, NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];//改变导航条标题的颜色与大小
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;

    self.view.backgroundColor=[UIColor whiteColor];
    imgarr=[NSMutableArray new];
    labArr=[NSMutableArray new];
    btnArr=[NSMutableArray new];
    temRect=CGRectZero;
    [self creatScrollview];
    [self creatTableview];
}

- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewWillAppear:(BOOL)animated {
    [self networkStatus];
    self.navigationController.navigationBar.translucent = YES;//下次出现问题就找你 导航条透明
    self.automaticallyAdjustsScrollViewInsets = NO;//自适应
    [super.navigationController setNavigationBarHidden:NO];
    [[UINavigationBar appearance] setTintColor:[UIColor blueColor]];
}

-(void)creatTableview{
    //全部发票
    self.AllTV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(_MainSV.frame)) style:UITableViewStylePlain];
    self.AllTV.backgroundColor = [UIColor whiteColor];
    self.AllTV.showsVerticalScrollIndicator = NO;
    _AllTV.delegate=self;
    _AllTV.dataSource=self;
    [_AllTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_AllTV registerClass:[MyIntegralTVCell class] forCellReuseIdentifier:@"MyIntegralTVCell"];
    [_AllTV registerClass:[ThereNoInternetTVCell class] forCellReuseIdentifier:@"ThereNoInternetTVCell"];
    //电子发票
    self.electronicTV=[[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, CGRectGetHeight(_MainSV.frame)) style:UITableViewStylePlain];
    _electronicTV.showsVerticalScrollIndicator = NO;
    _electronicTV.backgroundColor = [UIColor whiteColor];
    _electronicTV.delegate=self;
    _electronicTV.dataSource=self;
    [_electronicTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_electronicTV registerClass:[ThereNoInternetTVCell class] forCellReuseIdentifier:@"ThereNoInternetTVCell"];

    [_electronicTV registerClass:[MyIntegralTVCell class] forCellReuseIdentifier:@"MyIntegralTVCell"];
  
    //纸质发票
    self.paperTV=[[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, CGRectGetHeight(_MainSV.frame)) style:UITableViewStylePlain];
    _paperTV.showsVerticalScrollIndicator = NO;
    _paperTV.backgroundColor = [UIColor whiteColor];
    _paperTV.delegate=self;
    _paperTV.dataSource=self;
    [_paperTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_paperTV registerClass:[MyIntegralTVCell class] forCellReuseIdentifier:@"MyIntegralTVCell"];
    [_paperTV registerClass:[ThereNoInternetTVCell class] forCellReuseIdentifier:@"ThereNoInternetTVCell"];

    
    [self.MainSV addSubview:_AllTV];
    [self.MainSV addSubview:_electronicTV];
    [self.MainSV addSubview:_paperTV];
}
-(void)creatScrollview{
    NSArray*arr=@[@"全部发票",@"电子发票",@"纸质发票"];
    for (int i=0; i<kGroupNumber; i++) {
        UIButton*btn=[[UIButton alloc] initWithFrame:CGRectMake(i*kScreen_widht/3, 64, kScreen_widht/3, kFit(44))];//在导航栏下面
        btn.tag=i;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btnArr addObject:btn];
        if (i==self.index) {
            [btn setTitleColor:MColor(242, 48, 48) forState:UIControlStateNormal];
            tembtn=btn;
            temRect=btn.frame;
        }
        else
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btn_clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    self.guideSV=[[UIScrollView alloc] initWithFrame:CGRectMake(0, kFit(44) + 64, kScreen_widht/3, 2)];//在上面的按钮下面
    [self.view addSubview:_guideSV];
    _guideSV.backgroundColor=MColor(242, 48, 48);
    _guideSV.delegate=self;
    _guideSV.contentSize=CGSizeMake(kScreen_widht*2, 2);
    _guideSV.showsHorizontalScrollIndicator=NO;
    _guideSV.showsVerticalScrollIndicator=NO;
    //我是分割线
    UILabel *halvingLine = [[UILabel alloc] initWithFrame:CGRectMake(0, kFit(44) + 66, kScreen_widht, 0.5)];
    halvingLine.backgroundColor = MColor(210, 210, 210);
    [self.view addSubview:halvingLine];

    self.MainSV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_guideSV.frame) + 0.5,kScreen_widht , kScreen_heigth-CGRectGetMaxY(_guideSV.frame)-0.5)];
    [self.view addSubview:_MainSV];
    _MainSV.delegate=self;
    page=[[UIPageControl alloc]initWithFrame:CGRectZero];
    page.numberOfPages=3;
    page.currentPage=0;
    _MainSV.pagingEnabled=YES;
    [_MainSV addSubview:page];
    [_MainSV setContentOffset:CGPointMake(kScreen_widht*self.index, 0) animated:YES];//这句话默认选择的状态
    _MainSV.showsHorizontalScrollIndicator=NO;
    _MainSV.showsVerticalScrollIndicator=NO;
    _MainSV.contentSize=CGSizeMake(kScreen_widht*3,kScreen_heigth/2);
    
}
#pragma mark--实时监听滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==_MainSV) {
        _guideSV.contentOffset=CGPointMake(_MainSV.contentOffset.x/kGroupNumber, 0);
        _guideSV.frame=CGRectMake(_MainSV.contentOffset.x/kGroupNumber, kFit(44) + 64, SCREEN_WIDTH/kGroupNumber, 2);
    }
}
#pragma mark--停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView==_MainSV) {
        
        int i=_MainSV.contentOffset.x/SCREEN_WIDTH;
        self.WhatPage = i;
        UIButton*btn=btnArr[i];
        [tembtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.95f green:0.56f blue:0.11f alpha:1.00f] forState:UIControlStateNormal];
        tembtn=btn;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (networkStatus==0) {
        return 1;
    }else {
        return 10;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _AllTV) {
        
        if (networkStatus==0) {
            ThereNoInternetTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThereNoInternetTVCell" forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
            
        }else {
            MyIntegralTVCell * cell=[tableView dequeueReusableCellWithIdentifier:@"MyIntegralTVCell" forIndexPath:indexPath];
        NSString *str;
        int a = arc4random()%10;
        if (a % 2 ==1) {
            str = @"纸质发票";
        }else {
            str = @"电子发票";
        }
        [cell ControlsAssignment:str];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
        }
        
    }else if(tableView == _electronicTV){
        if (networkStatus==0) {
            ThereNoInternetTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThereNoInternetTVCell" forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
            
        }else {
        MyIntegralTVCell * cell=[tableView dequeueReusableCellWithIdentifier:@"MyIntegralTVCell" forIndexPath:indexPath];
        [cell ControlsAssignment:@"电子发票"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
        }

    }else {
        if (networkStatus==0) {
            ThereNoInternetTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThereNoInternetTVCell" forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
            
        }else {
        MyIntegralTVCell * cell=[tableView dequeueReusableCellWithIdentifier:@"MyIntegralTVCell" forIndexPath:indexPath];
        [cell ControlsAssignment:@"纸质发票"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (networkStatus==0) {
       
        return kScreen_heigth - 64 -kFit(43);
        
    }else {
        return kFit(157);
    }
}

-(void)btn_clicked:(UIButton*)btn{
    [tembtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.95f green:0.56f blue:0.11f alpha:1.00f] forState:UIControlStateNormal];
    
    tembtn=btn;

    if (btn.tag==0) {//1
        self.WhatPage = 0;
        [_MainSV setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    if (btn.tag==1) {//2
        self.WhatPage = 1;
        [_MainSV setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    }
    if (btn.tag==2) {//3
        self.WhatPage = 2;
        [_MainSV setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0) animated:YES];
    }
}
//模仿网络状态
- (void)networkStatus{
    
    int a = arc4random()%10;
    if (a / 2 != 0) {
        networkStatus =1;
    }else {
        
        networkStatus = 0;
    }
}
- (void)RefreshInterface {

    networkStatus = 1;
    [self.AllTV reloadData];
    [self.electronicTV reloadData];
    [self.paperTV reloadData];
    
}
@end
