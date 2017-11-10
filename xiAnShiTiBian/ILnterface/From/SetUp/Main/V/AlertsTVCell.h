//
//  AlertsTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *设置界面 消息开关cell
 */
@interface AlertsTVCell : UITableViewCell

- (void)subscript:(int)index judge:(BOOL)judge;

@end
