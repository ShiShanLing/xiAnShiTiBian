//
//  MyDriverVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/10.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "BaseViewController.h"

/**
 *我的老司机界面
 */
@interface MyDriverVC : BaseViewController <BMKMapViewDelegate,BMKLocationServiceDelegate> {
 BMKMapView* _mapView;
 BMKLocationService* _locService;

}

@end
