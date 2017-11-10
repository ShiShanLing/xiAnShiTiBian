//
//  UnfoldOrderTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *展开物流订单cell
 */
@interface UnfoldOrderTVCell : UITableViewCell

// 显示订单是否完成的 label 和btn
@property (nonatomic, strong)UILabel *stateLabel;

@property (nonatomic, strong)UIButton *stateBtn;
//改变展开和折叠的按钮状态
- (void)ChangeState:(int)state;

@end
