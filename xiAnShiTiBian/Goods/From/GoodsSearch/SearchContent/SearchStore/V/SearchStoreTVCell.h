//
//  SearchStoreTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/3.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchStoreTVCellDelegate <NSObject>

- (void)entranceStore:(OrderBtn *)sender;

@end

@interface SearchStoreTVCell : UITableViewCell

@property (nonatomic, assign)id<SearchStoreTVCellDelegate>delegate;

@property (nonatomic, strong)SellerDataModel *model;

/**
 *给控件添加辨别身份的tag值
 */
- (void)ToControlGiveTag:(NSIndexPath *)indexPath;

@end
