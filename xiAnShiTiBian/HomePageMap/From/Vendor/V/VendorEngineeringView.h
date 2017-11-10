//
//  VendorEngineeringView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *厂家工程展示VIew
 */
@protocol VendorEngineeringViewDelegate <NSObject>

- (void)viewClick:(UIView *)tap;

@end


@interface VendorEngineeringView : UIView
@property (nonatomic, assign)id<VendorEngineeringViewDelegate>delegate;

@property (nonatomic, strong) UIImageView *goodsImage;
- (void)assignment:(NSString *)url;
@end
