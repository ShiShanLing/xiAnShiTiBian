//
//  VendorAllGoodsCVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/27.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VendorAllGoodsCVCell : UICollectionViewCell


- (void)assignment:(NSString *)url;
@property (nonatomic, strong)GoodsDetailsModel *model;

@end