//
//  FootprintModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/8/2.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "FootprintModel+CoreDataProperties.h"

@implementation FootprintModel (CoreDataProperties)

+ (NSFetchRequest<FootprintModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FootprintModel"];
}

@dynamic create_time_str;
@dynamic goodsList;

-(void)setValue:(id)value forKey:(NSString *)key {

    [super setValue:value forKey:key];

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {


}
@end
