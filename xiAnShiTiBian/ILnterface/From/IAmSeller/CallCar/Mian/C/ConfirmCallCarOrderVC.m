//
//  ConfirmCallCarOrderVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ConfirmCallCarOrderVC.h"
#import "PublicTVOneCell.h"
#import "ForecastPriceTVCell.h"

#import "ShopWaitDeliveryVC.h"
@interface ConfirmCallCarOrderVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *DataArray;
@property (nonatomic, strong)NSArray *FahrzeugmodellArray;
/**
 *车型选择时的背景色
 */
@property (nonatomic, strong)UIView *backImageView;

/**
 *选择的当前车型str
 */
@property (nonatomic, strong)NSString *ChooseCarStr;


@end

@implementation ConfirmCallCarOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"确定叫车订单";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = [UIColor orangeColor];
    [self creatTableView];

}
- (void)handleReturn {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth-0) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = MColor(238, 238, 238);
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_tableView registerClass:[PublicTVOneCell class] forCellReuseIdentifier:@"PublicTVOneCell"];
    [_tableView registerClass:[ForecastPriceTVCell class] forCellReuseIdentifier:@"ForecastPriceTVCell"];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        ForecastPriceTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastPriceTVCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.ForecastPriceBtn setTitle:@"提交" forState:(UIControlStateNormal)];
        cell.backgroundColor = MColor(238, 238, 238);
        return cell;
    }else {
        PublicTVOneCell *cell= [tableView dequeueReusableCellWithIdentifier:@"PublicTVOneCell" forIndexPath:indexPath];
        NSArray *contentArray = @[@"北京-天安门", @"杭州-武林门", @"小型火车", @"￥120.00"];
        [cell CellControlsAssignment:indexPath content:contentArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    if (indexPath.row == 4) {
        UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"恭喜你!" message:@"订单提交成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"好的,我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[ShopWaitDeliveryVC class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }
        }];
        // 3.将“取消”和“确定”按钮加入到弹框控制器中
        [alertV addAction:cancle];
        // 4.控制器 展示弹框控件，完成时不做操作
        [self presentViewController:alertV animated:YES completion:^{
            nil;
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return kFit(70);
    }else {
        return kFit(48);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
