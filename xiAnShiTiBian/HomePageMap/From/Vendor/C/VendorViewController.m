//
//  VendorViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "VendorViewController.h"
#import "VendorIntroduceTVCell.h"//厂商信息介绍
#import "SrosswiseSlipTVCell.h"
#import "VendorGoodsTVCell.h"//厂商的产品
#import "VendorEngineeringDrawingTVCell.h"//厂商的工程图
#import "VendorAllGoodsVC.h"//厂商所有的产品界面
#import "VendorEngineeringVC.h"//厂商内的工程图展示

@interface VendorViewController ()<UITableViewDelegate, UITableViewDataSource, VendorGoodsTVCellDelegate, VendorEngineeringDrawingTVCellDelegate, SrosswiseSlipTVCellDelegate>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation VendorViewController



- (NSMutableArray *)vendorArray {
    if (!_vendorArray) {
        _vendorArray = [NSMutableArray array];
    }
    return _vendorArray;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super.navigationController setNavigationBarHidden:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MColor(234, 234, 234);
    [self configurationNavigationBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VendorIntroduceTVCell class] forCellReuseIdentifier:@"VendorIntroduceTVCell"];
    [self.tableView registerClass:[SrosswiseSlipTVCell class] forCellReuseIdentifier:@"SrosswiseSlipTVCell"];
    [self.tableView registerClass:[VendorGoodsTVCell class] forCellReuseIdentifier:@"VendorGoodsTVCell"];
     [self.tableView registerClass:[VendorEngineeringDrawingTVCell class] forCellReuseIdentifier:@"VendorEngineeringDrawingTVCell"];
    [self.view addSubview:self.tableView];
    
}

- (void)configurationNavigationBar {
    self.navigationItem.title = @"厂家";
    
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    self.navigationController.navigationBar.barTintColor = kNavigation_whrColor;//导航条颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//去除导航条上图片的渲染色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color,NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];

}

- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
           return 3;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        VendorIntroduceTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VendorIntroduceTVCell" forIndexPath:indexPath];
        cell.model = self.vendorArray[0];
        return cell;
    }else if(indexPath.row == 1){
        SrosswiseSlipTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SrosswiseSlipTVCell" forIndexPath:indexPath];
        FactoryDataModel *model = self.vendorArray[0];
        [cell deliveryData:model.listStore];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else {
        VendorGoodsTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VendorGoodsTVCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.model = self.vendorArray[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
    return 224;
    }else if(indexPath.row == 1){
        return 210;
    }else if(indexPath.row == 2){
        return kFit(580);
    }else {
        return kFit(440);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
}
#pragma mark SrosswiseSlipTVCellDelegate  跳转(经销商)商家界面
- (void)ClickStoreIndex:(int)index {
    StoreViewController *VC = [[StoreViewController alloc] init];
    
    FactoryDataModel *model = self.vendorArray[0];
    NSArray *array = (NSArray *)model.listStore;
    SellerDataModel *sellerModel = array[index];
    VC.storeStr = sellerModel.storeId;
    [self.navigationController pushViewController:VC animated:YES];

}
#pragma mark VendorGoodsTVCellDelegate

//更多产品
- (void)MoreProducts {
    VendorAllGoodsVC *VC = [[VendorAllGoodsVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];

}
#pragma mark VendorEngineeringDrawingTVCellDelegate
//更多工程图展示
-(void)MoreEngineering {
    
    VendorEngineeringVC *VC = [[VendorEngineeringVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}



@end
