//
//  TextGoodsDetailsVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/2.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "TextGoodsDetailsVC.h"
#import "OrdersCurrentStateCell.h"//订单状态

#import "OrderReceivingAddCell.h"//收货地址
@interface TextGoodsDetailsVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation TextGoodsDetailsVC
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerNib:[UINib nibWithNibName:@"OrdersCurrentStateCell" bundle:nil] forCellReuseIdentifier:@"OrdersCurrentStateCell"];
        [_tableView registerClass:[OrderReceivingAddCell class] forCellReuseIdentifier:@"OrderReceivingAddCell"];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"模拟商品详情";
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 2;
    }else if(section == 1){
    
        return 5;
    }else {
        return 10;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        OrdersCurrentStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrdersCurrentStateCell" forIndexPath:indexPath];
        return cell;
    }else {
        OrderReceivingAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderReceivingAddCell" forIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {





}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    }else {
        return 111;
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
