//
//  ServiceTableViewCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/10.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SericeView.h"
/**
 *商品提供服务的说明
 */
@interface ServiceTableViewCell : UITableViewCell

@property (nonatomic, strong)SericeView *sericeViewOne;
@property (nonatomic, strong)SericeView *sericeViewTwo;
@property (nonatomic, strong)SericeView *sericeViewThree;

@end
