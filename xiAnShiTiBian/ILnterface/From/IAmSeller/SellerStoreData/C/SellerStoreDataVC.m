//
//  SellerStoreDataVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerStoreDataVC.h"
#import "TitleTVCell.h"
#import "StoreCoverTVCell.h"
#import "StoreDataTVCell.h"
#import "StoreDataEditorTVCell.h"

#import "SellerModifyPhoneVC.h"//修改手机号
#import "SellerModifyAddressVC.h"//编辑地址
#import "SellerModifyIntroduceVC.h"//编辑店铺介绍
/**
 *判断用户选择的是更换店铺logo还是店铺的背景
 */
static  int PhotoProperties; //0 是logo 1 背景


@interface SellerStoreDataVC ()<UITableViewDelegate, UITableViewDataSource, StoreDataEditorTVCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, DPImagePickerDelegate, TitleTVCellDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UIImagePickerController *picker;//拍照
//存储我获取的头像
/**
 *根据 PhotoProperties 来判断这个image是logo还是背景
 */
@property (nonatomic, strong)UIImage *ReplaceUserImage;

@property (nonatomic, strong)NSMutableArray *sellerDataArray;
@end

@implementation SellerStoreDataVC

- (NSMutableArray *)sellerDataArray {
    if (!_sellerDataArray) {
        _sellerDataArray = [NSMutableArray array];
    }
    return _sellerDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurationNavigationBar];
    [self configurationTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configurationNavigationBar{
    self.view.backgroundColor = MColor(234, 234, 234);
    self.navigationItem.title = @"我的店铺";
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
-(void)viewWillAppear:(BOOL)animated {

    [self obtainStoreData];
}

- (void)obtainStoreData {
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/storeapi/storeDetails", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"storeId"] = self.storeID;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block SellerStoreDataVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@", responseObject);
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC parsingStoreData:responseObject[@"data"][0]];
        }else {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"网络链接超时请重试!" time:1.0];
    }];
}
- (void)parsingStoreData:(NSMutableDictionary *)data {
    [self.sellerDataArray removeAllObjects];
    NSEntityDescription *des = [NSEntityDescription entityForName:@"SellerDataModel" inManagedObjectContext:self.managedContext];
    //根据描述 创建实体对象
    SellerDataModel *model = [[SellerDataModel alloc] initWithEntity:des insertIntoManagedObjectContext:self.managedContext];
    for (NSString *key in data) {
        if ([key isEqualToString:@"storeDescription"]) {
            NSString *valueStr = data[key];
            if (valueStr.length == 0) {
                [model setValue:@" " forKey:@"shopIntroduced"];
            }else {
                [model setValue:data[key] forKey:@"shopIntroduced"];
            }
        }else {
            [model setValue:data[key] forKey:key];
        }
    }
    self.navigationItem.title = model.storeName;
    [self.sellerDataArray addObject:model];
    NSLog(@"self.sellerDataArray%@", self.sellerDataArray);
    [SellerDataSingleton mainSingleton].sellerDataModel = model;
    [self.tableView reloadData];
}

- (void)configurationTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kFit(5), kScreen_widht, kScreen_heigth-kFit(5)) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.backgroundColor = MColor(238, 238, 238);
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[TitleTVCell class] forCellReuseIdentifier:@"TitleTVCell"];
    [_tableView registerClass:[StoreCoverTVCell class] forCellReuseIdentifier:@"StoreCoverTVCell"];
    [_tableView registerClass:[StoreDataTVCell class] forCellReuseIdentifier:@"StoreDataTVCell"];
    [_tableView registerClass:[StoreDataEditorTVCell class] forCellReuseIdentifier:@"StoreDataEditorTVCell"];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sellerDataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SellerDataModel *sellerModel = self.sellerDataArray[0];
    NSLog(@"cellForRowAtIndexPath%@   sellerModel%@", self.sellerDataArray, sellerModel);
    if (indexPath.row == 0) {
        TitleTVCell *cell= [tableView dequeueReusableCellWithIdentifier:@"TitleTVCell" forIndexPath:indexPath];
        cell.model = sellerModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else if(indexPath.row == 1){
        StoreCoverTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCoverTVCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.ReplaceUserImage == nil) {
            cell.CoverImage.image = [UIImage imageNamed:@"zly"];
        }else {
        cell.CoverImage.image = self.ReplaceUserImage;
        }
        return cell;
    }else  {
        StoreDataTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreDataTVCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *dataArray = @[sellerModel.storeTel,[NSString stringWithFormat:@"%@%@", sellerModel.areaInfo,sellerModel.storeAddress], sellerModel.shopIntroduced];
        
        cell.contentLabel.text = dataArray[indexPath.row - 2];
        NSArray *titleArray = @[@"联系电话", @"联系地址", @"店铺简介"];
        cell.titleLabel.text = titleArray[indexPath.row - 2];
        return cell;
    }
}
//店铺资料编辑按钮
- (void)StortDatEditor {


    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        PhotoProperties = 1;
        [self ChangeBackground];
    }
    if (indexPath.row == 2) {
        SellerModifyPhoneVC *VC = [[SellerModifyPhoneVC alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 3) {
        SellerModifyAddressVC *VC = [[SellerModifyAddressVC alloc] init];
        VC.model = self.sellerDataArray[0];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 4) {
        SellerModifyIntroduceVC *VC = [[SellerModifyIntroduceVC alloc] init];
        VC.model = self.sellerDataArray[0];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
//更换店铺的logo
- (void)PictureEditing {
    PhotoProperties = 1;
    [self ChangeBackground];
}

//更换店铺的背景图片
- (void) ChangeBackground{

    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"修改头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *TakingPicturesCancle = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self throughCameraObtainImage];
    }];
    UIAlertAction *PhotoAlbumConfirm = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        DPImagePickerVC *vc = [[DPImagePickerVC alloc]init];
        vc.delegate = self;
        vc.isDouble = NO;
        [self.navigationController pushViewController:vc animated:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return kFit(74);
    }else if(indexPath.row == 1){
        return kFit(109);
    }else if(indexPath.row == 2 || indexPath.row == 3 ){
        return kFit(47);
    }else {
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:kScreen_widht tableView:tableView];
    
    }
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

#pragma mark UIImagePickerController
//从相机获取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *sourceImage = info[UIImagePickerControllerOriginalImage];
    self.ReplaceUserImage = sourceImage;
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

#pragma mark DPImagePickerVCDelegate
//用相册获取头像 自定义
- (void)getCutImage:(UIImage *)image{
    [self.navigationController popViewControllerAnimated:YES];
    self.ReplaceUserImage = image;
    [self.tableView reloadData];
}

//系统提示的弹出窗
- (void)timerFireMethod:(NSTimer*)theTimer {//弹出框
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message time:(CGFloat)time{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}


@end
