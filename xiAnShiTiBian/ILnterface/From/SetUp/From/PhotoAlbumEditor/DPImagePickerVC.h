//
//  DPImagePickerVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//


#import "BaseViewController.h"

@class DPImagePickerVC;

@protocol DPImagePickerDelegate <NSObject>

@optional
- (void)getCutImage:(UIImage *)image;
//传出的是NSdata数组
- (void)getImageArray:(NSMutableArray *)arrayImage;

@end
/**
 *自定义的相册选择界面
 */
@interface DPImagePickerVC : BaseViewController

@property (nonatomic, assign)id<DPImagePickerDelegate>delegate;

//判断从那个界面进来的 NO为司机注册界面
@property (nonatomic,assign)BOOL isDouble;

@property (nonatomic, strong)NSString *userID;

@end
