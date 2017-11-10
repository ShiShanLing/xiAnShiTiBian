//
//  DataCollectionView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/30.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconView.h"

@protocol DataCollectionViewDelegate <NSObject>

- (void)OrderChoose:(int)index;

@end

@interface DataCollectionView : UIView

@property (nonatomic, assign)id<DataCollectionViewDelegate>Delegate;

@end
