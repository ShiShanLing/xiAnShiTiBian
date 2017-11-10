//
//  WithdrawValidationTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/8.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WithdrawValidationTVCellDelegate <NSObject>

- (void)handleGetVerificationCode:(JKCountDownButton *)sender;

@end

@interface WithdrawValidationTVCell : UITableViewCell
/**
 *手机号
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
/**
 *验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *VerificationCodeTF;
/**
 *倒计时
 */
@property (weak, nonatomic) IBOutlet JKCountDownButton *GetVerificationCodeBtn;
@property (nonatomic, weak)id<WithdrawValidationTVCellDelegate>delegate;
@end
