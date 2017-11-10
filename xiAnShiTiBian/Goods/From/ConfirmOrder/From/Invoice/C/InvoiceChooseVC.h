//
//  InvoiceChooseVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/19.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^InvoiceChooseBlock)(NSInteger index,NSString *InvoiceType);
/**
 *发票信息VC
 */
@interface InvoiceChooseVC : UIViewController

@property (nonatomic, copy) InvoiceChooseBlock returnTextBlock;

@end
