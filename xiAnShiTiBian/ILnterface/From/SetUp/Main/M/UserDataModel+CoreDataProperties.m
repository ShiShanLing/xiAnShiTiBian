//
//  UserDataModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "UserDataModel+CoreDataProperties.h"

@implementation UserDataModel (CoreDataProperties)

+ (NSFetchRequest<UserDataModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserDataModel"];
}

@dynamic appKey;
@dynamic memberAvatar;
@dynamic memberConsumePoints;
@dynamic memberId;
@dynamic memberMobile;
@dynamic memberName;
@dynamic memberRankPoints;
@dynamic memberSex;
@dynamic memberTruename;
@dynamic memberType;
@dynamic noPayOrder;
@dynamic noReceiveOrder;
@dynamic applyState;
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"memberSex"]) {
        self.memberSex = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"memberRankPoints"]) {
        self.memberRankPoints = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"memberConsumePoints"]) {
        self.memberConsumePoints = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"memberSex"]) {
        self.memberSex = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"memberName"]) {
        self.memberName = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"memberMobile"]) {
        self.memberMobile = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"memberAvatar"]) {
        self.memberAvatar = [NSString stringWithFormat:@"%@", value];
    } else{
        [super setValue:value forKey:key];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

@end
