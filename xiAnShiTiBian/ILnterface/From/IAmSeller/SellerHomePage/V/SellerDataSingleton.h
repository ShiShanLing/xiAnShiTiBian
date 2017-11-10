//
//  SellerDataSingleton.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SellerDataModel;
@interface SellerDataSingleton : NSObject
/*
 这是第一步 创建单例方法 + 号方法 以(main  defaulf standard)开头 +类名
 */
+ (SellerDataSingleton *)mainSingleton;
@property (nonatomic, assign)SellerDataModel *sellerDataModel;

@end
