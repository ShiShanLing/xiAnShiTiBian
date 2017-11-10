//
//  DriverDataShowVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/14.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverDataShowVC.h"
#import "DriverDataTVCell.h"
#import "DriverVehicleDataTVCell.h"
#import "DriverCertificationStatusTVCell.h"

@interface DriverDataShowVC ()<UITableViewDelegate, UITableViewDataSource, DriverVehicleDataTVCellDelegate,DriverCertificationStatusTVCellDelegate, CarChooseViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
/**
 *汽车型号选择 Fahrzeugmodell
 */
@property (nonatomic, strong) CarChooseView *FPickerView;
/**
 *车型选择时的背景色
 */
@property (nonatomic, strong)UIView *backImageView;
/**
 *选择的当前车型str
 */
@property (nonatomic, strong)NSString *ChooseCarStr;
@end

@implementation DriverDataShowVC {

NSArray *FahrzeugmodellArray;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStyleGrouped)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.ChooseCarStr = @"小汽车";
    FahrzeugmodellArray = @[@"小货车", @"大货车", @"小飞机", @"大飞机", @"小火车", @"大火车"];
    self.navigationItem.title = @"司机资料";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = MColor(238, 238, 238);
    [self createTableView];
}

- (void)createTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [_tableView registerClass:[DriverDataTVCell class] forCellReuseIdentifier:@"DriverDataTVCell"];
    [_tableView registerClass:[DriverVehicleDataTVCell class] forCellReuseIdentifier:@"DriverVehicleDataTVCell"];
    [_tableView registerClass:[DriverCertificationStatusTVCell class] forCellReuseIdentifier:@"DriverCertificationStatusTVCell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:_tableView];
    
}
-(void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DriverDataTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DriverDataTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            DriverVehicleDataTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DriverVehicleDataTVCell" forIndexPath:indexPath];
            cell.delegate = self;
            [cell ControlsAssignment:_ChooseCarStr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if(indexPath.section == 1){
        DriverCertificationStatusTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DriverCertificationStatusTVCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = @"出行69次";
        cell.textLabel.font = MFont(kFit(15));
        cell.textLabel.textColor = MColor(51, 51, 51);
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kFit(150);
        }else {
            return kFit(141);
        }
    }else if(indexPath.section == 1){
        return kFit(141);
    }else {
        return kFit(47);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kFit(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth)];
    view.backgroundColor = MColor(238, 238, 238);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth)];
    view.backgroundColor = MColor(238, 238, 238);
    return view;
}

- (void)driverDataEditor:(int)index {
    
    [self indeterminateExample];
    NSLog(@"------%d", index);
    if (index == 1) {
        
        NSString *URL_Str = [NSString stringWithFormat:@"%@/cartask/api/selectCarCost", kSHY_100];
        __block DriverDataShowVC *VC = self;
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session GET:URL_Str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"downloadProgress%@", downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [VC delayMethod];
            if ([[NSString stringWithFormat:@"%@", responseObject[@"result"] ] isEqualToString:@"1"]) {
                [VC ChooseCarClickEvent:[NSMutableArray arrayWithArray:responseObject[@"data"]]];
            }else {
                
                [VC showAlert:@"车辆信息获取失败,请重试"  time:1.0];
                
            }
            NSLog(@"responseObject%@", responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [VC showAlert:@"网络超时请重试"  time:1.0];
            [VC delayMethod];
        }];
        
    
    }
    if (index == 3) {
        //跳转更换认证信息界面
    }
    if (index == 4) {
        //跳转至实名认证界面
    }
}

#pragma mark -- 下面是车辆选择的 方法

//创建一个存在于视图最上层的UIViewController
- (UIViewController *)appRootViewController{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}
- (void)ChooseCarClickEvent:(NSMutableArray *)dataArray{//
    
    //xia面是弹窗的初始化
    UIViewController *topVC = [self appRootViewController];
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.3f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
        tapGesture.numberOfTapsRequired=1;
        [self.backImageView addGestureRecognizer:tapGesture];
    }
    [topVC.view addSubview:self.backImageView];
    
    self.FPickerView = [[CarChooseView alloc] initWithFrame:CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200))];
    _FPickerView.delegate = self;
    _FPickerView.DataArray = dataArray;
    
    
    [topVC.view addSubview:_FPickerView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth-kFit(200), kScreen_widht, kFit(200));
    }];
    
}
-(void)hiddenView {
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
      
}
/**
 *确定
 */
- (void)ChooseCar:(NSDictionary *)carDic {
    
    self.ChooseCarStr = carDic[@"carType"];
    
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    [self.tableView reloadData];
}
/**
 *取消
 */
- (void)deselect {
    [self.backImageView removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        _FPickerView.frame = CGRectMake(0, kScreen_heigth, kScreen_widht, kFit(200));
    }];
    
}
//系统提示的弹出窗
- (void)timerFireMethod:(NSTimer*)theTimer {//弹出框
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message time:(CGFloat)time{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}

@end
