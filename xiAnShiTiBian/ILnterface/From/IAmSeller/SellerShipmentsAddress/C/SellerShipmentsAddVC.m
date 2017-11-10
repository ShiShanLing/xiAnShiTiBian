//
//  SellerShipmentsAddVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerShipmentsAddVC.h"
#import "SellerSATVCell.h"
#import "NewSAVC.h"//编辑或者添加收货地址

@interface SellerShipmentsAddVC ()<UITableViewDelegate, UITableViewDataSource, SellerSATVCellDelegate>

@property (nonatomic,strong)UITableView *tableView;
/**
 *cocodata数据解析和保存对象
 */
@property (nonatomic, strong)NSMutableArray *addressArray;

@end
/**
 *只是数据请求写好了 交互还没有写
 */
@implementation SellerShipmentsAddVC

- (NSMutableArray *)addressArray {
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestSellerShipmentsAddressData];
    [self configurationNavigationBar];
    [self setTableView];
    UIButton *bottomBtn = [UIButton new];
    bottomBtn.backgroundColor = kNavigation_Color;
    [bottomBtn setTitle:@"添加新地址" forState:(UIControlStateNormal)];
    
    bottomBtn.titleLabel.textColor = MColor(255, 255, 255);
    bottomBtn.titleLabel.font = MFont(kFit(18));
    [bottomBtn addTarget:self action:@selector(handleBottomBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:bottomBtn];
    bottomBtn.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(kFit(55)).bottomSpaceToView(self.view, 0);
}

-(void)requestSellerShipmentsAddressData {
    [_addressArray removeAllObjects];
    NSString *URL_Str = [NSString stringWithFormat:@"%@/daddress/api/daddressList", kSHY_100];
    NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
    URL_DIC[@"storeId"] = @"1";
    __block SellerShipmentsAddVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:URL_Str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@", responseObject);
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC encapsulationModel:responseObject[@"data"]];
        }else {
            [VC showAlert:@"获取失败请重试"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@",error);
    }];
}

- (void)encapsulationModel:(NSArray *)dataArray {
    NSLog(@"dataArray%@", dataArray);
    for (int i = 0; i<dataArray.count; i++) {
        NSEntityDescription *des = [NSEntityDescription entityForName:@"SellerShipAddressModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        SellerShipAddressModel *model = [[SellerShipAddressModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        NSMutableDictionary *dataDic = dataArray[i];
        for (NSString *key in dataDic){
            NSLog(@"dataDic%@---%@", dataDic[key], key);
            [model setValue:dataDic[key] forKey:key];
        }
        [self.addressArray addObject:model];
    }
    NSLog(@"encapsulationModel--%@", _addressArray);
    [self.tableView reloadData];
}

- (void)configurationNavigationBar{
    self.view.backgroundColor = MColor(134,134,134);
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];//导航条颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];//改变导航条标题的颜色与大小
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];//去除导航条上图片的渲染色
    self.navigationItem.title = @"发货地址列表";
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
}
//返回上一界面
- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth-kFit(55)) style:(UITableViewStylePlain)];
    
    _tableView.delegate =self;
    // _tableView.bounces = NO;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[SellerSATVCell class] forCellReuseIdentifier:@"SellerSATVCell"];
    [self.view addSubview:_tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _addressArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerSATVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SellerSATVCell" forIndexPath:indexPath];
    [cell BtnTagAssignment:indexPath];
    cell.model = _addressArray[indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
///删除收货地址
- (void)ShoppingAddDeleteBtn:(OrderBtn *)sender {
    
    NSLog(@"ShoppingAddDeleteBtn%ld", (long)sender.indexPath.row);
    
    SellerShipAddressModel *model = _addressArray[sender.indexPath.row];
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/daddress/api/deleteDaddressById", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"addressId"] = model.addressId;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block SellerShipmentsAddVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@",responseObject);
        [_addressArray removeObjectAtIndex:sender.indexPath.row];
        [VC.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@", error);
    }];
}

#pragma mark -- SellerSATVCellDelegate
- (void)ModifyDefaultShippingAddress:(OrderBtn *)sender {
    
    SellerShipAddressModel *model = _addressArray[sender.indexPath.row];
    NSString *URL_Str = [NSString stringWithFormat:@"%@/daddress/api/defaultDaddress", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"storeId"] = [UserDataSingleton mainSingleton].storeID;
    URL_Dic[@"addressId"] = model.addressId;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block SellerShipmentsAddVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@",responseObject);
        [VC showAlert:responseObject[@"msg"]];
        
        [VC requestSellerShipmentsAddressData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@",error);
    }];
}
//编辑收货地址
- (void)ShoppingAddEditorBtn:(OrderBtn *)sender {
    
    SellerShipAddressModel *model = _addressArray[sender.indexPath.row];
    NewSAVC*VC = [[NewSAVC alloc] init];
    VC.roleStr = @"2";
    VC.SellerModel = model;
    //NSLog(@"ShoppingAddEditorBtn%@",model);
    [self.navigationController pushViewController:VC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return kFit(163);
    }else {
        return kFit(173);
    }
}
//添加新地址
- (void)handleBottomBtn {
    NewSAVC*VC = [[NewSAVC alloc] init];
    VC.roleStr = @"2";
    [self.navigationController pushViewController:VC animated:YES];
}
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


@end
