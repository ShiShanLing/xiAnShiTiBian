//
//  CityItem.m
//  ChinaCityList
//
//  Created by zjq on 15/10/27.
//  Copyright © 2015年 zhengjq. All rights reserved.
//

#import "CityItem.h"

@implementation CityItem

- (instancetype)initWithTitleName:(NSDictionary *)titleName {
    if (self = [super init]) {       
        self.titleName = titleName[@"provinceName"];
        self.longitude =titleName[@"longitude"];
        self.latitude = titleName[@"latitude"];
    }
    return self;
}

+ (instancetype)initWithTitleName:(NSDictionary *)titleName {
    
    return [[self alloc] initWithTitleName:titleName];
}



@end
