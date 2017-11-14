//
//  SellerEnteringVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/7.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "RegisteredEnteringVC.h"
#import "InputView.h" //输入框view
@interface RegisteredEnteringVC ()<UIScrollViewDelegate, UITextFieldDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate,DPImagePickerDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
/**
 *和在UIScrollView上层的UIView 承载控件用的
 */
@property (nonatomic, strong)UIView *wrapperView;
/**
 *开店协议 view
 */
@property (nonatomic, strong)UIView *OpenShopAgreementView;
/**
 *个人信息 view
 */
@property (nonatomic, strong)UIView *PersonalInformationView;
//输入用户名
@property (nonatomic, strong)InputView *personalNameInputView;
//输入联系方式
@property (nonatomic, strong)InputView *personalPhoneInputView;
//输入身份证
@property (nonatomic, strong)InputView *personalIdCardInputView;
/**
 *店铺信息 view
 */
@property (nonatomic, strong)UIView *StoreInformationView;
//输入店铺名字
@property (nonatomic, strong)InputView *storeNameInputView;
//输入店铺类型
@property (nonatomic, strong)InputView *storeTypeInputView;
//输入店铺位置
@property (nonatomic, strong)InputView *storeLocationInputView;
//输入银行卡
@property (nonatomic, strong)InputView *bankCardInputView;
/**
 *提交按钮
 */
@property (nonatomic, strong)UIButton *submitButton;

@property (nonatomic, strong)UIImagePickerController *picker;

//  上传图片数组
@property (nonatomic, strong)NSMutableArray *picArray;
//  上传图片字典
@property (nonatomic, strong)NSMutableDictionary *picDictionary;

@end

@implementation RegisteredEnteringVC{
    /**
     *这个参数用来判断用户是否移动过地图 因为 regionDidChangeAnimated方法在你没有移动地图是默认位置是北京 但是这样会影响单地理位置编码 给用户显示现在位置 所以需要在第一次进入该方法的时候将定位的经纬度给他地理位置编码
     */
    BOOL  LocateState;
    //身份证 image1
    UIButton *IdCardBtnOne;
    //身份证 image2
    UIButton *IdCardBtnTwo;
    //营业执照 image1
    UIButton *businessLicenseBtnOne;
    //营业执照 image2
    UIButton *businessLicenseBtnTwo;
    NSInteger btnTag;
    
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
        _scrollView.sd_layout.topSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"成为店家";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    self.view.backgroundColor = MColor(238, 238, 238);
    [self createScrollView];
    NSLog(@"%f---测试数据---%f", self.scrollView.frame.size.height, self.scrollView.contentSize.height);
    
}
- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//创建 UIScrollView
- (void)createScrollView {
    
    self.wrapperView = [UIView new];
    _wrapperView.backgroundColor = MColor(238, 238, 238);
    [self.scrollView addSubview:self.wrapperView];
    [self.scrollView setupAutoContentSizeWithBottomView:self.wrapperView bottomMargin:0];
    //协议
    [self createOpenShopAgreement];
    //个人信息
    [self createPersonalInformation];
    //店铺信息
    [self createStoreInformation];
    
    self.submitButton = [UIButton new];
    _submitButton.titleLabel.font = MFont(kFit(17));
    _submitButton.backgroundColor = [UIColor whiteColor];
    _submitButton.layer.cornerRadius = 3;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton setTitle:@"提交申请" forState:(UIControlStateNormal)];
    [_submitButton setTitleColor:MColor(60, 186, 153) forState:(UIControlStateNormal)];
    [self.scrollView addSubview:_submitButton];
    _submitButton.sd_layout.topSpaceToView(self.StoreInformationView, kFit(10)).widthIs(kFit(300)).heightIs(kFit(50)).centerXEqualToView(self.scrollView);
    
    self.wrapperView.sd_layout.
    leftEqualToView(self.scrollView)
    .rightEqualToView(self.scrollView)
    .topEqualToView(self.scrollView)
    .heightIs(kScreen_heigth * 3);
    [self.wrapperView setupAutoHeightWithBottomView:_submitButton bottomMargin:10];

}
//创建开店协议模块
- (void)createOpenShopAgreement{
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.wrapperView addSubview:bottomView];
    self.OpenShopAgreementView = bottomView;
    bottomView.sd_layout
    .leftSpaceToView(_wrapperView, 0)
    .topSpaceToView(_wrapperView, kFit(10))
    .rightSpaceToView(_wrapperView, 0)
    .heightIs(kFit(221));
        {
            UIView *agreementView = [UIView new];
            agreementView.backgroundColor = [UIColor yellowColor];
            agreementView.layer.borderWidth = 1;
            agreementView.layer.borderColor = MColor(134, 134, 134).CGColor;
            agreementView.layer.cornerRadius = 3;
            agreementView.layer.masksToBounds = YES;
            [bottomView addSubview:agreementView];
            agreementView.sd_layout.centerXEqualToView(bottomView).centerYEqualToView(bottomView).widthIs(kFit(351)).heightIs(kFit(200));
            
            UILabel *titleLabel = [UILabel new];
            titleLabel.textColor = MColor(51, 51, 51);
            titleLabel.font = MFont(kFit(14));
            titleLabel.text = @"成为商家须知";
            titleLabel.textAlignment = 1;
            [agreementView addSubview:titleLabel];
            titleLabel.sd_layout.leftSpaceToView(agreementView, 0).topSpaceToView(agreementView, kFit(5)).rightSpaceToView(agreementView, 0).heightIs(kFit(14));
            UITextView *contentTV = [UITextView new];
            contentTV.text = @"1.1111111111111111111 \n2.22222222222222 \n3.3333333333333333333 \n4.4444444444444444444 \n5.555555555555555555 \n6.666666666666666666666 \n7.7777777777777777 \n8.8888888888888888 \n9.999999999999999999999 \n9.999999999999999999999 \n9.999999999999999999999 \n9.999999999  999999999999 \n9.999999999999999999999";
            contentTV.editable = NO;
            contentTV.textColor = MColor(51, 51, 51);
            contentTV.font = MFont(kFit(12));
            [agreementView addSubview:contentTV];
            contentTV.sd_layout.leftSpaceToView(agreementView, kFit(5)).topSpaceToView(titleLabel, kFit(5)).rightSpaceToView(agreementView, kFit(5)).bottomSpaceToView(agreementView, kFit(25));
            UIButton *AgreeDealBtn = [UIButton new];
            [AgreeDealBtn setTitle:@"我已阅读并且同意协议内容" forState:(0)];
            [AgreeDealBtn setTitleColor:MColor(51, 51, 51) forState:0];
            AgreeDealBtn.titleLabel.font = MFont(kFit(14));
            [agreementView addSubview:AgreeDealBtn];
            AgreeDealBtn.sd_layout.heightIs(kFit(15)).widthIs(190).centerXEqualToView(agreementView).topSpaceToView(contentTV, kFit(5));
            UIButton *chooseBtn = [UIButton new];
            [chooseBtn setImage:[UIImage imageNamed:@"wd-wssj-cwsj-xy"] forState:(UIControlStateNormal)];
            [chooseBtn setImage:[UIImage imageNamed:@"wd-cwsj-xygx"] forState:(UIControlStateSelected)];
            [chooseBtn addTarget:self action:@selector(handleAgreeDeal:) forControlEvents:(UIControlEventTouchUpInside)];
            [agreementView addSubview:chooseBtn];
            chooseBtn.sd_layout.bottomSpaceToView(agreementView, 5).widthIs(kFit(15)).heightIs(kFit(15)).rightSpaceToView(AgreeDealBtn, kFit(0));
        }
}

- (void)handleAgreeDeal:(UIButton *)sender {
    btnTag = sender.tag;
    
    sender.selected = !sender.selected;
}
//创建个人信息模块
- (void)createPersonalInformation {
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    self.PersonalInformationView = bottomView;
    [self.wrapperView addSubview:bottomView];
    
    bottomView.sd_layout
    .leftSpaceToView(_wrapperView, 0)
    .topSpaceToView(_OpenShopAgreementView, kFit(10))
    .rightSpaceToView(_wrapperView, 0)
    .heightIs(kFit(241));
        {
            UILabel *titleLabel = [UILabel new];
            titleLabel.text = @"个人信息填写";
            titleLabel.textColor = MColor(51, 51, 51);
            titleLabel.font = MFont(kFit(15));
            [bottomView addSubview:titleLabel];
            titleLabel.sd_layout.leftSpaceToView(bottomView,kFit(12)).topSpaceToView(bottomView, kFit(11)).widthIs(kFit(200)).heightIs(kFit(15));
            
            self.personalNameInputView = [InputView new];
            _personalNameInputView.titleLabel.text = @"真实姓名:";
            _personalNameInputView.dataTF.placeholder = @"请输入真实姓名";
            _personalNameInputView.dataTF.delegate = self;
            [bottomView addSubview:_personalNameInputView];
            _personalNameInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(titleLabel, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
            
            self.personalPhoneInputView = [InputView new];
            _personalPhoneInputView.titleLabel.text = @"联系电话:";
            _personalPhoneInputView.dataTF.placeholder = @"您的联系方式";
            _personalPhoneInputView.dataTF.delegate = self;
            [bottomView addSubview:_personalPhoneInputView];
            _personalPhoneInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_personalNameInputView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
            
            self.personalIdCardInputView = [InputView new];
            _personalIdCardInputView.titleLabel.text = @"身份证号码:";
            _personalIdCardInputView.dataTF.placeholder = @"请输入您的身份证号";
            _personalIdCardInputView.dataTF.delegate = self;
            [bottomView addSubview:_personalIdCardInputView];
            _personalIdCardInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_personalPhoneInputView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
            
            UILabel *IdCardLabel = [UILabel new];
            IdCardLabel.text = @"上传身份证正反面";
            IdCardLabel.textColor = MColor(51, 51, 51);
            IdCardLabel.font = MFont(kFit(14));
            [bottomView addSubview:IdCardLabel];
            IdCardLabel.sd_layout.leftSpaceToView(bottomView, kFit(22)).topSpaceToView(_personalIdCardInputView, kFit(5)).widthIs(kFit(200)).heightIs(kFit(14));
            
            IdCardBtnOne = [UIButton new];
            IdCardBtnOne.backgroundColor = MColor(238, 238, 238);
            IdCardBtnOne.tag = 101;
            [IdCardBtnOne addTarget:self action:@selector(GetPhotoBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            [IdCardBtnOne setImage:[UIImage imageNamed:@"wd-cwdj-tjzp"] forState:(UIControlStateNormal)];
            [bottomView addSubview:IdCardBtnOne];
            IdCardBtnOne.sd_layout.leftSpaceToView(bottomView, kFit(20)).topSpaceToView(IdCardLabel, kFit(11)).widthIs(kFit(160)).heightIs(kFit(100));
            
            IdCardBtnTwo = [UIButton new];
            IdCardBtnTwo.tag = 102;
            [IdCardBtnTwo addTarget:self action:@selector(GetPhotoBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            IdCardBtnTwo.backgroundColor = MColor(238, 238, 238);
            [IdCardBtnTwo setImage:[UIImage imageNamed:@"wd-cwdj-tjzp"] forState:(UIControlStateNormal)];
            [bottomView addSubview:IdCardBtnTwo];
            IdCardBtnTwo.sd_layout.rightSpaceToView(bottomView, kFit(20)).topSpaceToView(IdCardLabel, kFit(11)).widthIs(kFit(160)).heightIs(kFit(100));
        }

}
//创建店铺信息模块
- (void)createStoreInformation {
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    self.StoreInformationView = bottomView;
    [self.wrapperView addSubview:bottomView];
    
    bottomView.sd_layout
    .leftSpaceToView(_wrapperView, 0)
    .topSpaceToView(_PersonalInformationView, kFit(10))
    .rightSpaceToView(_wrapperView, 0)
    .heightIs(kFit(266));
        {
            UILabel *titleLabel = [UILabel new];
            titleLabel.text = @"店铺信息填写";
            titleLabel.textColor = MColor(51, 51, 51);
            titleLabel.font = MFont(kFit(15));
            [bottomView addSubview:titleLabel];
            titleLabel.sd_layout.leftSpaceToView(bottomView,kFit(12)).topSpaceToView(bottomView, kFit(11)).widthIs(kFit(200)).heightIs(kFit(15));
        
            self.storeNameInputView = [InputView new];
            _storeNameInputView.titleLabel.text = @"店铺名称:";
            _storeNameInputView.dataTF.placeholder = @"请输入店铺名称";
            _storeNameInputView.dataTF.delegate = self;
            [bottomView addSubview:_storeNameInputView];
            _storeNameInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(titleLabel, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
            
            self.storeTypeInputView = [InputView new];
            _storeTypeInputView.titleLabel.text = @"店铺类型:";
            _storeTypeInputView.dataTF.placeholder = @"您的店铺类型";
            _storeTypeInputView.dataTF.delegate = self;
            [bottomView addSubview:_storeTypeInputView];
            _storeTypeInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_storeNameInputView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
            
            self.storeLocationInputView = [InputView new];
            _storeLocationInputView.titleLabel.text = @"店铺位置:";
            _storeLocationInputView.dataTF.placeholder = @"请输入您的店铺位置";
            _storeLocationInputView.dataTF.delegate = self;
            [bottomView addSubview:_storeLocationInputView];
            _storeLocationInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_storeTypeInputView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));

            self.bankCardInputView = [InputView new];
            _bankCardInputView.titleLabel.text = @"绑定银行卡:";
            _bankCardInputView.dataTF.placeholder = @"请输入您的银行卡";
            _bankCardInputView.dataTF.delegate = self;
            [bottomView addSubview:_bankCardInputView];
            _bankCardInputView.sd_layout.leftSpaceToView(bottomView, 0).topSpaceToView(_storeLocationInputView, 0).rightSpaceToView(bottomView, 0).heightIs(kFit(24));
            
            UILabel *businessLicenseLabel = [UILabel new];
            businessLicenseLabel.text = @"上传身份证正反面";
            businessLicenseLabel.textColor = MColor(51, 51, 51);
            businessLicenseLabel.font = MFont(kFit(14));
            [bottomView addSubview:businessLicenseLabel];
            businessLicenseLabel.sd_layout.leftSpaceToView(bottomView, kFit(22)).topSpaceToView(_bankCardInputView, kFit(5)).widthIs(kFit(200)).heightIs(kFit(14));
            
            businessLicenseBtnOne = [UIButton new];
            businessLicenseBtnOne.tag = 103;
            [businessLicenseBtnOne addTarget:self action:@selector(GetPhotoBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            businessLicenseBtnOne.backgroundColor = MColor(238, 238, 238);
            [businessLicenseBtnOne setImage:[UIImage imageNamed:@"wd-cwdj-tjzp"] forState:(UIControlStateNormal)];
            [bottomView addSubview:businessLicenseBtnOne];
            businessLicenseBtnOne.sd_layout.leftSpaceToView(bottomView, kFit(20)).topSpaceToView(businessLicenseLabel, kFit(11)).widthIs(kFit(160)).heightIs(kFit(100));
            
            businessLicenseBtnTwo = [UIButton new];
            businessLicenseBtnTwo.tag = 104;
            [businessLicenseBtnTwo addTarget:self action:@selector(GetPhotoBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            businessLicenseBtnTwo.backgroundColor = MColor(238, 238, 238);
            [businessLicenseBtnTwo setImage:[UIImage imageNamed:@"wd-cwdj-tjzp"] forState:(UIControlStateNormal)];
            [bottomView addSubview:businessLicenseBtnTwo];
            businessLicenseBtnTwo.sd_layout.rightSpaceToView(bottomView, kFit(20)).topSpaceToView(businessLicenseLabel, kFit(11)).widthIs(kFit(160)).heightIs(kFit(100));
        }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}

- (void)GetPhotoBtn:(UIButton *)sender {
    btnTag = sender.tag;
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"修改头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *TakingPicturesCancle = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
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

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *sourceImage = info[UIImagePickerControllerOriginalImage];
    
    switch (btnTag) {
            
            //   如何获取从相机拍摄到的照片并且存到字典
        case 101: {
            [IdCardBtnOne setImage:sourceImage forState:(UIControlStateNormal)];
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
        case 102:
        {
            [IdCardBtnTwo setImage:sourceImage forState:(UIControlStateNormal)];
            
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
        case 103:
        {
            [businessLicenseBtnOne setImage:sourceImage forState:(UIControlStateNormal)];
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
            [businessLicenseBtnTwo setImage:sourceImage forState:(UIControlStateNormal)];
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

//用相册获取头像
- (void)getCutImage:(UIImage *)image{
    [self.navigationController popViewControllerAnimated:YES];
    UIImage *sourceImage = image;
    
    switch (btnTag) {
            
            //   如何获取从相机拍摄到的照片并且存到字典
        case 101: {
            [IdCardBtnOne setImage:sourceImage forState:(UIControlStateNormal)];
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
        case 102:
        {
            [IdCardBtnTwo setImage:sourceImage forState:(UIControlStateNormal)];
            
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
        case 103:
        {
            [businessLicenseBtnOne setImage:sourceImage forState:(UIControlStateNormal)];
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
            [businessLicenseBtnTwo setImage:sourceImage forState:(UIControlStateNormal)];
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
    

}


@end
