//
//  DriverVehicleDataTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/14.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DriverVehicleDataTVCellDelegate <NSObject>

- (void)driverDataEditor:(int)index;

@end

/**
 *司机车辆信息展示模块
 */
@interface DriverVehicleDataTVCell : UITableViewCell

@property(nonatomic, assign)id<DriverVehicleDataTVCellDelegate>delegate;

- (void)ControlsAssignment:(NSString *)carName;

@end
