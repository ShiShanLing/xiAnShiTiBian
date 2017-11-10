//
//  BaseViewController.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/9/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface BaseViewController : UIViewController
@property (nonatomic, strong)AppDelegate *delegate;
/**
 *
 */
@property (nonatomic, strong)NSManagedObjectContext *managedContext;
@end
