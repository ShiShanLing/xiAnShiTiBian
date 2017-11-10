//
//  ChangeSAVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/17.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ChangeSAVC.h"
#import "ChangeSATVTwoCell.h"
#import "NewSAVC.h"//编辑或者添加收货地址
/**
 *修改默认收货地址
 */
@interface ChangeSAVC ()<UITableViewDelegate, UITableViewDataSource, ChangeSATVTwoCellDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *DataArray;

@end

@implementation ChangeSAVC


- (NSMutableArray *)DataArray {
    if (!_DataArray) {
        _DataArray = [NSMutableArray array];
    }
    return _DataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [_DataArray removeAllObjects];
    [self AnalyticalData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)AnalyticalData {
    [self indeterminateExample];
    NSString *url_str = [NSString stringWithFormat:@"%@/address/api/addressList", kSHY_100];
   // NSLog(@"url_str%@", url_str);
    NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
   
    
    URL_DIC[@"memberId"]=[UserDataSingleton mainSingleton].userID;
    __block ChangeSAVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:url_str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC delayMethod];
        [VC encapsulationModel:responseObject[@"data"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC delayMethod];
        [VC showAlert:@"请求失败请重试" time:1.0];
    }];
    
}

- (void)encapsulationModel:(NSArray *)dataArray {
    [self.DataArray removeAllObjects];
    for (int i = 0; i<dataArray.count; i++) {
        NSEntityDescription *des = [NSEntityDescription entityForName:@"ShippingAddressModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        ShippingAddressModel *model = [[ShippingAddressModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        NSMutableDictionary *dataDic = dataArray[i];
        for (NSString *key in dataDic){
                [model setValue:dataDic[key] forKey:key];
        }
        [self.DataArray addObject:model];
    }
    [self.tableView reloadData];
    
}

- (void)configurationNavigationBar{
    self.view.backgroundColor = MColor(134,134,134);
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];//导航条颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];//改变导航条标题的颜色与大小
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];//去除导航条上图片的渲染色
    self.navigationItem.title = @"收货地址列表";
    
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
    [_tableView registerClass:[ChangeSATVTwoCell class] forCellReuseIdentifier:@"ChangeSATVTwoCell"];
    [self.view addSubview:_tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChangeSATVTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChangeSATVTwoCell" forIndexPath:indexPath];
    ShippingAddressModel *model = self.DataArray[indexPath.row];
    
    [cell BtnTagAssignment:indexPath model:model];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
//修改默认收货地址
- (void) ChangeDefaultShippingAddress:(UIButton *)sender{
    [self indeterminateExample];
    NSString *url_str = [NSString stringWithFormat:@"%@/address/api/updateAddressDef", kSHY_100];
    
    NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
    URL_DIC[@"memberId"]=[UserDataSingleton mainSingleton].userID;
    ShippingAddressModel *model = self.DataArray[sender.tag];
    URL_DIC[@"addressId"] =model.addressId;
    NSLog(@"url_str%@  URL_DIC%@   ---nihao%ld", url_str,URL_DIC, (long)sender.tag);
    __block ChangeSAVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:url_str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //  NSLog(@"responseObject%@", responseObject);
                [VC delayMethod];
        NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        NSLog(@"%@", str);
        if ([str isEqualToString:@"1"]) {
            [VC showAlert:@"修改成功"];
            [VC AnalyticalData];
        }else {
            [VC showAlert:@"修改失败请重试"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC delayMethod];
        [VC showAlert:@"请求失败请重试" time:1.0];
    }];
}

//编辑收货地址
- (void)ShoppingAddEditorBtn:(OrderBtn *)sender {
    
    NewSAVC*VC = [[NewSAVC alloc] init];
    VC.AddressState = 2;//代表编辑地址
    VC.roleStr = @"1";
    VC.model = self.DataArray[sender.tag];
    [self.navigationController pushViewController:VC animated:YES];
}
//删除收货地址
- (void)ShoppingAddDeleteBtn:(OrderBtn *)sender {
    
    NSString *url_str = [NSString stringWithFormat:@"%@/address/api/delAddress", kSHY_100];
    NSMutableDictionary *URL_DIC = [NSMutableDictionary dictionary];
    ShippingAddressModel *model = self.DataArray[sender.tag];
    
  //  NSLog(@"ShoppingAddDeleteBtn%ld", sender.tag);
    URL_DIC[@"addressId"]=model.addressId;
    
    __block ChangeSAVC *VC = self;
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"警告!" message:@"确认删除吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [VC indeterminateExample];
               AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session POST:url_str parameters:URL_DIC progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"uploadProgress%@", uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [VC delayMethod];
            NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
            if ([str isEqualToString:@"1"]) {
                [VC showAlert:@"删除成功"];
                [VC.DataArray removeObjectAtIndex:sender.tag];
            }else {
                [VC showAlert:@"删除失败请重试"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [VC delayMethod];
            [VC showAlert:@"网络超时请重试"];
        }];
        [self.tableView reloadData];
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    // 3.将“取消”和“确定”按钮加入到弹框控制器中
    [alertV addAction:cancle];
    [alertV addAction:confirm];
    // 4.控制器 展示弹框控件，完成时不做操作
    [self presentViewController:alertV animated:YES completion:^{
    }];
    
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
    VC.AddressState = 1;
    VC.roleStr = @"1";
    [self.navigationController pushViewController:VC animated:YES];
}



@end
