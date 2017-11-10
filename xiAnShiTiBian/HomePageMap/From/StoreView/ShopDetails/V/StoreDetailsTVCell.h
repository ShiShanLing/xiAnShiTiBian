//
//  StoreDetailsTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/7.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *店铺详情cell
 */
@interface StoreDetailsTVCell : UITableViewCell
/**
 *标题名称
 */
@property (nonatomic, strong)UILabel *nameLabel;
/**
 *内容
 */
@property (nonatomic, strong)UILabel *contentLabel;

@property (nonatomic, copy) NSString *text;

@end
