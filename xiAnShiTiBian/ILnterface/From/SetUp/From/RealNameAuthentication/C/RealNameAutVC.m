//
//  RealNameAutVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/9.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "RealNameAutVC.h"

@interface RealNameAutVC ()<DPImagePickerDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *IdNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *IDCardFrontImage;
@property (weak, nonatomic) IBOutlet UIButton *IDCardContraryImage;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (nonatomic, strong)UIImagePickerController *picker;
/**
 *存储选择照片
 */
@property (nonatomic, strong)NSMutableArray *ImageArray;
//  上传图片字典
@property (nonatomic, strong)NSMutableDictionary *picDictionary;
@end

@implementation RealNameAutVC{

NSInteger btnTag;
}

- (NSMutableArray *)ImageArray {
    if (!_ImageArray) {
        _ImageArray = [NSMutableArray array];
    }
    return _ImageArray;
}
- (NSMutableDictionary *)picDictionary {
    if (!_picDictionary) {
        _picDictionary = [NSMutableDictionary dictionary];
    }
    return _picDictionary;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.IdNumberTF.delegate = self;
    self.IdNumberTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.IdNumberTF.returnKeyType = UIReturnKeyDone;
    self.IDCardFrontImage.layer.cornerRadius = 3;
    self.IDCardFrontImage.layer.masksToBounds = YES;
    self.IDCardContraryImage.layer.cornerRadius = 3;
    self.IDCardContraryImage.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 3;
    self.submitBtn.layer.masksToBounds = YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    return YES;
    
}

- (IBAction)handleSumitBtn:(id)sender {
     NSArray *tempArray1 = [self.picDictionary allKeys];
    if (tempArray1.count != 2) {
        [self showAlert:@"图片不能为空" time:1.0];
        return;
    }
    if (_IdNumberTF.text.length == 0) {
        [self showAlert:@"身份证号不能为空" time:1.0];
        return;
    }
    NSString *URL_Str = [NSString stringWithFormat:@"%@/memberapi/realNameAuthentication", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"memberId"] = self.membersID;
    URL_Dic[@"idCardNo"] = self.IdNumberTF.text;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    __weak RealNameAutVC *VC = self;
    NSLog(@"URL_Str%@ URL_Dic%@", URL_Str, URL_Dic);
    [session POST:URL_Str parameters:URL_Dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSArray *tempArray = [self.picDictionary allKeys];
        for (int i = 0; i < tempArray.count; i ++) {
            UIImage *images = self.picDictionary[tempArray[i]];
            NSData *picData = UIImageJPEGRepresentation(images, 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSArray *nameArray = @[@"id_card_front", @"id_card_back"];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", nameArray[i]];
            [formData appendPartWithFileData:picData name:[NSString stringWithFormat:@"myfiles"]
                                    fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSString *successStr = [NSString stringWithFormat:@"%@", dic[@"success"]];
        if ([successStr isEqualToString:@"1"]) {
            [VC showAlert:dic[@"message"] time:1.0];
            [VC.navigationController popViewControllerAnimated:YES];
        }else {
            [VC showAlert:dic[@"message"] time:1.0];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@", error);
        [VC showAlert:@"网络出错请稍后重试" time:1.0];
    }];
     
}
- (IBAction)handleIDCardFrontImage:(id)sender {
    btnTag = 0;
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"选择照片" preferredStyle:UIAlertControllerStyleActionSheet];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return YES;
    }
    return YES;
}

- (IBAction)handleIFCardContraryImage:(id)sender {
    btnTag = 1;
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"选择照片" preferredStyle:UIAlertControllerStyleActionSheet];
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

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.picker dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//用相册获取头像
- (void)getCutImage:(UIImage *)image{
    [self.navigationController popViewControllerAnimated:YES];
    UIImage *sourceImage = image;
    
    switch (btnTag) {
            
            //   如何获取从相机拍摄到的照片并且存到字典
        case 0: {
            [self.IDCardFrontImage setImage:sourceImage forState:(UIControlStateNormal)];
            
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
        case 1:
        {
            [self.IDCardContraryImage setImage:sourceImage forState:(UIControlStateNormal)];
            
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
      
        default:
            break;
    }
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}
//从相机获取图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *sourceImage = info[UIImagePickerControllerOriginalImage];
    
    switch (btnTag) {
            
            //   如何获取从相机拍摄到的照片并且存到字典
        case 0: {
            [self.IDCardFrontImage setImage:sourceImage forState:(UIControlStateNormal)];
            [self.ImageArray addObject:sourceImage];
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
        case 1:
        {
            [self.IDCardContraryImage setImage:sourceImage forState:(UIControlStateNormal)];
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
            
        default:
            break;
    }
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
}
//从相册获取图片
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

@end
