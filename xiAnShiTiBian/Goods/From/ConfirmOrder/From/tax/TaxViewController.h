//
//  TaxViewController.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/22.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TaxIndexBlock)(NSInteger index);
/**
 *是否含税
 */
@interface TaxViewController : UIViewController

@property (nonatomic, assign)int defaultState;

@property (nonatomic, copy) TaxIndexBlock TaxIndexBlock;

@end
