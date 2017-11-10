//
//  UserDataModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "UserDataModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserDataModel (CoreDataProperties)

+ (NSFetchRequest<UserDataModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *appKey;
@property (nullable, nonatomic, copy) NSString *memberAvatar;
@property (nullable, nonatomic, copy) NSString *memberConsumePoints;
@property (nullable, nonatomic, copy) NSString *memberId;
@property (nullable, nonatomic, copy) NSString *memberMobile;
@property (nullable, nonatomic, copy) NSString *memberName;
@property (nullable, nonatomic, copy) NSString *memberRankPoints;
@property (nullable, nonatomic, copy) NSString *memberSex;
@property (nullable, nonatomic, copy) NSString *memberTruename;
@property (nullable, nonatomic, copy) NSString *memberType;
@property (nonatomic) int32_t noPayOrder;
@property (nonatomic) int32_t noReceiveOrder;
@property (nonatomic) int16_t applyState;
- (void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
