//
//  NoInternetTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/7/31.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *刷新界面按钮
 */
@protocol NoInternetTVCellDelegate <NSObject>

-(void)refreshView;

@end
/**
 *没有网络展示cell
 */
@interface NoInternetTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *RefreshViewBtn;

@property (nonatomic, weak)id<NoInternetTVCellDelegate>delegate;

@end
