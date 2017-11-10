//
//  PublicTVOneCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *公用的cell  一个标题图片 一个标题label  一个内容label
 */
@interface PublicTVOneCell : UITableViewCell

@property (nonatomic, strong)UIButton *titleBtn;
@property (nonatomic, strong)UILabel *tItleLabel;
@property (nonatomic, strong)UILabel *contentLabel;
- (void)CellControlsAssignment:(NSIndexPath *)indexPath content:(NSString *)content;
@end
