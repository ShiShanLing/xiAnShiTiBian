//
//  SearchVendorTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/14.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchVendorTVCellDelegate <NSObject>
/**
 *进入厂家
 */
- (void)EnterVendor:(UIButton *)sender;
/**
 *导航到厂家
 */
- (void)navigationToShop:(UIButton *)sender;
@end
/**
 *搜索厂家展示界面
 */
@interface SearchVendorTVCell : UITableViewCell

@property (nonatomic, assign)id<SearchVendorTVCellDelegate>delegate;

@property (nonatomic, strong)FactoryDataModel *model;
/**
 *进入厂家按钮
 */
@property (nonatomic, strong)OrderBtn *entranceStoreBtn;

/**
 *导航到厂家按钮
 */
@property (nonatomic, strong)OrderBtn *navigationBtn;
@end
