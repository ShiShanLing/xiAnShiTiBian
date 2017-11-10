//
//  RegularExpressions.h
//  ProvideMall_App
//
//  Created by 石山岭 on 16/5/30.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *正则表达式
 */
@interface RegularExpressions : NSObject
//正则表达式
/**
 *判断手机号是否正确
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
