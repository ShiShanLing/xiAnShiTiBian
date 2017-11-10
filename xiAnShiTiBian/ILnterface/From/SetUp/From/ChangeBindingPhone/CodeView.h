//
//  CodeView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CodeViewDelegate <NSObject>



@end

/**
 *获取验证码的view
 */
@interface CodeView : UIView

/**
 *验证码
 */
@property (nonatomic, strong)UITextField *CodeTF;

@end
