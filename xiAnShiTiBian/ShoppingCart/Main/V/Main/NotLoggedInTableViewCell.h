//
//  NotLoggedInTableViewCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/7/28.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotLoggedInTableViewCellDelegate <NSObject>

-(void)handleLogInBtn;

@end

/**
 *用户没有登录cell
 */
@interface NotLoggedInTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *logInBrn;

@property (nonatomic, weak)id<NotLoggedInTableViewCellDelegate>delegate;

@end
