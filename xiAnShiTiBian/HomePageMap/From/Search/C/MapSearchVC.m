
//
//  MapSearchVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MapSearchVC.h"
#import "CXSearchSectionModel.h"
#import "CXSearchModel.h"
#import "CXSearchCollectionViewCell.h"
#import "SelectCollectionReusableView.h"
#import "SelectCollectionLayout.h"
#import "CXDBHandle.h"
#import "MapSearchView.h"
#import "JHDownMenuView.h"//弹窗(选择搜索类型)
#import "SearchGoodsVC.h"
#import "SearchStoreVC.h"
#define  kScreen_heigth [UIScreen mainScreen].bounds.size.height//屏幕高度
#define  kScreen_widht  [UIScreen mainScreen].bounds.size.width//屏幕高度

static NSString *const cxSearchCollectionViewCell = @"CXSearchCollectionViewCell";

static NSString *const headerViewIden = @"HeadViewIden";
@interface MapSearchVC ()<UICollectionViewDataSource,UICollectionViewDelegate,SelectCollectionCellDelegate,UICollectionReusableViewButtonDelegate, UITextFieldDelegate, JHDownMenuViewDelegate, MapSearchViewDelegate>
/**
 *  存储网络请求的热搜，与本地缓存的历史搜索model数组
 */
@property (nonatomic, strong) NSMutableArray *sectionArray;
/**
 *  存搜索的数组 字典
 */
@property (nonatomic,strong) NSMutableArray *searchArray;

@property (nonatomic, strong) UICollectionView *cxSearchCollectionView;

@property (nonatomic, strong) UITextField *cxSearchTextField;

@property (nonatomic,strong)MapSearchView *searchView;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) JHDownMenuView *menuView;
/**
 *存储搜索的类型 个人店 实体店 商品 厂家
 */
@property (nonatomic, strong)NSString *SearchType;

@property (nonatomic, strong)NSManagedObjectContext *managedContext;

@property (nonatomic, strong)AppDelegate *AppDelegate;

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;
/**
 *搜索到的店铺model存放array
 */
@property (nonatomic, strong)NSMutableArray *storeDataArray;
/**
 *搜索的关键字
 */
@property (nonatomic, strong)NSString *SearchKeyWord;
@end

@implementation MapSearchVC

- (NSManagedObjectContext *)managedContext {
    if (!_managedContext) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedContext =  delegate.managedObjectContext;
    }
    return _managedContext;
}
- (AppDelegate *)AppDelegate {
    if (!_AppDelegate) {
        _AppDelegate = [[AppDelegate alloc] init];
    }
    return _AppDelegate;
}


- (NSMutableArray *)storeDataArray {
    if (!_storeDataArray) {
        _storeDataArray = [NSMutableArray array];
    }
    return _storeDataArray;
}

-(NSMutableArray *)sectionArray {
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

-(NSMutableArray *)searchArray {
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    
    self.searchView = [[MapSearchView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, 100)];
    _searchView.delegate = self;
    self.searchView.searchTF.delegate = self;
    [self.searchView.searchTF becomeFirstResponder];
    [self.view addSubview:_searchView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(kScreen_widht, kFit(15));
    self.cxSearchCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, kScreen_widht, kScreen_heigth-100) collectionViewLayout:layout];
    _cxSearchCollectionView.backgroundColor = [UIColor whiteColor];
    _cxSearchCollectionView.delegate = self;
    _cxSearchCollectionView.dataSource = self;
    [self.cxSearchCollectionView setCollectionViewLayout:[[SelectCollectionLayout alloc] init] animated:YES];
    [self.cxSearchCollectionView registerClass:[SelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIden];
    [self.cxSearchCollectionView registerNib:[UINib nibWithNibName:@"CXSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cxSearchCollectionViewCell];
    [self.view addSubview:self.cxSearchCollectionView];
    UITapGestureRecognizer *collrctionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCollectionTap:)];
    [self.cxSearchCollectionView addGestureRecognizer:collrctionTap];
}

-(void)handleCollectionTap:(UITapGestureRecognizer *)tap {
    [self.searchView.searchTF resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:YES];
    self.SearchType = @"keywordSearch";
}
//导航条(自定义)上的取消按钮 返回上一界面
- (void)ReturnOnALayer {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)MapSearchType:(int)tag {
    switch (tag) {
        case 101:
            self.SearchType = @"keywordSearch";
            break;
        case 102:
            self.SearchType = @"enterprise";
            break;
        case 103:
            self.SearchType = @"personal";
            break;
        case 104:
            self.SearchType = @"便民查询";
            break;
        case 105:
            self.SearchType = @"factoryName";
            break;
            
        default:
            break;
    }
}
- (void)prepareData {
    
    NSMutableArray *testArray = [@[] mutableCopy];
    /***  去数据查看 是否有数据*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    NSDictionary *dbDictionary =  [CXDBHandle statusesWithParams:parmDict];
    
    if (dbDictionary.count) {
        [testArray addObject:dbDictionary];
        [self.searchArray addObjectsFromArray:dbDictionary[@"section_content"]];
    }
    
    for (NSDictionary *sectionDict in testArray) {
        CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:sectionDict];
        [self.sectionArray addObject:model];
    }
}
//当界面出现的时候
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.cxSearchTextField becomeFirstResponder];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CXSearchSectionModel *sectionModel =  self.sectionArray[section];
    return sectionModel.section_contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CXSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cxSearchCollectionViewCell forIndexPath:indexPath];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    [cell.contentButton setTitle:contentModel.content_name forState:UIControlStateNormal];
    cell.selectDelegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        SelectCollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIden forIndexPath:indexPath];
        view.delectDelegate = self;
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        [view setText:sectionModel.section_title];
        /***  此处完全 也可以自定义自己想要的模型对应放入*/
        [view setImage:@"cxSearch"];
        view.delectButton.hidden = NO;
        reusableview = view;
    }
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    if (sectionModel.section_contentArray.count > 0) {
        CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        return [CXSearchCollectionViewCell getSizeWithText:contentModel.content_name];
    }
    return CGSizeMake(80, kFit(32));
}

//返回每个cell的布局左右上下间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return  UIEdgeInsetsMake(10, 12, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - SelectCollectionCellDelegate
- (void)selectButttonClick:(CXSearchCollectionViewCell *)cell; {
    
    NSIndexPath* indexPath = [self.cxSearchCollectionView indexPathForCell:cell];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    [self SearchResults:contentModel.content_name];
}

#pragma mark - UICollectionReusableViewButtonDelegate
- (void)delectData:(SelectCollectionReusableView *)view {
    
    [self.sectionArray removeLastObject];
    [self.searchArray removeAllObjects];
    [self.cxSearchCollectionView reloadData];
    [CXDBHandle saveStatuses:@{} andParam:@{@"category":@"1"}];
    
}

#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.cxSearchTextField resignFirstResponder];
}
#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:@"搜索内容不能为空" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"朕知道了!", nil];
        [al show];
        return NO;
    }
    [self SearchResults:[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:textField.text forKey:@"content_name"]]) {
        return YES;
    }
    
    [self reloadData:textField.text];
    
    
    return YES;
}

- (void)reloadData:(NSString *)textString {
    [self.searchArray addObject:[NSDictionary dictionaryWithObject:textString forKey:@"content_name"]];
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":self.searchArray};
    /***由于数据量并不大 这样每次存入再删除没问题  存数据库*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    [CXDBHandle saveStatuses:searchDict andParam:parmDict];
    CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:searchDict];
    [self.sectionArray removeLastObject];
    [self.sectionArray addObject:model];
    [self.cxSearchCollectionView reloadData];
    self.cxSearchTextField.text = @"";
}

//跳转搜索结果界面
- (void)SearchResults:(NSString *)str {
    self.SearchKeyWord = str;
    if (self.SearchType.length == 0) {
        [self showAlert:@"请选择您要搜索的类型"];
    }else {
        //http://localhost:8080/com-zerosoft-boot-assembly-front-local-1.0.0-SNAPSHOT/searchApi/goodsList?searchType=keyword&keyword=%E7%8E%B2&Longitude=120.211326&Latitude=30.259244
        //实体店
        NSString *URL_Str;
        if ([self.SearchType isEqualToString:@"factoryName"]) {
            URL_Str = [NSString stringWithFormat:@"%@/search/factorysList", kSHY_100];
        }else {
            
            URL_Str = [NSString stringWithFormat:@"%@/searchApi/goodsList", kSHY_100];
        }
        NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
        //enterprise
        URL_Dic[@"searchType"] = self.SearchType;
        URL_Dic[@"keyword"] = str;
        URL_Dic[@"Longitude"]=[NSString stringWithFormat:@"%f", _Position.longitude];
        URL_Dic[@"Latitude"] =[NSString stringWithFormat:@"%f", _Position.latitude];
        NSLog(@"URL_Str--%@URL_Dic--%@",URL_Str ,URL_Dic);
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        __block MapSearchVC *VC = self;
        [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"uploadProgress%@",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject%@", responseObject);
            if ([self.SearchType isEqualToString:@"factoryName"]) {
                NSDictionary *dataDic = responseObject[@"lucenePager"];
                NSArray *dataArray = dataDic[@"result"];
                [VC analyticalVenderData:dataArray];
            }else {
                NSArray *dataArray = responseObject[@"lucenePager"];
                NSDictionary * resultDic = dataArray[0];
                [VC AnalyticalStoreData:resultDic];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [VC showAlert:@"数据请求失败,请重试!"];
        }];
    }
}

- (void)analyticalVenderData:(NSArray *)array {
    
    for (NSDictionary *dic in array) {
        NSEntityDescription *des = [NSEntityDescription entityForName:@"FactoryDataModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        FactoryDataModel *model = [[FactoryDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        
        for (NSString *key in dic) {
            if ([key isEqualToString:@"listStore"]) {
                NSArray *storeArray = dic[key];
                NSMutableArray *storeAddArray = [NSMutableArray array];
                for (NSDictionary *storeDic in storeArray) {
                    NSEntityDescription *des = [NSEntityDescription entityForName:@"SellerDataModel" inManagedObjectContext:self.managedContext];
                    //根据描述 创建实体对象
                    SellerDataModel *storeModel = [[SellerDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                    for (NSString *storeKey in storeDic) {
                        [storeModel setValue:storeDic[storeKey] forKey:storeKey];
                    }
                    [storeAddArray addObject:storeModel];
                }
                [model setValue:storeAddArray forKey:key];
            }else if([key isEqualToString:@"listGoods"]){
                
                NSArray *goodsArray = dic[key];
                NSMutableArray *goodsAddArray = [NSMutableArray array];
                for (NSDictionary *goodsDic in goodsArray) {
                    NSEntityDescription *des = [NSEntityDescription entityForName:@"GoodsDetailsModel" inManagedObjectContext:self.managedContext];
                    //根据描述 创建实体对象
                    GoodsDetailsModel *goodsModel = [[GoodsDetailsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                    
                    for (NSString *goodsKey in goodsDic) {
                        [goodsModel setValue:goodsDic[goodsKey] forKey:goodsKey];
                    }
                    [goodsAddArray addObject:goodsModel];
                }
                [model setValue:goodsAddArray forKey:key];
                
                
            }else{
                [model setValue:dic[key] forKey:key];
            }
        }
        [self.storeDataArray addObject:model];
    }
    NSLog(@"self.storeDataArray%@", self.storeDataArray);
    if ([_delegate respondsToSelector:@selector(searchResults:storeArray:)]) {
        [_delegate searchResults:self.SearchType storeArray:self.storeDataArray];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        MapViewController *VC = [[MapViewController alloc] init];
        VC.SearchValue = self.SearchKeyWord;
        VC.storeArray = self.storeDataArray;
    }];
    
}

- (void)AnalyticalStoreData:(NSDictionary *)dic {
    NSLog(@"AnalyticalStoreData%@", dic[@"result"]);
    
    if ([dic[@"result"] isKindOfClass:[NSArray class]]) {
        NSArray *dataArray = dic[@"result"];
        if (dataArray.count == 0) {
            [self showAlert:@"结果为空.请换一个名词搜索"];
            return;
        }
        NSArray * storeArray = dic[@"result"];
        
        if ([self.SearchType isEqualToString:@"factoryName"]) {
            for (NSDictionary *dic in storeArray) {
                NSEntityDescription *des = [NSEntityDescription entityForName:@"FactoryDataModel" inManagedObjectContext:self.managedContext];
                //根据描述 创建实体对象
                FactoryDataModel *model = [[FactoryDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                
                for (NSString *key in dic) {
                    if ([key isEqualToString:@"listStore"]) {
                        NSArray *storeArray = dic[key];
                        NSMutableArray *storeAddArray = [NSMutableArray array];
                        for (NSDictionary *storeDic in storeArray) {
                            NSEntityDescription *des = [NSEntityDescription entityForName:@"SellerDataModel" inManagedObjectContext:self.managedContext];
                            //根据描述 创建实体对象
                            SellerDataModel *storeModel = [[SellerDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                            
                            for (NSString *storeKey in storeDic) {
                                [storeModel setValue:storeDic[storeKey] forKey:storeKey];
                            }
                            [storeAddArray addObject:storeModel];
                        }
                        [model setValue:storeAddArray forKey:key];
                    }else if([key isEqualToString:@"listGoods"]){
                        
                        NSArray *goodsArray = dic[key];
                        NSMutableArray *goodsAddArray = [NSMutableArray array];
                        for (NSDictionary *goodsDic in goodsArray) {
                            NSEntityDescription *des = [NSEntityDescription entityForName:@"GoodsDetailsModel" inManagedObjectContext:self.managedContext];
                            //根据描述 创建实体对象
                            GoodsDetailsModel *goodsModel = [[GoodsDetailsModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                            
                            for (NSString *goodsKey in goodsDic) {
                                [goodsModel setValue:goodsDic[goodsKey] forKey:goodsKey];
                            }
                            [goodsAddArray addObject:goodsModel];
                        }
                        [model setValue:goodsAddArray forKey:key];
                        
                        
                    }else{
                        [model setValue:dic[key] forKey:key];
                    }
                }
                [self.storeDataArray addObject:model];
            }
        }else {
            for (NSDictionary *StoreDic in storeArray) {
                NSEntityDescription *des = [NSEntityDescription entityForName:@"MapSearchStoreModel" inManagedObjectContext:self.managedContext];
                //根据描述 创建实体对象
                MapSearchStoreModel *model = [[MapSearchStoreModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
                
                for (NSString *key in StoreDic) {
                    [model setValue:StoreDic[key] forKey:key];
                }
                [self.storeDataArray addObject:model];
            }
        }
        if ([_delegate respondsToSelector:@selector(searchResults:storeArray:)]) {
            [_delegate searchResults:self.SearchType storeArray:self.storeDataArray];
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            MapViewController *VC = [[MapViewController alloc] init];
            VC.SearchValue = self.SearchType;
            VC.storeArray = self.storeDataArray;
        }];
        
    }else {
        [self showAlert:@"结果为空.请换一个名词搜索"];
    }
    
    
    //MapSearchStoreModel
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
