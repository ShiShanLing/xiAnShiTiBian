//
//  CXsearchController.m
//  搜索页面的封装
//
//  Created by 蔡翔 on 16/7/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "CXSearchController.h"
#import "CXSearchSectionModel.h"
#import "CXSearchModel.h"
#import "CXSearchCollectionViewCell.h"
#import "SelectCollectionReusableView.h"
#import "SelectCollectionLayout.h"
#import "CXDBHandle.h"
#import "searchView.h"//自定义头部视图
#import "JHDownMenuView.h"//弹窗(选择搜索类型)
#import "SearchGoodsVC.h"
#import "SearchStoreVC.h"
#import "SearchVendorVC.h"
#define  kScreen_heigth [UIScreen mainScreen].bounds.size.height//屏幕高度
#define  kScreen_widht  [UIScreen mainScreen].bounds.size.width//屏幕高度

static NSString *const cxSearchCollectionViewCell = @"CXSearchCollectionViewCell";

static NSString *const headerViewIden = @"HeadViewIden";
/**
 *记录搜索类型 默认是商品 0商品 1实体店 2个人店 3厂家
 */
static int SearchTypes;

@interface CXSearchController()<UICollectionViewDataSource,UICollectionViewDelegate,SelectCollectionCellDelegate,UICollectionReusableViewButtonDelegate, UITextFieldDelegate, searchViewDelegate, JHDownMenuViewDelegate>
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

@property (nonatomic,strong)searchView *searchView;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) JHDownMenuView *menuView;


@end

@implementation CXSearchController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self prepareData];
    SearchTypes = 0;
    NSLog(@"SearchTypes%d", SearchTypes);
    self.searchView = [[searchView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kFit(64))];
    self.searchView.searchTF.delegate = self;
    self.searchView.delegate = self;
    [self.view addSubview:_searchView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(kScreen_widht, kFit(15));
    self.cxSearchCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreen_widht, kScreen_heigth-64) collectionViewLayout:layout];
    _cxSearchCollectionView.backgroundColor = [UIColor whiteColor];
    _cxSearchCollectionView.delegate = self;
    _cxSearchCollectionView.dataSource = self;
    [self.cxSearchCollectionView setCollectionViewLayout:[[SelectCollectionLayout alloc] init] animated:YES];
    [self.cxSearchCollectionView registerClass:[SelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIden];
    [self.cxSearchCollectionView registerNib:[UINib nibWithNibName:@"CXSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cxSearchCollectionViewCell];
    [self.view addSubview:self.cxSearchCollectionView];
    
    //创建弹出窗
    [self createDownMenu];
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super.navigationController setNavigationBarHidden:YES];
}
//选择规格的按钮点击事件
- (void)ChangeSearchType {

    if (self.menuView.hidden) {
        self.menuView.hidden = NO;
        self.coverView.hidden = NO;
         self.searchView.typeBtn.selected = ! self.searchView.typeBtn.selected;
    }else
    {
        self.menuView.hidden = YES;
        self.coverView.hidden = YES;
      self.searchView.typeBtn.selected = ! self.searchView.typeBtn.selected;
    }
}
//导航条(自定义)上的取消按钮 返回上一界面
- (void)ReturnOnALayer {
    
    [self.navigationController popViewControllerAnimated:YES];

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
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.cxSearchTextField becomeFirstResponder];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CXSearchSectionModel *sectionModel =  self.sectionArray[section];
    NSLog(@"<><><><><><><><><><><><>%@", sectionModel.section_contentArray);
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
//    NSLog(@"您选的内容是：%@",contentModel.content_name);
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
    }else {
       
    }
    
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:textField.text forKey:@"content_name"]]) {
        return YES;
    }
     [self SearchResults:[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
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
- (void)SearchResults:(NSString *)state {
    /**
     *  enterprise 实体店   personal 个人店   商品 keywordSearch   厂家factoryName
     1实体搜索接口searchType=enterprise
     /search/goodsList
     searchType=enterprise
     keyword=zhang
     2全民搜索接口searchType=personal
     /search/goodsList
     searchType=personal
     keyword=zhang
     {
     3商品搜索接口searchType=keywordSearch
     /search/goodsList
     searchType=keywordSearch
     keyword=zhang
     }
     
     4商品类型搜索接口
     /search/goodsList
     searchType=gcNameSearch
     keyword=thang
     5.厂家列表
     /search/factorysList
     searchType=factoryName
     keyword=zang
     */
    [self indeterminateExample];
    NSString * URL_Str = [NSString stringWithFormat:@"%@/search/goodsList", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    
    switch (SearchTypes) {
        case 0:
            URL_Dic[@"searchType"] = @"keywordSearch";
            URL_Dic[@"keyword"] = state;
            break;
        case 1:
            URL_Str = [NSString stringWithFormat:@"%@/searchApi/goodsList", kSHY_100];
            URL_Dic[@"searchType"] = @"enterprise";
            URL_Dic[@"keyword"] = state;
            break;
        case 2:
            URL_Dic[@"searchType"] = @"personal";
            URL_Dic[@"keyword"] = state;
            break;
        case 3:
            URL_Str = [NSString stringWithFormat:@"%@/search/factorysList", kSHY_100];
            URL_Dic[@"searchType"] = @"factoryName";
            URL_Dic[@"keyword"] = state;
            break;
            
        default:
            break;
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block CXSearchController *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC delayMethod];
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        if ([responseObject[@"lucenePager"] isKindOfClass:[NSDictionary class]]) {
            
            dataDic = [NSMutableDictionary dictionaryWithDictionary:responseObject[@"lucenePager"]];
            
        }else if([responseObject[@"lucenePager"] isKindOfClass:[NSArray class]]){
            NSArray *dataArray = responseObject[@"lucenePager"];
            dataDic = [NSMutableDictionary dictionaryWithDictionary:dataArray[0]];
        }
        
        NSArray *keyArray  = [dataDic allKeys];
        
        if([dataDic[@"result"] isKindOfClass:[NSArray class]] && keyArray.count != 0) {
            
            if (SearchTypes == 0) {
                NSArray *array = dataDic[@"result"];
                if (array.count == 0) {
                    
                    [VC showAlert:@"您搜索的该类商品为空!"];
                }else {
                    SearchGoodsVC *VC = [[SearchGoodsVC alloc] init];
                    VC.searchResultArray = dataDic[@"result"];
                    [self.navigationController pushViewController:VC animated:YES];
                }
            }else if (SearchTypes == 1 || SearchTypes == 2) {
                NSArray *array = dataDic[@"result"];
                if (array.count == 0) {
                    [VC showAlert:@"您搜索的该类店铺为空!"];
                }else {
                    SearchStoreVC *VC = [[SearchStoreVC alloc] init];
                    VC.searchResultArray = dataDic[@"result"];
                    [self.navigationController pushViewController:VC animated:YES];
                }
            }else {
                NSArray *array = dataDic[@"result"];
                if (array.count == 0) {
                    [VC showAlert:@"您搜索的该类厂家为空!"];
                }else {
                    SearchVendorVC *VC = [[SearchVendorVC alloc] init];
                    VC.searchResultArray = dataDic[@"result"];
                    [VC setHidesBottomBarWhenPushed:YES];//隐藏分栏
                    [self.navigationController pushViewController:VC animated:YES];
                }
            }
        }else {
            [VC showAlert:@"该关键词搜索为空,请换一个关键字搜索!"];
        }
        
        NSLog(@"responseObject%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC delayMethod];
        [VC showAlert:@"网络超时请重试"];
    }];
    
    }
#pragma mark  选择菜单
- (void)handleTap {
    self.menuView.hidden = YES;
    self.coverView.hidden = YES;
     [self.searchView.typeBtn setImage:[UIImage imageNamed:@"huixia"] forState:(UIControlStateNormal)];
}
- (void)createDownMenu {
    //计算ableView的frame
    CGFloat ViewW = kFit(125);
    CGFloat ViewH = kFit(205);
    CGFloat ViewX = kFit(12);
    CGFloat ViewY = 57;
    
    JHDownMenuView *menuView = [[JHDownMenuView alloc]initWithFrame:CGRectMake(ViewX, ViewY, ViewW, ViewH)];
    menuView.delegate = self;
    [self.view addSubview:menuView];
    self.menuView = menuView;
    
    menuView.backgroundColor = [UIColor clearColor];
    self.menuView.hidden = YES;
    
}
//选择搜索的方式
- (void)SearchTypeIndex:(int)index {
    
    switch (index) {
        case 0:
            self.searchView.titleLabel.text = @"商品";
            SearchTypes=0;
            break;
        case 1:
            self.searchView.titleLabel.text = @"实体店" ;
            SearchTypes=1;
            break;
        case 2:
            self.searchView.titleLabel.text =@"个人店";
            SearchTypes=2;
            break;
        case 3:
            self.searchView.titleLabel.text = @"厂家";
            SearchTypes=3;
            break;
        default:
            break;
    }
    
    self.menuView.hidden = YES;
    self.coverView.hidden = YES;
   self.searchView.typeBtn.selected = ! self.searchView.typeBtn.selected;
    
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
