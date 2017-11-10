//
//  MapPopUpPaopaoView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/29.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapPopUpPaopaoView;
/**
 *弹出泡泡的 代理方法
 */
@protocol MapPopUpPaopaoViewDelegate <NSObject>
/**
 *导航去商店
 */
- (void)navigationTap:(MapPopUpPaopaoView *)view;
/**
 *进入商店
 */
- (void)enterstoreTap:(MapPopUpPaopaoView *)view;
@end
/**
 *地图上的 弹出泡泡
 */
@interface MapPopUpPaopaoView : UIView

@property (nonatomic, strong)NSString *storeID;
@property (nonatomic, assign)CLLocationCoordinate2D  storePosition;

@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *credibilityLabel;

@property (nonatomic, strong)id<MapPopUpPaopaoViewDelegate>delegate;

- (void)textView:(NSString *)str;
@end
