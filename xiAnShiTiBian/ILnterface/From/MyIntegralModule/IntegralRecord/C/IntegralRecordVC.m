//
//  IntegralRecordVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/15.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "IntegralRecordVC.h"
#import "IRTVCell.h"
#import "IntegralListModel+CoreDataProperties.h"
@interface IntegralRecordVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *DataArray;
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@property (nonatomic, strong)AppDelegate *delegate;

@end

@implementation IntegralRecordVC
- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedContext = delegate.managedObjectContext;
    }
    return _managedContext;
}

- (AppDelegate *)delegate {
    if (!_delegate) {
        _delegate = [[AppDelegate alloc] init];
    }
    return _delegate;
}

- (NSMutableArray *)DataArray {
    if (!_DataArray) {
        _DataArray = [NSMutableArray array];
    }
    return _DataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self IntegralRecord];
    //配置导航条
    [self configurationNavigationBar];
    //创建tableView;
    [self CreateControlView];
}
- (void)configurationNavigationBar{
    self.navigationItem.title = @"积分记录";
    self.navigationController.navigationBar.barTintColor = kNavigation_whrColor;//导航条颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color, NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];//改变导航条标题的颜色与大小
    
    
    
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;

}

- (void)IntegralRecord {
    [self performSelector:@selector(indeterminateExample)];
    NSString *URL_Str = [NSString stringWithFormat:@"%@/pontsApi/pointslog",kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"memberId"] = [UserDataSingleton mainSingleton].userID;

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block IntegralRecordVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSString *dataStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([dataStr isEqualToString:@"1"]) {
            [VC parsingIntegralData:responseObject[@"data"]];
        }else {
            [VC showAlert:responseObject[@"msg"] time:1.0];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"网络超时请重试"];
    }];
}

- (void)parsingIntegralData:(NSArray *)array {
    for (NSDictionary *dataDic in array) {
        NSEntityDescription *des = [NSEntityDescription entityForName:@"IntegralListModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        IntegralListModel *integralListModel = [[IntegralListModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        for (NSString *key in dataDic) {
            [integralListModel setValue:dataDic[key] forKey:key];
        }
        [self.DataArray addObject:integralListModel];
    }
    NSLog(@"self.DataArray%@", self.DataArray);
    [self.tableView reloadData];
}

//返回上一界面
- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super.navigationController setNavigationBarHidden:NO];

}
- (void)CreateControlView {
    self.tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableView"];
    [self.tableView registerClass:[IRTVCell class] forCellReuseIdentifier:@"IRTVCell"];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IntegralListModel *model = self.DataArray[indexPath.row];
    IRTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IRTVCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return kFit(103);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//系统提示的弹出窗
- (void)timerFireMethod:(NSTimer*)theTimer {//弹出框
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}
//网络加载指示器
- (void)indeterminateExample {
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
    
}

- (void)delayMethod{
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
    
}

@end
