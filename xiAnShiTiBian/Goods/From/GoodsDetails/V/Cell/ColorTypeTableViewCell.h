//
//  ColorTypeTableViewCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/10.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *颜色 规格选择cell
 */
@interface ColorTypeTableViewCell : UITableViewCell
//颜色
@property (nonatomic, strong)UILabel *colorLabel;
//规格
@property (nonatomic, strong)UILabel *typeLabel;

@end
