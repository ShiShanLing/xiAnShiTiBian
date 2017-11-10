//
//  BaseTabBarVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/21.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "CallCarOderDetailsVC.h"
#import "StoreViewController.h"
#import "ViewController.h"
#import "MainControlVC.h"
#import "MyFootprintVC.h"
#import "Reachability.h"


@interface BaseTabBarVC ()
@property (strong, nonatomic)AppDelegate *AppDelegate;
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong)NSMutableArray *urseDataArray;

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;

@end

@implementation BaseTabBarVC
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AnalysisUserData];
    ViewController *VC = [[ViewController alloc] init];
 
    MapViewController *MapVC = [[MapViewController alloc] init];
    UINavigationController *MapNA = [[UINavigationController alloc] initWithRootViewController:MapVC];
    MapNA.tabBarItem.title = @"周边";
    MapNA.tabBarItem.image = [[UIImage imageNamed:@"Adingwei1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MapNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"Adingwei"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [MapNA.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MColor(242, 48, 48)} forState:UIControlStateSelected];
    
    GoodsViewController *GoodsVC = [[GoodsViewController alloc] init];
    UINavigationController *GoodsNA = [[UINavigationController alloc] initWithRootViewController:GoodsVC];
    GoodsNA.tabBarItem.title = @"商品";
    GoodsNA.tabBarItem.image = [[UIImage imageNamed:@"Ashangcheng1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    GoodsNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"Ashangcheng"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [GoodsNA.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MColor(242, 48, 48)} forState:UIControlStateSelected];
    
    
    ShoppingCartVC *SCVC = [[ShoppingCartVC alloc] init];
    UINavigationController *SCNA = [[UINavigationController alloc] initWithRootViewController:SCVC];
    SCNA.tabBarItem.title = @"购物车";
    
    SCNA.tabBarItem.image = [[UIImage imageNamed:@"Agouwuche1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SCNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"Agouwuche"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [SCNA.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MColor(242, 48, 48)} forState:UIControlStateSelected];
    
    MyViewController *MyVC = [[MyViewController alloc] init];
    UINavigationController *MyNA = [[UINavigationController alloc] initWithRootViewController:MyVC];
    MyNA.tabBarItem.title = @"我的";
    
    MyNA.tabBarItem.image = [[UIImage imageNamed:@"Ame1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MyNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"Ame"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [MyNA.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MColor(242, 48, 48)} forState:UIControlStateSelected];

    MyFootprintVC * FootprintVC = [[MyFootprintVC alloc] init];
    UINavigationController *FootprintVCNA = [[UINavigationController alloc] initWithRootViewController:FootprintVC];
    FootprintVCNA.tabBarItem.title = @"足迹";
    FootprintVCNA.tabBarItem.image = [[UIImage imageNamed:@"footprint-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    FootprintVCNA.tabBarItem.selectedImage = [[UIImage imageNamed:@"footprint"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [FootprintVCNA.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MColor(242, 48, 48)} forState:UIControlStateSelected];
    
    
    //1.配置所管理的多个视图控制器
    self.viewControllers = @[MapNA, MyNA,SCNA,  FootprintVCNA];//里面放的是控制器
    [self setSelectedIndex:0];//默认显示的界面
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
   
}

- (void)AnalysisUserData{
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
   // NSLog(@"paths%@", paths);
    NSString *plistPath = [paths objectAtIndex:0];
    NSString *filename=[plistPath stringByAppendingPathComponent:@"UserLogInData.plist"];
    NSMutableDictionary *userData = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    
    NSArray *keyArray =[userData allKeys];
    
    if (keyArray.count == 0) {
        
    }else {
        NSString *URL_Str = [NSString stringWithFormat:@"%@/memberapi/memberDetail",kSHY_100];
        NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
        URL_Dic[@"memberId"] = userData[@"memberId"];
        NSLog(@"f92abddf1e034db19d764e402bd4f9fd%@", userData);
        [UserDataSingleton mainSingleton].userID = userData[@"memberId"];
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        __block BaseTabBarVC *VC = self;
        [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           // NSLog(@"responseObject%@", responseObject);
            NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
            if ([resultStr isEqualToString:@"0"]) {
            }else {
                [VC AnalyticalData:responseObject];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [VC showAlert:@"请求失败请重试" time:1.0];
        }];
    }
}

//解析的登录过后的数据
- (void)AnalyticalData:(NSDictionary *)dic {
    NSString *state = [NSString stringWithFormat:@"%@", dic[@"result"]];
    if ([state isEqualToString:@"1"]) {
        NSDictionary *urseDataDic = dic[@"data"][0];
        [UserDataSingleton mainSingleton].storeID =urseDataDic[@"storeId"];
        NSLog(@"[UserDataSingleton mainSingleton].storeID%@", [UserDataSingleton mainSingleton].storeID);
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserLogInData" ofType:@"plist"];
        NSMutableDictionary *userData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        [userData removeAllObjects];
        
        for (NSString *key in urseDataDic[@"member"]) {
            if ([key isEqualToString:@"appKey"]) {
                [UserDataSingleton mainSingleton].AppKey = urseDataDic[@"member"][key];
                NSLog(@"[UserDataSingleton mainSingleton].AppKey%@", [UserDataSingleton mainSingleton].AppKey);
            }
            [userData setObject:urseDataDic[@"member"][key] forKey:key];
            
        }
        //获取应用程序沙盒的Documents目录
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        
        //得到完整的文件名
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"UserLogInData.plist"];
        //输入写入
        [userData writeToFile:filename atomically:YES];
        
        //那怎么证明我的数据写入了呢？读出来看看
        NSMutableDictionary *userData2 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];

    }

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    
    
    if (reachability == self.internetReachability)
    {
        [self configureReachability:reachability];
    }
    
}


- (void)configureReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString* statusString = @"";
    
    switch (netStatus)
    {
        case NotReachable:        {
            statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
            //  imageView.image = [UIImage imageNamed:@"stop-32.png"] ;
            [UserDataSingleton mainSingleton].networkState = 0;
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            statusString = NSLocalizedString(@"Reachable WWAN", @"");
            // imageView.image = [UIImage imageNamed:@"WWAN5.png"];
            [UserDataSingleton mainSingleton].networkState = 1;
            break;
        }
        case ReachableViaWiFi:        {
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            [UserDataSingleton mainSingleton].networkState = 2;
            //imageView.image = [UIImage imageNamed:@"Airport.png"];
            break;
        }
    }
    
    
    if (connectionRequired)
    {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    NSLog(@"statusString%@", statusString);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
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
