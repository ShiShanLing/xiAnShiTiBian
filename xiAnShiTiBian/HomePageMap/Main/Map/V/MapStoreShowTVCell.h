//
//  MapStoreShowTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/15.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapStoreShowTVCellDelegate <NSObject>

- (void)handleSelectBtn:(UIButton *)sender;
- (void)handleMapNavigationCC:(CLLocationCoordinate2D)CC;
@end

@interface MapStoreShowTVCell : UITableViewCell
/**
 *
 */
@property (nonatomic, strong)MapSearchStoreModel *model;

@property (nonatomic, weak)id<MapStoreShowTVCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *EnterBtn;



@end
