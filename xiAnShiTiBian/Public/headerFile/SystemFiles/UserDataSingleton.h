//
//  UserDataSingleton.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/4.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataSingleton : NSObject

+ (UserDataSingleton *)mainSingleton;

@property (nonatomic, copy)NSArray *userArray;
@property (nonatomic, copy)NSString *userID;
@property (nonatomic, copy)NSString *AppKey;
@property (nonatomic, copy)NSString *storeID;

/**
 *0 没有网络 1手机网络 2wifi
 */
@property (nonatomic,assign)NSInteger *networkState;
@end
