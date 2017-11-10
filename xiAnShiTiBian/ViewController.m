//
//  ViewController.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/18.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong)UIScrollView *scrolView;

@property (nonatomic, strong) UIButton *isButton;
@property (nonatomic, strong) UIButton *theButton;
@property (nonatomic, strong) UIButton *personButton;
@property (nonatomic, assign) NSInteger btnTag;//标记是哪个拍照按钮点击的，进而对该按钮对应的照片赋值
@property (nonatomic, strong)UIImageView *isImageView;
@property (nonatomic, strong)UIImageView *theImageView;
@property (nonatomic, strong)UIImageView *personImageView;
@property (nonatomic, strong)UIImageView *LicencePositive;
@property (nonatomic, strong)UIImageView *OneImage;
@property (nonatomic, strong)UIImageView *TwoImage;

@property (nonatomic, strong)UIButton *loginButton;
@property (nonatomic, strong)UIImagePickerController *picker;

//  上传图片数组
@property (nonatomic, strong)NSMutableArray *picArray;
//  上传图片字典
@property (nonatomic, strong)NSMutableDictionary *picDictionary;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  添加scrollview
    [self addScrollView];
    
    // 添加上传图片
    [self addUpPhoto];
}

#pragma mark 添加scrollview
- (void)addScrollView {
    self.scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.scrolView.backgroundColor = [UIColor grayColor];
    self.scrolView.delegate = self;
    //  是否支持滑动到最顶端
    //    self.scrolView.scrollsToTop = NO;
    self.scrolView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 2);
    //   是否反弹
    self.scrolView.bounces = NO;
    //   是否分页
    self.scrolView.pagingEnabled = NO;
    //  是否滚动
    //    self.scrolView.scrollEnabled = NO;
    //  设置indicator风格
    self.scrolView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //  设置内容的边距和indicators边缘
    //    self.scrolView.contentInset = UIEdgeInsetsMake(0, 50, 50, 0);
    //  提示用户
    [self.scrolView flashScrollIndicators];
    
    //  是否同时运动
    self.scrolView.directionalLockEnabled = YES;
    [self.view addSubview:self.scrolView];
    
}

#pragma  mark ---上传图片
- (void)addUpPhoto {
    
    CGFloat width = (kScreen_widht - 15) /2;
    //  身份证正面
    self.isImageView = [UIImageView new];
    self.isImageView.backgroundColor = [UIColor redColor];
    _isImageView.userInteractionEnabled = YES;
    [self.scrolView addSubview:self.isImageView];
    _isImageView.sd_layout.leftSpaceToView(self.scrolView, 5).topSpaceToView(self.scrolView, 64).widthIs(width).heightIs(width);
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap1)];
    [self.isImageView addGestureRecognizer:tap1];
    
    //  身份证反面
    self.theImageView = [[UIImageView alloc]init];
    self.theImageView.frame = CGRectMake( 20, 300, 200, 200);
    self.theImageView.backgroundColor = [UIColor purpleColor];
    _theImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap2)];
    [self.theImageView addGestureRecognizer:tap2];
    [self.scrolView addSubview:self.theImageView];
    _theImageView.sd_layout.rightSpaceToView(self.scrolView, 5).topSpaceToView(self.scrolView, 64).widthIs(width).heightIs(width);
    
    //驾驶证正面
    self.personImageView = [[UIImageView alloc]init];
    self.personImageView.frame = CGRectMake(20, 535, 200, 200);
    self.personImageView.backgroundColor = [UIColor greenColor];
    _personImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap3)];
    [self.personImageView addGestureRecognizer:tap3];
    [self.scrolView addSubview:self.personImageView];
    _personImageView.sd_layout.leftSpaceToView(self.scrolView, 5).topSpaceToView(_isImageView, 5).widthIs(width).heightIs(width);
    //驾驶证反面
    self.LicencePositive = [[UIImageView alloc]init];
    self.LicencePositive.frame = CGRectMake(20, 535, 200, 200);
    self.LicencePositive.backgroundColor = [UIColor magentaColor];
    _LicencePositive.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap4)];
    [self.LicencePositive addGestureRecognizer:tap4];
    [self.scrolView addSubview:self.LicencePositive];
    _LicencePositive.sd_layout.rightSpaceToView(self.scrolView, 5).topSpaceToView(_theImageView, 5).widthIs(width).heightIs(width);
    
  
    self.OneImage = [[UIImageView alloc] init];
    _OneImage.frame = CGRectMake(20, 535, 200, 200);
    _OneImage.backgroundColor = [UIColor magentaColor];
    _OneImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap5)];
    [_OneImage addGestureRecognizer:tap5];
    [self.scrolView addSubview:_OneImage];
    _OneImage.sd_layout.leftSpaceToView(self.scrolView, 5).topSpaceToView(_personImageView, 5).widthIs(width).heightIs(width);

    
    //驾驶证反面
    self.TwoImage = [[UIImageView alloc]init];
    _TwoImage.frame = CGRectMake(20, 535, 200, 200);
    _TwoImage.backgroundColor = [UIColor magentaColor];
    _TwoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap6)];
    [_TwoImage addGestureRecognizer:tap6];
    [self.scrolView addSubview:_TwoImage];
    _TwoImage.sd_layout.rightSpaceToView(self.scrolView, 5).topSpaceToView(_personImageView, 5).widthIs(width).heightIs(width);

    
    
    
    //  提交按钮
    self.loginButton = [[UIButton alloc]init];
    [_loginButton setTitle:@"提交" forState:(UIControlStateNormal)];
    self.loginButton.backgroundColor = [UIColor yellowColor];
    [self.loginButton addTarget:self action:@selector(loginButtonClik:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrolView addSubview:self.loginButton];
    _loginButton.sd_layout.leftSpaceToView(self.scrolView, 30).topSpaceToView(_TwoImage, 10).rightSpaceToView(self.scrolView, 30).heightIs(30);
}

- (void)handleTap1 {
    self.btnTag = 100;
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
- (void)handleTap2 {
    self.btnTag = 101;
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
- (void)handleTap3 {
    self.btnTag = 102;
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
- (void)handleTap4 {
    
    
    self.btnTag = 103;
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
- (void)handleTap5 {
    
    
    self.btnTag = 104;
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
- (void)handleTap6 {
    
    
    self.btnTag = 105;
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
#pragma mark通过相机获取照片并且传服务器

- (void)isButtonClick:(UIButton *)button {
    
    //  给设置一个全局的tag值
    self.btnTag = button.tag;
    
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    UIImage *sourceImage = info[UIImagePickerControllerOriginalImage];
    
    switch (self.btnTag) {
            
            //   如何获取从相机拍摄到的照片并且存到字典
        case 100: {
            self.isImageView.image = sourceImage;
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"isImage"]) {
                
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"isImage"];
                [self.picDictionary setObject:sourceImage forKey:@"isImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"isImage"];
            }
            
            break;
        }
        case 101:
        {
            self.theImageView.image = sourceImage;
            
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"theImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"theImage"];
                [self.picDictionary setObject:sourceImage forKey:@"theImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"theImage"];
            }
            break;
        }
        case 102:
        {
            self.personImageView.image = sourceImage;
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }
        case 103:
        {
            self.LicencePositive.image = sourceImage;
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }
        case 104:
        {
            _OneImage.image = sourceImage;
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }
        case 105:
        {
            _TwoImage.image = sourceImage;
            [self.picArray addObject:sourceImage];
            if ([[self.picDictionary allKeys]containsObject:@"personImage"]) {
                // 如果存在删除
                [self.picDictionary removeObjectForKey:@"personImage"];
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
                
            } else {
                // 如果不存在就添加
                [self.picDictionary setObject:sourceImage forKey:@"personImage"];
            }
            break;
        }

        default:
            break;
    }
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark 绘制图片
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.picker dismissModalViewControllerAnimated:YES];
}
//登录按钮
- (void)loginButtonClik:(UIButton *)button {
        
    //司机注册
    NSString *UrL_Two = [NSString stringWithFormat:@"%@/memberapi/updateMember", kSHY_100];
    
    //carownerapi/ save_carowner
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
    MDIC[@"memberId"] = @"f92abddf1e034db19d764e402bd4f9fd";
    MDIC[@"nichen"] = @"";//
    MDIC[@"birthday"] = @"";
    MDIC[@"sex"] = @"";//身份证号码
    MDIC[@"areaInfo"] = @"";
   
    [manager POST:UrL_Two parameters:MDIC constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        for (int i = 0; i < self.picArray.count; i ++) {
        //  图片上传
            UIImage *images = self.picArray[i];
            NSLog(@"查看数组%@", self.picArray);
            NSData *picData = UIImageJPEGRepresentation(images, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            
            NSArray *nameArray = @[@"id_card_front", @"id_card_back", @"vehicle_registration_front", @"vehicle_registration_back", @"driving_license_front", @"driving_license_back"];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", nameArray[i]];
            NSLog(@"成功%@  ---%@", formData, images);
            [formData appendPartWithFileData:picData name:[NSString stringWithFormat:@"face"]
                                    fileName:fileName mimeType:@"image/png"];
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@<><><><><>>?>  %@", operation, responseObject);
        NSLog(@"成功");
    } failure:^(NSURLSessionDataTask * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"错误信息=====%@", error.description);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(NSMutableDictionary *)picDictionary {
    if (_picDictionary == nil) {
        _picDictionary = [NSMutableDictionary dictionary];
    }
    return _picDictionary;
}
- (NSMutableArray *)picArray {
    if (_picArray == nil) {
        _picArray = [NSMutableArray array];
    }
    return _picArray;
}
@end
