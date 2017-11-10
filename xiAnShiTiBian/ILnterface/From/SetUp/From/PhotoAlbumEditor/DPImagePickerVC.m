//
//  DPImagePickerVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//


#import "DPImagePickerVC.h"
#import "MyCollectionViewCell.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>


#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define ImageHeight ([UIScreen mainScreen].bounds.size.width-25)/4

@interface DPImagePickerVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic,strong)NSMutableArray *imageDataArray;

@property (strong, nonatomic) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableIndexSet* selectedIndexSet;

@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)NSMutableArray *selectedArray;

@property (nonatomic,assign)BOOL isChoose;

@end

@implementation DPImagePickerVC
- (NSMutableArray *)imageDataArray{
    if (!_imageDataArray) {
        _imageDataArray = [NSMutableArray array];
    }
    return _imageDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _selectedArray = [NSMutableArray arrayWithCapacity:0];
    
    [self getUI];
    [self initNavi];
}


- (void)getUI{
    
    
    _assetsLibrary = [[ALAssetsLibrary alloc] init];
    _groups = [NSMutableArray array];
    [self loadLibrary];
    _assets = [[NSMutableArray alloc] init];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //       定义一个布局对象
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //    设置item的大小
    flow.itemSize = CGSizeMake(ImageHeight, ImageHeight);
    //    设置行间距
    flow.minimumLineSpacing = 5;
    //    设置列间距
    flow.minimumInteritemSpacing = 5;
    //    设置分区距离上下左右的距离
    flow.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    //    创建一个集合视图，通过布局对象
    self.collectionView =   [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flow];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.collectionView.allowsMultipleSelection = YES;
    //注册cell
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionView"];
    //    设置滚动方向
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //    将collec加入视图
    [self.view addSubview:self.collectionView];
    
    
}
- (void)initNavi{
  
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark -- 加载资源库
- (void)loadLibrary
{
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        
        NSString *errorMessage = nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
            case ALAssetsLibraryAccessGloballyDeniedError:
            {
                errorMessage = @"The user has declined access to it.";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前不能查看照片，请进入IPAD设置->隐私->照片->在实体便应用后面打开开关" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
                break;
            default:
                errorMessage = @"Reason unknown.";
                break;
        }
    };
    
    // emumerate through our groups and only add groups that contain photos
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        
        ALAssetsFilter *assetsFilter = nil;
        assetsFilter = [ALAssetsFilter allAssets];
        [group setAssetsFilter:assetsFilter];
        if ([group numberOfAssets] > 0)
        {
            [self.groups addObject:group];
            //            [_collectionView reloadData];
            
            //            [NSObject cancelPreviousPerformRequestsWithTarget:_collectionView selector:@selector(reloadData) object:nil];
            [self performSelectorOnMainThread:@selector(loadLibraryComplete) withObject:nil waitUntilDone:NO];
        }
        else
        {
            
        }
    };
    
    // enumerate only photos
    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    groupTypes = ALAssetsGroupAll; // 遍历全部相册
    [self.assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
}

- (void)loadLibraryComplete
{
    // 结束以后,如果没有选中的相册，加载第一个相册的照片并显示
    if (_groups.count > 0 && !_assetsGroup) {
        [self loadAssetGroup:[_groups lastObject]];
    }
}

#pragma mark 加载相册
- (void)loadAssetGroup:(ALAssetsGroup *)group
{
    _assetsGroup = group;
    
    [self.assets removeAllObjects];
    
    //    NSString *title = [group valueForProperty:ALAssetsGroupPropertyName];
    //    [self configTitleViewWithTitle:title];
    
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [self.assets addObject:result];
        }
    };
    
    ALAssetsFilter *onlyPhotosFilter = nil;
    onlyPhotosFilter = [ALAssetsFilter allPhotos];
    [self.assetsGroup setAssetsFilter:onlyPhotosFilter];
    [self.assetsGroup enumerateAssetsUsingBlock:assetsEnumerationBlock];
    
    self.assets = [NSMutableArray arrayWithArray:[[self.assets reverseObjectEnumerator] allObjects]];
    [self implement:self.assets];
    
}

- (void)implement:(NSMutableArray *)array
{
    [self.collectionView reloadData];
    if (array.count > 1) {
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    
    
}


#pragma mark -- UICollectionViewDelegate and DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionView" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.imageV.image = [UIImage imageNamed:@"check_photo_camera"];
        cell.seletView.hidden = YES;
    }else{
        
        NSArray* reversedArray = [[_assets reverseObjectEnumerator] allObjects];
        ALAsset *asset = [reversedArray objectAtIndex:indexPath.row - 1];
        
        CGImageRef thumbnailImageRef = [asset thumbnail];
        UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
        
        // apply the image to the cell
        cell.imageV.image = thumbnail;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusDenied) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前不能拍摄，请进入IPAD设置->隐私->相机->在房专家应用后面打开开关" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        [self useCamera];
    }else{
        NSArray* reversedArray = [[_assets reverseObjectEnumerator] allObjects];
        ALAsset *asset = [reversedArray objectAtIndex:indexPath.row - 1];
        
        ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
        UIImage *fullScreenImage = [UIImage imageWithCGImage:[assetRepresentation fullResolutionImage]
                                                       scale:[assetRepresentation scale]
                                                 orientation:(int)[assetRepresentation orientation]];
        
        
       /* if (self.isDouble == YES) {
            
            UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            //            NSData *date = UIImageJPEGRepresentation(image, 1.0);
            
            BOOL IsReal = 0;
            for (int i = 0; i < _selectedArray.count; i++) {
                if ([image isEqual:_selectedArray[i]]) {
                    IsReal = 1;
                    [_selectedArray removeObject:_selectedArray[i]];
                    cell.backgroundColor = [UIColor clearColor];
                    [_selectedArray addObject:image];
                }
            }
            if (IsReal) {
                [_selectedArray removeObject:image];
                cell.seletView.image = [UIImage imageNamed:@"list_no_tick_round"];
            }else{
                cell.seletView.image = [UIImage imageNamed:@"list_tick_round"];
                [_selectedArray addObject:image];
            }
            
            
        }else{
        
        */
            [self.selectedArray removeAllObjects];
            //               获取选择的图片
            self.image = fullScreenImage;
            [self.selectedArray addObject:self.image];
            
            [self updateCollectionViewCellStatus:cell selected:YES];
    



        
    }
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.seletView.image = [UIImage imageNamed:@"list_no_tick_round"];
    
}

-(void)updateCollectionViewCellStatus:(MyCollectionViewCell *)myCollectionCell selected:(BOOL)selected{
    myCollectionCell.seletView.image = [UIImage imageNamed:@"list_tick_round"];
    
}

-(void)useCamera{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
    [self presentViewController:pickerController animated:YES completion:nil];
}



#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    
    if ([self.delegate respondsToSelector:@selector(getCutImage:)]) {
        [self.delegate getCutImage:image ];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if ([self.delegate respondsToSelector:@selector(getCutImage:)]) {
        [self.delegate getCutImage:image ];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self implement:self.assets];
}
#pragma mark -- ActionMethod

- (void)leftBarAction{
   [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarAction{

    if (self.isDouble == NO) {
        
        if ([self.delegate respondsToSelector:@selector(getCutImage:)]) {
            [self.delegate getCutImage:self.image];
        }
    }else {
    
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
    MDIC[@"memberId"] = self.userID;
    MDIC[@"nichen"] = @"";
    MDIC[@"birthday"] = @"";
    MDIC[@"sex"] = @"";
    MDIC[@"areaInfo"] = @"";
    __block DPImagePickerVC *VC = self;
    [manager POST:UrL_Two parameters:MDIC constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
            UIImage *images = self.image;
        
            NSData *picData = UIImageJPEGRepresentation(images, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *fileName = [NSString stringWithFormat:@"%@.png", @"face"];
            [formData appendPartWithFileData:picData name:[NSString stringWithFormat:@"face"]
                                    fileName:fileName mimeType:@"image/png"];
        
        
    } success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [VC performSelector:@selector(delayMethod)];
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC AnalysisUserData:self.userID];
        }else {
            [VC showAlert:@"修改失败" time:1.0];
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull operation, NSError * _Nonnull error) {
        [VC showAlert:@"请求失败请重试" time:1.0];
        [VC performSelector:@selector(delayMethod)];

    }];
        
    }
}


//获取用户详情信息 用来存储到本地判断登录状态
- (void)AnalysisUserData:(NSString *)memberId{
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/memberapi/memberDetail",kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"memberId"] = memberId;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __block DPImagePickerVC *VC = self;
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@", responseObject);
        [VC performSelector:@selector(delayMethod)];
        [VC AnalyticalDataDetails:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [VC showAlert:@"请求失败请重试" time:1.0];
        [VC performSelector:@selector(delayMethod)];
    }];
}
//解析用户详情数据 并且存储到本地一份
- (void)AnalyticalDataDetails:(NSDictionary *)dic {
    
    NSString *state = [NSString stringWithFormat:@"%@", dic[@"result"]];
    if ([state isEqualToString:@"1"]) {
        NSDictionary *urseDataDic = dic[@"data"][0];
        
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
        [self showAlert:@"修改成功" time:1.0];
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self showAlert:@"修改失败请重试" time:1.0];
        
    }
    
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
