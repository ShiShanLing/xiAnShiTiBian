//
//  LogisticsOrderTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogisticsOrderTVCell : UITableViewCell

- (void)controlsAssignment:(int)row dataArray:(NSArray *)DataArray;

@property (nonatomic, strong)DriverCarOrderModel *model;

@end
