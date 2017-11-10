//
//  DriverCertificationStatusTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/14.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DriverCertificationStatusTVCellDelegate  <NSObject>

- (void)driverDataEditor:(int)index;

@end
/**
 *司机认证信息展示
 */
@interface DriverCertificationStatusTVCell : UITableViewCell

@property (nonatomic, assign)id<DriverCertificationStatusTVCellDelegate>delegate;

@end
