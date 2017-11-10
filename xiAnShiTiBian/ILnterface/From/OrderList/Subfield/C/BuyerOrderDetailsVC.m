//
//  BuyerOrderDetailsVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "BuyerOrderDetailsVC.h"
#import "OrdersCurrentStateCell.h"
#import "BuyersOrderDetailsCell.h"

#import "ConfirmShippingAddressTVCell.h"
#import "COSNTableViewCell.h"
#import "ConfirmOrderGoodsTVCell.h"
@interface BuyerOrderDetailsVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *mainTableView;

@property (nonatomic, copy)NSMutableArray *dataArray;

@end

@implementation BuyerOrderDetailsVC

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_mainTableView registerClass:[ConfirmShippingAddressTVCell class] forCellReuseIdentifier:@"ConfirmShippingAddressTVCell"];
        [_mainTableView registerClass:[COSNTableViewCell class] forCellReuseIdentifier:@"COSNTableViewCell"];
        [_mainTableView registerClass:[ConfirmOrderGoodsTVCell class] forCellReuseIdentifier:@"ConfirmOrderGoodsTVCell"];
        [_mainTableView registerNib:[UINib nibWithNibName:@"BuyersOrderDetailsCell" bundle:nil] forCellReuseIdentifier:@"BuyersOrderDetailsCell"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看订单";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = MColor(238, 238, 238);
    [self.view addSubview: self.mainTableView];
    [self requestData];
}

- (void) requestData{
    [self indeterminateExample];
    NSString *URL_Str = [NSString stringWithFormat:@"%@/orderapi/orderdetail", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    [URL_Dic setObject:self.orderID forKey:@"orderId"];
    NSLog(@"URL_Str%@URL_Dic%@",URL_Str, URL_Dic);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __weak BuyerOrderDetailsVC *VC = self;
    [session  POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC delayMethod];
        NSLog(@"responseObject%@", responseObject);
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC parsingData:responseObject[@"data"]];
        }else {
            [VC showAlert:@"数据获取失败请重试!" time:1.0];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC delayMethod];
        [VC showAlert:@"请求失败请重试" time:1.0];
        NSLog(@"error%@", error);
    }];
    
}


- (void)parsingData:(NSArray *)array {
    
    NSDictionary *dic1 = array[0];
    NSDictionary *dic2 = dic1[@"order"];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"OrderDetailsModel" inManagedObjectContext:self.managedContext];
    //根据描述 创建实体对象
    OrderDetailsModel *orderModel = [[OrderDetailsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
   
    for (NSString *orderKey in dic2) {
        if ([orderKey isEqualToString:@"orderGoodsList"]) {
            NSArray *goodsListArray = dic2[orderKey];
            NSMutableArray *GoodsModelArray = [NSMutableArray array];
            for (NSDictionary * goodsDic in goodsListArray) {
                NSEntityDescription *des = [NSEntityDescription entityForName:@"ShoppingCartGoodsModel" inManagedObjectContext:self.managedContext];
                //根据描述 创建实体对象
                ShoppingCartGoodsModel *goodsModel = [[ShoppingCartGoodsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                
                for (NSString *goodsKey in goodsDic) {
                    [goodsModel setValue:goodsDic[goodsKey] forKey:goodsKey];
                }
                [GoodsModelArray addObject:goodsModel];
            }
            [orderModel setValue:GoodsModelArray forKey:orderKey];
        }else if ([orderKey isEqualToString:@"address"]){
            NSEntityDescription *des = [NSEntityDescription entityForName:@"ShippingAddressModel" inManagedObjectContext:self.managedContext];
            //根据描述 创建实体对象
            ShippingAddressModel *addressModel = [[ShippingAddressModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        
            for (NSString *addressKey in dic2[orderKey]) {
                [addressModel setValue:dic2[orderKey][addressKey] forKey:addressKey];
            }
            NSMutableArray *addressArray= [NSMutableArray array];
            [addressArray addObject:addressModel];
            [orderModel setValue:addressArray forKey:orderKey];
        }else {
            [orderModel setValue:dic2[orderKey] forKey:orderKey];
        }
    }
    [self.dataArray addObject:orderModel];
    NSLog(@"dataArray%@", self.dataArray);
    [self.mainTableView reloadData];
}

- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataArray.count == 0) {
        return 0;
    }else {
        return 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        OrderDetailsModel *model = self.dataArray[0];
        NSArray *goodsArray = (NSArray *)model.orderGoodsList;
        return goodsArray.count+1;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            OrderDetailsModel *model = self.dataArray[0];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = MColor(245, 245, 245);
            UILabel *stateLabel = [[UILabel alloc] init];
            int orderState = model.orderState.intValue;
            switch (orderState) {
                case 0://待定运费
                    stateLabel.text = @"订单已取消";
                    break;
                case 5://待定运费
                    stateLabel.text = @"待计算运费";
                    break;
                case 10://带付款
                    stateLabel.text = @"待买家付款";
                    break;
                case 20://待发货
                    stateLabel.text = @"待商家发货";
                    break;
                case 25://待发货
                    stateLabel.text = @"待商家发货";
                    break;
                case 26://待发货
                    stateLabel.text = @"待商家发货";
                    break;
                case 28://待收货
                    stateLabel.text = @"待买家发货";
                    break;
                case 30://待收货
                    stateLabel.text = @"待买家发货";
                    break;
                case 40://待评价
                    stateLabel.text = @"待评价";
                    break;
                case 50://待评价
                    stateLabel.text = @"待评价";
                    break;
                case 60://待评价
                    stateLabel.text = @"待评价";
                    break;
                    
                default:
                    break;
            }

            stateLabel.font = MFont(kFit(17));
            [cell addSubview:stateLabel];
            stateLabel.sd_layout.widthIs(kFit(200)).heightIs(kFit(17)).centerXEqualToView(cell).centerYEqualToView(cell);
            
            UIButton *stateBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [stateBtn setImage:[UIImage imageNamed:@"fwb"] forState:(UIControlStateNormal)];
            [cell addSubview:stateBtn];
            stateBtn.sd_layout.rightSpaceToView(stateLabel, kFit(10)).centerYEqualToView(cell).widthIs(kFit(19)).heightIs(kFit(19));
            return cell;
        }else {
            ConfirmShippingAddressTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmShippingAddressTVCell" forIndexPath:indexPath];
            OrderDetailsModel *model = self.dataArray[0];
            NSArray *addressArray = (NSArray *)model.address;
            ShippingAddressModel *addressModel = addressArray[0];
            cell.model = addressModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.section == 1) {
        OrderDetailsModel *model = self.dataArray[0];
        if (indexPath.row == 0) {
            COSNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"COSNTableViewCell" forIndexPath:indexPath];
            cell.stopName.text = model.storeName;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            ConfirmOrderGoodsTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmOrderGoodsTVCell" forIndexPath:indexPath];
            NSArray *goodsArray = (NSArray *)model.orderGoodsList;
            NSLog(@"goodsArray%@ indexPath.row%ld", goodsArray, (long)indexPath.row);
            ShoppingCartGoodsModel * goodsModel = goodsArray[indexPath.row - 1];
            cell.model = goodsModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            }
    }else{
        BuyersOrderDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyersOrderDetailsCell" forIndexPath:indexPath];
        OrderDetailsModel *model = self.dataArray[0];
        cell.model = model;
        return cell;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kFit(103);
        }else {
            return kFit(111);
        }
    }else if (indexPath.section==1) {
        if (indexPath.row == 0) {
            return kFit(50);
        }else {
            return kFit(113);
        }
    }else {
        return 303;
    }
}


@end
