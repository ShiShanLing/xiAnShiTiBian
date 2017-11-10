//
//  VendorEngineeringDrawingTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VendorEngineeringDrawingTVCellDelegate <NSObject>

-(void)MoreEngineering;

@end

/**
 *厂家工程图展示 也是由4个view拼接而成的Cell 
 */
@interface VendorEngineeringDrawingTVCell : UITableViewCell

@property (nonatomic, assign)id<VendorEngineeringDrawingTVCellDelegate>delegate;


@end
