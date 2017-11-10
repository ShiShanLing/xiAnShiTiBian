//
//  SetUpTitleTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *设置界面里面的标题
 */
@interface SetUpTitleTVCell : UITableViewCell

@property (nonatomic, strong)UIImageView *headImage;
@property (nonatomic, strong)UILabel *headLabel;

- (void)titleLabel:(NSString *)title headImage:(NSString *)image;

@end
