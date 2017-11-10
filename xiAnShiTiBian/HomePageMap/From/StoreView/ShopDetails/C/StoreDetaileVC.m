//
//  StoreDetaileVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/27.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "StoreDetaileVC.h"

#import "StoreDetailsTVCell.h"

@interface StoreDetaileVC ()<UITableViewDelegate, UITableViewDataSource>
/**
 *店铺信息tableView;
 */
@property (nonatomic, strong)UITableView *StoreITableView;
/**
 *存储店铺信息的NSDIC
 */
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)StoreRankingListModel *storeModel;

@end

@implementation StoreDetaileVC

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAllAndStoreITV];
}
- (void)setAllAndStoreITV {
    self.StoreITableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth-49-40.5) style:(UITableViewStylePlain)];
    self.StoreITableView.delegate = self;
    self.StoreITableView.dataSource = self;
    self.StoreITableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.StoreITableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.StoreITableView registerClass:[StoreDetailsTVCell class] forCellReuseIdentifier:@"StoreDetailsTVCell"];
    [self.view addSubview:_StoreITableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreDetailsTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreDetailsTVCell"];
    NSArray *array = @[@"店铺简介", @"开店时间", @"联系电话", @"店铺地址"];
    cell.nameLabel.text = array[indexPath.row];
    
    cell.contentLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*如果程序卡在了这里很可能是由于你用了“dequeueReusableCellWithIdentifier:forIndexPath:”方法来重用cell，换成““dequeueReusableCellWithIdentifier:”（不带IndexPath）方法即可解决*/
    //int index = (int)(indexPath.row % 5);
    
    if (indexPath.row == 0) {
        return  [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:[self cellContentViewWith] tableView:tableView];
    }else{
        
        return 45;
    }
}
- (CGFloat)cellContentViewWith {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

-(void)setModel:(StoreRankingListModel *)model {
    self.storeModel = model;
    [self.dataArray addObject:@"欢迎光临本店，本店新开张，诚信经营，只赚信誉不赚钱。 本店商品均属正品，假一罚十信誉保证。 欢迎广大顾客前来放心选购，我们将竭诚为您服务! 本店专门营销什么什么商品，假一罚十信誉保证。本店的服务宗旨是用心服务，以诚待人"];
    [self.dataArray addObject:model.createTimeStr];
    [self.dataArray addObject:model.storeTel.length == 0 ?model.storeTel:@"商家没有留下电话"];
    [self.dataArray addObject:[NSString stringWithFormat:@"%@%@", model.storeAddress,model.areaInfo]];
    [self.StoreITableView reloadData];
    
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
