//
//  WithdrawalAmountTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/8.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawalAmountTVCell : UITableViewCell
/**
 *提现金额
 */
@property (nonatomic, strong)UITextField *RMBNumberTF;
/**
 *全部提现
 */
@property (nonatomic, strong)UIButton *AllTakeBtn;
/**
 *积分展示view
 */
@property (nonatomic, strong)UILabel *ExistingLntegral;
@end
