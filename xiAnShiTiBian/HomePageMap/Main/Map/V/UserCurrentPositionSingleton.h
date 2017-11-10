//
//  UserCurrentPositionSingleton.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *存储用户当前选择位置的单例
 */
@interface UserCurrentPositionSingleton : NSObject

+ (UserCurrentPositionSingleton *)mainSingleton;

@property (nonatomic, assign)CLLocationCoordinate2D Position;
@property (nonatomic, copy)NSString *cityName;
@end
