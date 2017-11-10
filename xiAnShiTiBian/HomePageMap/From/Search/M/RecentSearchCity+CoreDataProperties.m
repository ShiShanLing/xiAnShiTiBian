//
//  RecentSearchCity+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/10/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//
//

#import "RecentSearchCity+CoreDataProperties.h"

@implementation RecentSearchCity (CoreDataProperties)

+ (NSFetchRequest<RecentSearchCity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RecentSearchCity"];
}

@dynamic latitude;
@dynamic longitude;
@dynamic provinceName;

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"latitude"]) {
        self.latitude = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"longitude"]) {
        self.longitude = [NSString stringWithFormat:@"%@", value];
    }else {
        [super setValue:value forKey:key];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
    
}

@end
