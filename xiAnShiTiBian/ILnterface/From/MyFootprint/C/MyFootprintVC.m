//
//  MyFootprintVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/16.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MyFootprintVC.h"
#import "MyFootprintTVCell.h"
#import "EditorMyFootprintTVCell.h"
#import "FootprintEmptyTVCell.h"
static int editorState;
@interface MyFootprintVC ()<UITableViewDataSource, UITableViewDelegate, FootprintEmptyTVCellDelegate, NotLoggedInTableViewCellDelegate, NoInternetTVCellDelegate>
@property (nonatomic, strong)UITableView *tableView;
//足迹数量
@property (nonatomic, strong)UILabel * GoodsNumLabel;
/**
 *编辑状态的删除view
 */
@property (nonatomic, strong)UIView *deleteView;
//存储数据的数组
@property (nonatomic, strong)NSMutableArray *DataArray;
/**
 *cocodata数据解析和保存对象
 */
@property (strong, nonatomic)AppDelegate *AppDelegate;
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@end

@implementation MyFootprintVC
- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {
        //获取Appdelegate对象
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedContext = delegate.managedObjectContext;
    }
    return _managedContext;
}
- (AppDelegate *)AppDelegate {
    if (!_AppDelegate) {
        _AppDelegate = [[AppDelegate alloc] init];
    }
    return _AppDelegate;
}
- (NSMutableArray *)DataArray {
    if (!_DataArray) {
        _DataArray = [NSMutableArray array];
    }
    return _DataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [super.navigationController setNavigationBarHidden:NO];
    editorState = 0;
    if ([UserDataSingleton mainSingleton].AppKey.length == 0) {
        [self.DataArray removeAllObjects];
        [self.tableView reloadData];
    }else {
        [self requestData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurationNavigationBar];
    [self configurationTableView];
    [self editorDeleteView];
}
- (void)configurationNavigationBar{
    self.view.backgroundColor = MColor(234, 234, 234);
    self.navigationItem.title = @"我的足迹";
}
- (void)configurationTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = MColor(238, 238, 238);
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [_tableView registerClass:[MyFootprintTVCell class] forCellReuseIdentifier:@"MyFootprintTVCell"];
    [_tableView registerClass:[EditorMyFootprintTVCell class] forCellReuseIdentifier:@"EditorMyFootprintTVCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NotLoggedInTableViewCell" bundle:nil] forCellReuseIdentifier:@"NotLoggedInTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NotLoggedInTableViewCell" bundle:nil] forCellReuseIdentifier:@"NotLoggedInTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NoInternetTVCell" bundle:nil] forCellReuseIdentifier:@"NoInternetTVCell"];
    [self.view addSubview:_tableView];
}

- (void)requestData {
    [self indeterminateExample];
    NSString *URL_Str = [NSString stringWithFormat:@"%@/floor/api/getMemberHistory", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"memberId"] = [UserDataSingleton mainSingleton].userID;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __weak MyFootprintVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC delayMethod];
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC parsingData:responseObject[@"data"]];
        }else {
            [VC showAlert:@"获取失败" time:1.0];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"数据请求失败请重试" time:1.0];
        [VC delayMethod];
    }];
}

- (void)parsingData:(NSArray *)dataArray{
    [self.DataArray removeAllObjects];
    for (NSDictionary *goodsDic in dataArray) {
        NSEntityDescription *des = [NSEntityDescription entityForName:@"FootprintModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        FootprintModel *model = [[FootprintModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        for (NSString *key in goodsDic) {
            if ([key isEqualToString:@"goodsList"]) {
                NSMutableArray *goodsArray = [NSMutableArray array];
                for (NSDictionary * GoodsDetailsDIc in goodsDic[@"goodsList"]) {
                    NSEntityDescription *des = [NSEntityDescription entityForName:@"GoodsDetailsModel" inManagedObjectContext:self.managedContext];
                    //根据描述 创建实体对象
                    GoodsDetailsModel *goodsDetailsModel = [[GoodsDetailsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
             
                    for (NSString *goodsDetailsKey in GoodsDetailsDIc) {
                        [goodsDetailsModel setValue:GoodsDetailsDIc[goodsDetailsKey] forKey:goodsDetailsKey];
                    }
                    [goodsArray addObject:goodsDetailsModel];
                }
                [model setValue:goodsArray forKey:key];
            }else {
                [model setValue:goodsDic[key] forKey:key];
            }
        }
        [self.DataArray addObject:model];
    }
    [self.tableView reloadData];
    NSLog(@"DataArray%@", _DataArray);
    _GoodsNumLabel.text = [NSString stringWithFormat:@"全部宝贝(%lu)", (unsigned long)_DataArray.count];
}
//编辑按钮
- (void)handleEditorBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _deleteView.hidden = NO;
        editorState = 1;
    }else {
        _deleteView.hidden = YES;
        editorState = 0;
    }
    [self.tableView reloadData];
}

- (void)editorDeleteView {
    self.deleteView = [UIView new];
    _deleteView.hidden = YES;
    [self.view addSubview:_deleteView];
    _deleteView.sd_layout.leftSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(kFit(48));
    UIButton *allDeleteBtn = [UIButton new];
    allDeleteBtn.backgroundColor = MColor(95, 100, 97);
    [allDeleteBtn setTitle:@"全部删除" forState:(UIControlStateNormal)];
    [allDeleteBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
    [allDeleteBtn addTarget:self action:@selector(handleAllDeleteBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [_deleteView addSubview:allDeleteBtn];
    allDeleteBtn.sd_layout.leftSpaceToView(_deleteView, 0).topSpaceToView(_deleteView, 0).bottomSpaceToView(_deleteView, 0).widthIs(kScreen_widht/2);
    UIButton *chooseDeleteBtn = [UIButton new];
    chooseDeleteBtn.backgroundColor = kNavigation_Color;
    [chooseDeleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
    [chooseDeleteBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
    [chooseDeleteBtn addTarget:self action:@selector(handleChooseDeleteBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [_deleteView addSubview:chooseDeleteBtn];
    chooseDeleteBtn.sd_layout.leftSpaceToView(allDeleteBtn, 0).topSpaceToView(_deleteView, 0).bottomSpaceToView(_deleteView, 0).widthIs(kScreen_widht/2);
    
}
/**
 *全部收藏商品删除
 */
- (void)handleAllDeleteBtn:(UIButton *)sender {
    
    [_DataArray removeAllObjects];
    [self.tableView reloadData];
}
/**
 *删除选中的商品
 */
- (void)handleChooseDeleteBtn:(UIButton *)sender {
    NSArray *array = [NSMutableArray arrayWithArray:_DataArray];
    [_DataArray removeAllObjects];
    NSLog(@"%@---%@ 删除测试", _DataArray, array);
    for (int i = 0 ; i <array.count; i ++) {
        NSString *str = array[i];
        if ([str isEqualToString:@"1"]) {//吧选择的商品ID放到一个数组里面
        }else {
            [_DataArray addObject:array[i]];
        }
    }
    [self.tableView reloadData];
}
//更多
- (void)handleCollect {
    MessageViewController *VC = [[MessageViewController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}
//返回上一界面
- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_DataArray.count == 0) {
        return 1;
    }else {
        return _DataArray.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_DataArray.count == 0) {
        return 1;
    }else if([UserDataSingleton mainSingleton].networkState == 0){
        return 1;
    }else{
        FootprintModel *fModel = _DataArray[section];
        NSArray *goodsArr = (NSArray*)fModel.goodsList;
        return goodsArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([UserDataSingleton mainSingleton].networkState == 0){
        NoInternetTVCell *cell= [tableView dequeueReusableCellWithIdentifier:@"NoInternetTVCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else {
        if ([UserDataSingleton mainSingleton].userID.length == 0) {
            NotLoggedInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotLoggedInTableViewCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            if (_DataArray.count == 0) {
                //空空如也
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
                cell.backgroundColor = MColor(238, 238, 238);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shoppingCart_empty"]];
                imageView.backgroundColor = MColor(238, 238, 238);
                UILabel *titleLabel = [[UILabel alloc] init];
                titleLabel.text = @"足迹为空";
                titleLabel.textAlignment = 1;
                titleLabel.textColor = MColor(51, 51, 51);
                titleLabel.font = MFont(kFit(15));
                [cell addSubview:imageView];
                [cell addSubview:titleLabel];
                imageView.sd_layout.widthIs(100).heightIs(100).centerXEqualToView(cell).centerYEqualToView(cell);
                titleLabel.sd_layout.leftSpaceToView(cell, 0).topSpaceToView(imageView, kFit(10)).rightSpaceToView(cell, 0).heightIs(kFit(15));
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else {
                FootprintModel *fModel = _DataArray[indexPath.section];
                NSArray *goodsArr = (NSArray*)fModel.goodsList;
                MyFootprintTVCell *cell= [tableView dequeueReusableCellWithIdentifier:@"MyFootprintTVCell" forIndexPath:indexPath];
                GoodsDetailsModel *model = goodsArr[indexPath.row];
                cell.model = model;
                cell.selectionStyle= UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_DataArray.count == 0) {
        
    }else {
        FootprintModel *fModel = _DataArray[indexPath.section];
        NSArray *goodsArr = (NSArray*)fModel.goodsList;
        GoodsDetailsModel *model = goodsArr[indexPath.row];
        
        GoodsDetailsVController *VC = [[GoodsDetailsVController alloc] init];
        [VC setHidesBottomBarWhenPushed:YES];
        VC.goodsID = model.goodsId;
        [self.navigationController pushViewController:VC animated:YES];
    }
}
#pragma mark  没有网络或者没有登录时的代理方法
-(void)refreshView {
    [self requestData];
}

-(void)handleLogInBtn{
    LogInViewController *VC = [[LogInViewController alloc] init];
    UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
    [VC setHidesBottomBarWhenPushed:YES];
    [self presentViewController:NAVC animated:YES completion:nil];
}

- (void)handleStateBtn:(UIButton *)sender {
    LogInViewController *VC = [[LogInViewController alloc] init];
    UINavigationController *NAVC = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:NAVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([UserDataSingleton mainSingleton].networkState == 0){
        return kScreen_widht;
    }else{
        if ([UserDataSingleton mainSingleton].userID.length == 0) {
            return kScreen_widht;
        }else {
            if (_DataArray.count == 0) {
                return kScreen_heigth;
            }else {
                return kFit(127);
            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_DataArray.count == 0) {
        return nil;
    }else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, 20)];
        view.backgroundColor = MColor(234, 234, 234);
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreen_widht-10, 20)];
        titleLabel.font = MFont(kFit(12));
        titleLabel.textColor = MColor(51, 51, 51);
        FootprintModel *fModel = _DataArray[section];
        titleLabel.text = fModel.create_time_str;
        [view addSubview:titleLabel];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}
@end
