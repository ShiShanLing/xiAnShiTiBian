//
//  CityListViewController.m
//  ChinaCityList
//
//  Created by zjq on 15/10/27.
//  Copyright © 2015年 zhengjq. All rights reserved.
//

#import "CityListViewController.h"
#import "ZYPinYinSearch.h"
#import "ButtonGroupView.h"
#import "PinYinForObjc.h"

#define KSectionIndexBackgroundColor  [UIColor clearColor] //索引试图未选中时的背景颜色
#define kSectionIndexTrackingBackgroundColor [UIColor lightGrayColor]//索引试图选中时的背景
#define kSectionIndexColor [UIColor grayColor]//索引试图字体颜色
#define HotBtnColumns 3 //每行显示的热门城市数
#define BGCOLOR [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]


#import "RecentSearchCity+CoreDataProperties.h"//我最近搜索的城市

@interface CityListViewController ()<UIGestureRecognizerDelegate,UISearchBarDelegate,UITextFieldDelegate,ButtonGroupViewDelegate>
{
    UIImageView   *_bgImageView;
    UIView        *_tipsView;
    UILabel       *_tipsLab;
    NSTimer       *_timer;
}
@property (strong, nonatomic) UITextField *searchText;

@property (strong, nonatomic) NSMutableDictionary *searchResultDic;

@property (strong, nonatomic) ButtonGroupView *locatingCityGroupView;//定位城市试图

@property (strong, nonatomic) ButtonGroupView *hotCityGroupView;//热门城市

@property (strong, nonatomic) ButtonGroupView *historicalCityGroupView; //历史使用城市/常用城市

@property (strong, nonatomic) UIView *tableHeaderView;

@property (strong, nonatomic) NSMutableArray *arrayCitys;   //城市数据

@property (strong, nonatomic) NSMutableDictionary *cities;

@property (strong, nonatomic) NSMutableArray *keys; //城市首字母

/**
 *cocodata数据解析和保存对象
 */
@property (strong, nonatomic)AppDelegate *AppDelegate;
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

@implementation CityListViewController
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


- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.arrayHotCity = [NSMutableArray array];
        
        self.arrayHistoricalCity = [NSMutableArray array];
        
        self.arrayLocatingCity   = [NSMutableArray array];
        self.keys = [NSMutableArray array];
        self.arrayCitys = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGCOLOR;
    [self setNavigationWithTitle:@"选择城市"];

    [self getCityData];
    //3自定义背景
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40*(self.view.frame.size.height/568))];
    searchView.backgroundColor = [UIColor clearColor];
    UIImageView *searchBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    searchBg.frame = CGRectMake(0, 0, searchView.frame.size.width, searchView.frame.size.height);
    [searchView addSubview:searchBg];
    //搜索框
    _searchText = [[UITextField alloc]initWithFrame:CGRectMake(30*(self.view.frame.size.width/320), 0, self.view.frame.size.width-30, searchView.frame.size.height)];
    _searchText.backgroundColor = [UIColor clearColor];
    _searchText.font = [UIFont systemFontOfSize:13];
    _searchText.placeholder  = @"请输入城市名称或首字母查询";
    _searchText.returnKeyType = UIReturnKeySearch;
    _searchText.textColor    = [UIColor colorWithRed:58/255.0 green:58/255.0 blue:58/255.0 alpha:1];
    _searchText.delegate     = self;
    [_searchText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [searchView addSubview:_searchText];

    [self.view addSubview:searchView];

    
	// Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    _tableView.frame           = CGRectMake(0,searchView.frame.origin.y+searchView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-64);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    [self.view addSubview:_tableView];
    
    [self ininHeaderView];
    
    //添加单击事件 取消键盘第一响应
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignFirstResponder:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
}
- (void)handleReturn {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)resignFirstResponder:(UITapGestureRecognizer*)tap {
    [_searchText resignFirstResponder];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//如果当前是tableView
        return NO;
    }
    return YES;
}

- (void)textChange:(UITextField*)textField
{
    [self filterContentForSearchText:textField.text];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
    
}

- (void)setNavigationWithTitle:(NSString *)title {
    //自定义导航栏
    UIView *customNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    customNavView.backgroundColor = BGCOLOR;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"baidiganhui"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(kFit(12), kFit(27), 30, 30);
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [customNavView addSubview:backBtn];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, customNavView.frame.size.width, customNavView.frame.size.height-20)];
    
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = title;
    [customNavView addSubview:titleLab];
    [self.view addSubview:customNavView];
}

- (void)back:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)ininHeaderView {
    _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 250)];
    _tableHeaderView.backgroundColor = [UIColor clearColor];
    //定位城市
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 160, 21)];
    title1.text = @"定位城市";
    title1.font = [UIFont systemFontOfSize:15];
    [_tableHeaderView addSubview:title1];
    
    _locatingCityGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, title1.frame.origin.y+title1.frame.size.height+10, _tableHeaderView.frame.size.width, 45)];
    _locatingCityGroupView.delegate = self;
    _locatingCityGroupView.columns = 3;
    _locatingCityGroupView.items = [self GetCityDataSoucre:_arrayLocatingCity];
    [_tableHeaderView addSubview:_locatingCityGroupView];
    //常用城市
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(10, _locatingCityGroupView.frame.origin.y+_locatingCityGroupView.frame.size.height+10, 160, 21)];
    title2.text = @"常用城市";
    title2.font = [UIFont systemFontOfSize:15];
    [_tableHeaderView addSubview:title2];
    
    long rowHistorical = _arrayHistoricalCity.count/3;
    if (_arrayHistoricalCity.count%3 > 0) {
        rowHistorical += 1;
    }
    CGFloat hisViewHight = 45*rowHistorical;
    _historicalCityGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, title2.frame.origin.y+title2.frame.size.height+10, _tableHeaderView.frame.size.width, hisViewHight)];
    _historicalCityGroupView.backgroundColor = [UIColor clearColor];
    _historicalCityGroupView.delegate = self;
    _historicalCityGroupView.columns = 3;
    _historicalCityGroupView.items = [self GetCityDataSoucre:_arrayHistoricalCity];
    [_tableHeaderView addSubview:_historicalCityGroupView];
    
    //热门城市
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(10, _historicalCityGroupView.frame.origin.y+_historicalCityGroupView.frame.size.height+10, 160, 21)];
    title3.text = @"热门城市";
    title3.font = [UIFont systemFontOfSize:15];
    [_tableHeaderView addSubview:title3];
    
    long row = _arrayHotCity.count/3;
    if (_arrayHotCity.count%3 > 0) {
        row += 1;
    }
    CGFloat hotViewHight = 45*row;
    _hotCityGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, title3.frame.origin.y+title3.frame.size.height+10, _tableHeaderView.frame.size.width, hotViewHight)];
    _hotCityGroupView.backgroundColor = [UIColor clearColor];
    _hotCityGroupView.delegate = self;
    _hotCityGroupView.columns = 3;
    _hotCityGroupView.items = [self GetCityDataSoucre:_arrayHotCity];
    [_tableHeaderView addSubview:_hotCityGroupView];
    _tableHeaderView.frame = CGRectMake(0, 0, _tableView.frame.size.width, _hotCityGroupView.frame.origin.y+_hotCityGroupView.frame.size.height);
    _tableView.tableHeaderView.frame = _tableHeaderView.frame;
    _tableView.tableHeaderView = _tableHeaderView;
}

- (NSArray*)GetCityDataSoucre:(NSArray*)ary {//这里吧数组里面的字符串 改成字典
    NSMutableArray *cityAry = [[NSMutableArray alloc]init];
    for (NSDictionary*cityName in ary) {
        [cityAry addObject: [CityItem initWithTitleName:cityName]];//封装CityItem Model数据
    }
    return cityAry;
}

#pragma mark - 获取城市数据
-(void)getCityData {
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [_keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];

    NSArray *allValuesAry = [self.cities allValues];
    for (NSArray*oneAry in allValuesAry) {

        for (NSString *cityName in oneAry) {
           [_arrayCitys addObject:cityName];
        }
    }
}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    bgView.backgroundColor = BGCOLOR;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 19, bgView.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    
    
    NSString *key = [_keys objectAtIndex:section];

    titleLabel.text = key;
    [bgView addSubview:line];

    [bgView addSubview:titleLabel];
    
    return bgView;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexNumber = [NSMutableArray arrayWithArray:_keys];
    return indexNumber;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    NSLog(@"title = %@",title);
    [self showTipsWithTitle:title];
    
    return index;
}

- (void)showTipsWithTitle:(NSString*)title {
    
    //获取当前屏幕window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    if (!_tipsView) {
        //添加字母提示框
        _tipsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _tipsView.center = window.center;
        _tipsView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.8];
        //设置提示框圆角
        _tipsView.layer.masksToBounds = YES;
        _tipsView.layer.cornerRadius  = _tipsView.frame.size.width/20;
        _tipsView.layer.borderColor   = [UIColor whiteColor].CGColor;
        _tipsView.layer.borderWidth   = 2;
        [window addSubview:_tipsView];
    }
    if (!_tipsLab) {
        //添加提示字母lable
        _tipsLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tipsView.frame.size.width, _tipsView.frame.size.height)];
        //设置背景为透明
        _tipsLab.backgroundColor = [UIColor clearColor];
        _tipsLab.font = [UIFont boldSystemFontOfSize:50];
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        
        [_tipsView addSubview:_tipsLab];
    }
   _tipsLab.text = title;//设置当前显示字母
    
//    [self performSelector:@selector(hiddenTipsView:) withObject:nil afterDelay:0.3];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self hiddenTipsView];
//    });
    
    
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(hiddenTipsView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

- (void)hiddenTipsView {
    
    [UIView animateWithDuration:0.2 animations:^{
        _bgImageView.alpha = 0;
        _tipsView.alpha = 0;
    } completion:^(BOOL finished) {
        [_bgImageView removeFromSuperview];
        [_tipsView removeFromSuperview];
         _bgImageView = nil;
         _tipsLab     = nil;
         _tipsView    = nil;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_tableView respondsToSelector:@selector(setSectionIndexColor:)]) {
        _tableView.sectionIndexBackgroundColor = KSectionIndexBackgroundColor;  //修改索引试图未选中时的背景颜色
        _tableView.sectionIndexTrackingBackgroundColor = kSectionIndexTrackingBackgroundColor;//修改索引试图选中时的背景颜色
        _tableView.sectionIndexColor = kSectionIndexColor;//修改索引试图字体颜色
    }
    
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setTextColor:[UIColor blackColor]];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    NSDictionary *dic = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    if ([key isEqualToString:@"B"]) {
        
        NSLog(@"dic[provinceName]%@", dic);
        
    }
    cell.textLabel.text = dic[@"provinceName"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *key = [_keys objectAtIndex:indexPath.section];
    NSDictionary *dataDic = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    NSLog(@"didSelectRowAtIndexPath%@", dataDic);
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"StorageCitiesData.plist"];//这里就是你将要存储的沙盒路径（.plist文件，名字自定义）
    NSLog(@"%@",plistPath);
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {//plistPath这个文件\文件夹是否存在
        // - 什么是NSFileManager
        
        //  顾名思义, NSFileManager是用来管理文件系统的
        //它可以用来进行常见的文件\文件夹操作
        //NSFileManager使用了单例模式
        
        //使用defaultManager方法可以获得那个单例对象
        //[NSFileManager defaultManager]
        
        NSMutableArray *dictplist = [[NSMutableArray alloc] init];
        [dictplist addObject:dataDic];
        
        [dictplist writeToFile:plistPath atomically:YES];
        NSLog(@"------1----- %@写入不成功",dictplist);
    }
    else
    {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        for (int i = 0; i < dataArray.count; i ++) {
            NSDictionary *tempDic = dataArray[i];
            if ([tempDic[@"provinceName"] isEqualToString:dataDic[@"provinceName"]]) {
                [dataArray removeObjectAtIndex:i];//删除相同的
            }
        }
        if (dataArray.count == 3) {//如果已经有三个了那么删除第一个
            [dataArray removeObjectAtIndex:0];
        }

        [dataArray addObject:dataDic];
        [dataArray writeToFile:plistPath atomically:YES];
        NSLog(@"-------2----%@写入成功",dataArray);
    }

    NSEntityDescription *des = [NSEntityDescription entityForName:@"RecentSearchCity" inManagedObjectContext:self.managedContext];
    //根据描述 创建实体对象
    RecentSearchCity *model = [[RecentSearchCity alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
    //创建实体描述对象  --- 下面这个model对象是用来传给,地图界面用的
    
    for (NSString *key in dataDic) {
        [model setValue:dataDic[key] forKey:key];
    }
    if ([_delegate respondsToSelector:@selector(didClickedWithCityName:)]) {
        [_delegate didClickedWithCityName:model];
    }
     [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ButtonGroupView:(ButtonGroupView *)buttonGroupView didClickedItem:(CityButton *)item {
    
    NSDictionary *dataDic = @{@"provinceName":item.cityItem.titleName, @"latitude":item.cityItem.latitude, @"longitude":item.cityItem.longitude};
    //1获取路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"StorageCitiesData.plist"];//这里就是你将要存储的沙盒路径（.plist文件，名字自定义）
    //2获取数据
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {//plistPath这个文件\文件夹是否存在
        // - 什么是NSFileManager
        
        //  顾名思义, NSFileManager是用来管理文件系统的
        //它可以用来进行常见的文件\文件夹操作
        //NSFileManager使用了单例模式
        
        //使用defaultManager方法可以获得那个单例对象
        //[NSFileManager defaultManager]
        
        NSMutableArray *dictplist = [[NSMutableArray alloc] init];
        [dictplist addObject:dataDic];
        
        [dictplist writeToFile:plistPath atomically:YES];
        NSLog(@"------1----- %@写入不成功",dictplist);
    }
    else
    {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        for (int i = 0; i < dataArray.count; i ++) {
            NSDictionary *tempDic = dataArray[i];
            if ([tempDic[@"provinceName"] isEqualToString:dataDic[@"provinceName"]]) {
                [dataArray removeObjectAtIndex:i];//删除相同的
            }
        }
        if (dataArray.count == 3) {//如果已经有三个了那么删除第一个
            [dataArray removeObjectAtIndex:0];
        }
        
        [dataArray addObject:dataDic];
        [dataArray writeToFile:plistPath atomically:YES];
        NSLog(@"-------2----%@写入成功",dataArray);
    }
    NSEntityDescription *des = [NSEntityDescription entityForName:@"RecentSearchCity" inManagedObjectContext:self.managedContext];
    //根据描述 创建实体对象
    RecentSearchCity *model = [[RecentSearchCity alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
    //使用数据管理器
    for (NSString *key in dataDic) {
        [model setValue:dataDic[key] forKey:key];
    }
    //保存
    if ([_delegate respondsToSelector:@selector(didClickedWithCityName:)]) {
        [_delegate didClickedWithCityName:model];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
NSInteger cityNameSort(id str1, id str2, void *context) {
    NSString *string1 = (NSString*)str1[@"provinceName"];
    NSString *string2 = (NSString*)str2[@"provinceName"];
  //  NSLog(@"%@ 排序查看------ %@", str1, str1);
    return  [string1 localizedCompare:string2];
}

/**
 *  通过搜索条件过滤得到搜索结果
 *
 *  @param searchText 关键词 *  @param scope  范围
 */
- (void)filterContentForSearchText:(NSString*)searchText {
    
    if (searchText.length > 0) {
        _searchResultDic = nil;
        _searchResultDic = [[NSMutableDictionary alloc]init];
        
        //搜索数组中是否含有关键字
        NSArray *resultAry  = [ZYPinYinSearch searchWithOriginalArray:_arrayCitys andSearchText:searchText andSearchByPropertyName:@"provinceName"];
      //  NSLog(@"搜索结果:%@",resultAry) ;
        
        
        for (NSDictionary*city in resultAry) {
            //获取字符串拼音首字母并转为大写
            
            NSString *pinYinHead = [PinYinForObjc chineseConvertToPinYinHead:city[@"provinceName"]].uppercaseString;
            NSString *firstHeadPinYin = [pinYinHead substringToIndex:1]; //拿到字符串第一个字的首字母
            //        NSLog(@"pinYin = %@",firstHeadPinYin);
            
            NSMutableArray *cityAry = [NSMutableArray arrayWithArray:[_searchResultDic objectForKey:firstHeadPinYin]]; //取出首字母数组
         //   NSLog(@"获取字符串首字母%@", cityAry);
            if (cityAry != nil) {
                
                [cityAry addObject:city];
                NSArray *sortCityArr = [cityAry sortedArrayUsingFunction:cityNameSort context:NULL];
                [_searchResultDic setObject:sortCityArr forKey:firstHeadPinYin];
            }else
            {
                cityAry= [[NSMutableArray alloc]init];
                [cityAry addObject:city];
                NSArray *sortCityArr = [cityAry sortedArrayUsingFunction:cityNameSort context:NULL];
                [_searchResultDic setObject:sortCityArr forKey:firstHeadPinYin];
            }
        }
        if (resultAry.count>0) {
            _cities = nil;
            _cities = _searchResultDic;
            [_keys removeAllObjects];
            //按字母升序排列
            [_keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]] ;
            _tableView.tableHeaderView = nil;
            [_tableView reloadData];
        }
    }else//最外层
    {
        //当字符串清空时 回到初始状态
        _cities = nil;
         [_keys removeAllObjects];
        [_arrayCitys removeAllObjects];
        [self getCityData];
        _tableView.tableHeaderView = _tableHeaderView;
        [_tableView reloadData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
