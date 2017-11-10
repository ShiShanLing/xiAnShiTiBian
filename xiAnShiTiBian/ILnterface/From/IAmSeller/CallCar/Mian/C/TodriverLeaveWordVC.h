//
//  TodriverLeaveWordVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LeaveMessageBlock)(NSString *str);
/**
 *给司机留言界面
 */
@interface TodriverLeaveWordVC : UIViewController
@property (nonatomic, copy) LeaveMessageBlock leaveMessageBlock;
@end
