//
//  PayWayTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/4.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *选择支付方式
 */
@interface PayWayTVCell : UITableViewCell

-(void)ChoosePayWay:(BOOL)state;

- (void)ControlsAssignment:(int)index;

@end
