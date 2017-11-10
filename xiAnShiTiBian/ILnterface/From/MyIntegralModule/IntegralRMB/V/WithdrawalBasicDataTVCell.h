//
//  WithdrawalBasicDataTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/8.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawalBasicDataTVCell : UITableViewCell <UITextFieldDelegate>
/**
 *提现用户名字
 */
@property (weak, nonatomic) IBOutlet UITextField *NameTF;
/**
 *提现人身份证号
 */
@property (weak, nonatomic) IBOutlet UITextField *IdNumberTF;
/**
 *提现人银行卡号
 */
@property (weak, nonatomic) IBOutlet UITextField *BankCard;

@end
