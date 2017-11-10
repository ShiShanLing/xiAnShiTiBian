//
//  ThereNoInternetTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/3.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThereNoInternetTVCellDelegate <NSObject>

- (void)RefreshInterface;

@end

/**
 *网络断开
 */
@interface ThereNoInternetTVCell : UITableViewCell

@property (nonatomic, assign)id<ThereNoInternetTVCellDelegate>delegate;

@end
