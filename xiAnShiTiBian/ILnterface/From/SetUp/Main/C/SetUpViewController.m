//
//  SetUpViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "SetUpViewController.h"
#import "SetUpTitleTVCell.h"//每个模块的标题
#import "SmallTVCell.h"//
#import "SetUpPictureTVCell.h"
#import "AlertsTVCell.h"//消息开关cell
#import "ClearCacheTVCell.h"
#import "NewPhoneVC.h"//
#import "ChangeSAVC.h"//收货地址界面
#import "ChangePWVC.h"//修改登录密码
#import "ChangeUserVC.h"
#import "aboutViewController.h"
#import "RealNameTVCell.h"
#import "RealNameAutVC.h"
static NSString *gender;

@interface SetUpViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DPImagePickerDelegate>

@property (nonatomic, strong)UITableView *tableView;
//存储用户消息推送习惯的数组
@property (nonatomic, strong)NSMutableArray *messageArray;

@property (nonatomic, strong)UIImagePickerController *picker;//拍照

@property (nonatomic, strong)UIImage *ReplaceUserImage;

/**
 *cocodata数据解析和保存对象
 */
@property (strong, nonatomic)AppDelegate *AppDelegate;
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;



@property (nonatomic, strong)NSMutableArray *urseDataArray;

@end

@implementation SetUpViewController
- (NSMutableArray *)urseDataArray {
    if (!_urseDataArray) {
        _urseDataArray = [NSMutableArray array];
    }
    return _urseDataArray;
}

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

- (UIImage *)ReplaceUserImage {
    if (!_ReplaceUserImage) {
        _ReplaceUserImage = [UIImage imageNamed:@"zly"];
    }
    return _ReplaceUserImage;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
    }
    return _tableView;
}
- (NSMutableArray *)userData {
    if (!_userData) {
        _userData = [NSMutableArray array];
    }
    return _userData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MColor(234, 234, 234);
    self.navigationItem.title = @"设置";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
    UIImage *MoreMoreImage = [UIImage imageNamed:@"morehs"];
    //设置图像渲染方式
    MoreMoreImage = [MoreMoreImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉
    UIBarButtonItem *CollectButtonItem = [[UIBarButtonItem alloc] initWithImage:MoreMoreImage style:UIBarButtonItemStylePlain target:self action:@selector(handleCollect)];//自定义导航条按钮
    self.navigationItem.rightBarButtonItems = @[CollectButtonItem];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.backgroundColor = MColor(238, 238, 238);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[SmallTVCell class] forCellReuseIdentifier:@"SmallTVCell"];
    [self.tableView registerClass:[SetUpTitleTVCell class] forCellReuseIdentifier:@"SetUpTitleTVCell"];
    [self.tableView registerClass:[SetUpPictureTVCell class] forCellReuseIdentifier:@"SetUpPictureTVCell"];
    [self.tableView registerClass:[ClearCacheTVCell class] forCellReuseIdentifier:@"ClearCacheTVCell"];
    [self.tableView registerClass:[AlertsTVCell class] forCellReuseIdentifier:@"AlertsTVCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RealNameTVCell" bundle:nil] forCellReuseIdentifier:@"RealNameTVCell"];
    [self.view addSubview:self.tableView];
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

- (void)viewWillAppear:(BOOL)animated {
    
    [super.navigationController setNavigationBarHidden:NO];
    [self requestMembersDetails];
    

}

//获取用户信息  如果里面是空的代表用户还没有登录
- (void)requestMembersDetails{
    
    [self managedContext];
    [_urseDataArray removeAllObjects];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    NSString *filename=[plistPath stringByAppendingPathComponent:@"UserLogInData.plist"];
    NSMutableDictionary *userData = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];

    NSArray *keyArray =[userData allKeys];
    if (keyArray.count == 0) {
        
    }else {
        NSEntityDescription *des = [NSEntityDescription entityForName:@"UserDataModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        UserDataModel *model = [[UserDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        for (NSString *key in userData) {
            [model setValue:userData[key] forKey:key];
        }
        [self.urseDataArray addObject:model];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark  UITableVIewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.urseDataArray.count == 0) {
        return 0;
    }else {
        return 3;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    if (section == 0) {
        return 6;
    }else if(section == 1) {
        return 3;
    }else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserDataModel *model = self.urseDataArray[0];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SetUpTitleTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetUpTitleTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell titleLabel:@"个人资料" headImage:@"sz-grzl"];
            return cell;
        } else if(indexPath.row == 1) {
            SetUpPictureTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetUpPictureTVCell" forIndexPath:indexPath];
            [cell userHeadPortrait:model.memberAvatar];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else if(indexPath.row == 5) {
            RealNameTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RealNameTVCell" forIndexPath:indexPath];
            if (model.applyState == -1) {
                cell.realNameStateLabel.layer.borderColor = MColor(242, 48, 48).CGColor;
            }else if (model.applyState == 0){
                cell.realNameStateLabel.text = @"待审核";
                cell.instructionsBtn.hidden = YES;
                cell.realNameStateLabel.layer.borderColor = MColor(242, 48, 48).CGColor;
            }else if (model.applyState == 1){
                cell.realNameStateLabel.text = @"已通过";
                cell.instructionsBtn.hidden = YES;
                cell.realNameStateLabel.textColor =MColor(18, 106, 255);
                cell.realNameStateLabel.layer.borderColor = MColor(18, 106, 255).CGColor;
                
            }
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            SmallTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SmallTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *titleArray = @[@"昵称", @"性别", @"收货地址"];
            NSArray *nameArray = @[model.memberTruename, [model.memberSex isEqualToString:@"1"] ?@"男":@"女", @""];
            [cell titlLabel:titleArray[indexPath.row - 2] DefaultLabel:nameArray[indexPath.row - 2]];
            return cell;
        }
    }else if(indexPath.section == 1) {
        if (indexPath.row == 0) {
            SetUpTitleTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetUpTitleTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell titleLabel:@"账号于安全" headImage:@"sz-zhaq"];
            return cell;
        }else {
        
            SmallTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SmallTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *titleArray = @[@"更换绑定手机号", @"修改登录密码"];
            NSArray *nameArray = @[model.memberMobile, @""];
            [cell titlLabel:titleArray[indexPath.row - 1] DefaultLabel:nameArray[indexPath.row - 1]];
            return cell;
        }
    
    }else {
        if (indexPath.row == 0) {
            SetUpTitleTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetUpTitleTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell titleLabel:@"通用" headImage:@"sz-ty"];
            return cell;
        }else if (indexPath.row == 1) {
            ClearCacheTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClearCacheTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
            cell.backgroundColor = MColor(238, 238, 238);
            UILabel *label = [UILabel new];
            label.backgroundColor = kNavigation_Color;
            label.layer.cornerRadius = 3;
            label.layer.masksToBounds = YES;
            label.text = @"退出登录";
            label.textColor = [UIColor whiteColor];
            label.textAlignment = 1;
            label.font = MFont(kFit(18));
            [cell addSubview:label];
            label.sd_layout.topSpaceToView(cell, kFit(10)).leftSpaceToView(cell, kFit(5)).rightSpaceToView(cell, kFit(12)).bottomSpaceToView(cell, 5);
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kFit(47);
        }else if (indexPath.row == 1) {
            return kFit(60);
        }else if (indexPath.row == 5) {
            return 48;
        }else {
            return kFit(47);
        }
    }else if (indexPath.section == 1) {
        return kFit(47);
    }else {
        if (indexPath.row == 2) {
            return kFit(60);
        }else {
            return kFit(47);
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserDataModel *model = _urseDataArray[0];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"修改头像" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }];
            UIAlertAction *TakingPicturesCancle = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                [self throughCameraObtainImage];
            }];
            UIAlertAction *PhotoAlbumConfirm = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                DPImagePickerVC *VC = [[DPImagePickerVC alloc]init];
                VC.delegate = self;
                VC.isDouble = YES;
                VC.userID = model.memberId;
                [self.navigationController pushViewController:VC animated:YES];
            }];
            // 3.将“取消”和“确定”按钮加入到弹框控制器中
            [alertV addAction:cancle];
            [alertV addAction:TakingPicturesCancle];
            [alertV addAction:PhotoAlbumConfirm];
            // 4.控制器 展示弹框控件，完成时不做操作
            [self presentViewController:alertV animated:YES completion:^{
                nil;
            }];
        }
        if (indexPath.row == 2) {//昵称
            ChangeUserVC *VC = [[ChangeUserVC alloc] init];
            VC.userID = model.memberId;
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        if (indexPath.row == 3) {
            
            __block SetUpViewController *VC= self;
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"您好" message:@"请选择您的选项" preferredStyle:UIAlertControllerStyleActionSheet];
           
            UIAlertAction *cancle1 = [UIAlertAction actionWithTitle:@"女性" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                
                [VC ModifyUserSex:@"2"];
            }];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"男性" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [VC ModifyUserSex:@"1"];
            }];
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            // 3.将“取消”和“确定”按钮加入到弹框控制器中
            [alertV addAction:cancle];
            [alertV addAction:cancle1];
            [alertV addAction:confirm];
            // 4.控制器 展示弹框控件，完成时不做操作
            [self presentViewController:alertV animated:YES completion:^{
                nil;
            }];
            [self.tableView reloadData];
        }
        if (indexPath.row == 4) {
            ChangeSAVC *VC = [[ChangeSAVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        if (indexPath.row == 5) {
            
            if (model.applyState != -1) {
                
            }else {
                RealNameAutVC *VC = [[NSBundle mainBundle] loadNibNamed:
                                 @"RealNameAutVC" owner:nil options:nil ].lastObject;
                VC.membersID = model.memberId;
                [self.navigationController pushViewController:VC animated:YES];
            }
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            NewPhoneVC *VC = [[NewPhoneVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }if (indexPath.row == 2) {
            ChangePWVC *VC = [[ChangePWVC alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            
            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"警告!" message:@"确定清除缓存吗?" preferredStyle:UIAlertControllerStyleActionSheet];
            __weak SetUpViewController *VC = self;
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [VC showAlert:@"清理成功" time:1.0];
            }];
            
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"对不起");
            }];
            [alertV addAction:cancle];
            [alertV addAction:confirm];
            [self presentViewController:alertV animated:YES completion:^{ nil;}];
            
        }else if(indexPath.row == 2){
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserLogInData" ofType:@"plist"];
            NSMutableDictionary *userData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
            [userData  removeAllObjects];
            //获取应用程序沙盒的Documents目录
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            NSString *plistPath1 = [paths objectAtIndex:0];
            //得到完整的文件名
            NSString *filename=[plistPath1 stringByAppendingPathComponent:@"UserLogInData.plist"];
            //输入写入
            [userData writeToFile:filename atomically:YES];
            [UserDataSingleton mainSingleton].userID = @"";
            [UserDataSingleton mainSingleton].storeID = @"";
            [UserDataSingleton mainSingleton].AppKey = @"";
            [self showAlert:@"退出成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)ModifyUserSex:(NSString *)sex {
    [self performSelector:@selector(indeterminateExample)];
    
    UserDataModel *model = self.urseDataArray[0];
    NSString *UrL_Two = [NSString stringWithFormat:@"%@/memberapi/updateMember", kSHY_100];
    NSMutableDictionary *MDIC = [NSMutableDictionary dictionary];
    MDIC[@"memberId"] = model.memberId;
    MDIC[@"nichen"] = @"";
    MDIC[@"birthday"] = @"";
    MDIC[@"sex"] = sex;
    MDIC[@"areaInfo"] = @"";
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block SetUpViewController *VC = self;
    [session POST:UrL_Two parameters:MDIC progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *resultStr = [NSString stringWithFormat:@"%@",responseObject[@"result"]];
        
        if ([resultStr isEqualToString:@"1"]) {
            [VC AnalysisUserData:model.memberId];
        }else {
            [VC showAlert:@"修改失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
        [VC showAlert:@"网络超时请重试"];
    }];



}

//获取用户详情信息 用来存储到本地判断登录状态 和 更新数据
- (void)AnalysisUserData:(NSString *)memberId{
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/memberapi/memberDetail",kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"memberId"] = memberId;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block SetUpViewController *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [VC performSelector:@selector(delayMethod)];
        NSLog(@"responseObject%@", responseObject);
        [VC AnalyticalDataDetails:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC performSelector:@selector(delayMethod)];
    }];
}
//解析用户详情数据 并且存储到本地一份
- (void)AnalyticalDataDetails:(NSDictionary *)dic {
    [self.urseDataArray removeAllObjects];
    NSString *state = [NSString stringWithFormat:@"%@", dic[@"result"]];
    if ([state isEqualToString:@"1"]) {
    NSDictionary *urseDataDic = dic[@"data"][0];
        NSEntityDescription *des = [NSEntityDescription entityForName:@"UserDataModel" inManagedObjectContext:self.managedContext];
        //根据描述 创建实体对象
        UserDataModel *model = [[UserDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
        for (NSString *key in urseDataDic[@"member"]) {
            [model setValue:urseDataDic[@"member"][key] forKey:key];
        }
        [self.urseDataArray addObject:model];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserLogInData" ofType:@"plist"];
        NSMutableDictionary *userData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        [userData  removeAllObjects];
        
        for (NSString *key in urseDataDic[@"member"]) {
            
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
        NSLog(@"userData2%@", userData2);
        //添加一项内容
        [self showAlert:@"修改成功"];
    }
    [self.tableView reloadData];
}
//用相机获取头像
-(void)throughCameraObtainImage{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.picker = [[UIImagePickerController alloc]init];
            self.picker.delegate = self;
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:self.picker animated:YES];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"failed to camera"
                                  message:@""
                                  delegate:nil
                                  cancelButtonTitle:@"OK!"
                                  otherButtonTitles:nil];
            [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *sourceImage = info[UIImagePickerControllerOriginalImage];
    self.ReplaceUserImage = sourceImage;
    UserDataModel *model = self.urseDataArray[0];
    [self performSelector:@selector(indeterminateExample)];
    
    NSString *UrL_Two = [NSString stringWithFormat:@"%@/memberapi/updateMember", kSHY_100];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:20.0];
    //把版本号信息传导请求头中
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"iOS-%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"MM-Version"];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",nil];
    
    NSMutableDictionary *MDIC = [NSMutableDictionary dictionary];
    MDIC[@"memberId"] = model.memberId;
    MDIC[@"nichen"] = @"";
    MDIC[@"birthday"] = @"";
    MDIC[@"sex"] = @"";
    MDIC[@"areaInfo"] = @"";
    __block SetUpViewController *VC = self;
    [manager POST:UrL_Two parameters:MDIC constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        UIImage *images = sourceImage;
        
        NSData *picData = UIImageJPEGRepresentation(images, 0.5);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png", @"face"];
        [formData appendPartWithFileData:picData name:[NSString stringWithFormat:@"face"]
                                fileName:fileName mimeType:@"image/png"];
        
        
    } success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            
            [VC AnalysisUserData:model.memberId];
        }else {
            [VC showAlert:@"修改失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"错误信息=====%@", error.description);
        [VC performSelector:@selector(delayMethod)];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

    [self.picker dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}
//用相册获取头像
- (void)getCutImage:(UIImage *)image{
    self.ReplaceUserImage = image;
    [self.tableView reloadData];
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


//显示网络加载指示器
- (void)indeterminateExample {
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];//加载指示器出现
}
//隐藏网络加载指示器
- (void)delayMethod{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];//加载指示器消失
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
