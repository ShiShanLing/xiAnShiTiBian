//
//  EditorMyFootprintTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/16.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FootprintModel;
/**
 *我的足迹编辑界面
 */
@interface EditorMyFootprintTVCell : UITableViewCell
- (void)cellSelected:(BOOL)state;

/**
 *
 */
@property (nonatomic, strong)FootprintModel *model;

@end
