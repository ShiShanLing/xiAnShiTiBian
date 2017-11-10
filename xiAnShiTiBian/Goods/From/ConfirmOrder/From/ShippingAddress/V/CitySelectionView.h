//
//  CitySelectionView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/19.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitySelectionViewDelegate <NSObject>

- (void)CitySelectionConfirmOrCancel:(UIButton *)sender cityName:(NSString *)cityName regionName:(NSString *)regionName;

@end

@interface CitySelectionView : UIView
@property (nonatomic, assign)id<CitySelectionViewDelegate>delegate;

@end
