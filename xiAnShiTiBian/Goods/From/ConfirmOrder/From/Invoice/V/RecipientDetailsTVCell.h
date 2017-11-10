//
//  RecipientDetailsTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/19.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecipientDetailsTVCellDelegate <NSObject>
/**
 *点击切换 个人cell
 */
- (void)RecipientDetails:(int)index;
/**
 *
 */
- (void)transmissionCompanyName:(NSString *)name;

@end

/**
 *接收发票人的信息(企业)
 */
@interface RecipientDetailsTVCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong)UITextField *TF;
@property (nonatomic, assign)id<RecipientDetailsTVCellDelegate>delegate;

@end
