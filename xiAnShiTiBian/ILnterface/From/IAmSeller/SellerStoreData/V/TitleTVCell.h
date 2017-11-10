//
//  TitleTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TitleTVCellDelegate <NSObject>

- (void)PictureEditing;

@end
/**
 *商店信息界面的标题
 */
@interface TitleTVCell : UITableViewCell

@property (nonatomic, assign)id<TitleTVCellDelegate>delegate;

@property (nonatomic, strong)SellerDataModel *model;

@end
