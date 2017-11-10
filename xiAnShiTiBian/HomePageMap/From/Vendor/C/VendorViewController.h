//
//  VendorViewController.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FactoryDataModel;
/**
 *厂商界面
 */
@interface VendorViewController : UIViewController

@property (nonatomic, strong)NSString *VendorStr;

@property (nonatomic, strong)FactoryDataModel *model;

@property (nonatomic, strong)NSMutableArray *vendorArray;

@end
