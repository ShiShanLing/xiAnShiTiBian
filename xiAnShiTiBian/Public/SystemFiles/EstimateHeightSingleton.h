//
//  EstimateHeightSingleton.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/21.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <Foundation/Foundation.h>

//计算键盘高度的单利..因为发现在获取键盘高度的时候打开App第一次的获取比以后获取的高度都要地  73
@interface EstimateHeightSingleton : NSObject
/*
 这是第一步 创建单例方法 + 号方法 以(main  defaulf standard)开头 +类名
 */

+ (EstimateHeightSingleton *)mainSingleton;
//定义属性 供外界使用
@property (nonatomic, assign)NSInteger keyboardHeight;

@end
