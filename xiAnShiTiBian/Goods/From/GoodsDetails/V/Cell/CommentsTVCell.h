//
//  CommentsTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/10.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *评论模块cell
 */
@interface CommentsTVCell : UITableViewCell
/**
 *用户头像
 */
@property (nonatomic, strong)UIImageView *userImage;
/**
 *用户昵称  赋值时需要自使用宽度
 */
@property (nonatomic, strong)UILabel *userName;
/**
 *用户等级
 */
@property (nonatomic, strong)UIImageView *userLevel;
/**
 *评论星级
 */
@property (nonatomic, strong)UIView *GoodsstarLevel;
/**
 *评论内容
 */
@property (nonatomic, strong)UILabel *GoodsCommentsContent;//自适应高度
/**
 *评论时间
 */
@property (nonatomic, strong)UILabel *GoodsCommentsTime;
/**
 *商品颜色
 */
@property (nonatomic, strong)UILabel *goodsColor;
/**
 *商品规格
 */
@property (nonatomic, strong)UILabel *goodsType;
/**
 *购买时间
 */
@property (nonatomic, strong)UILabel *GoodsbuyTime;

@property (nonatomic, strong)FBCScoreStar *start;

@end
