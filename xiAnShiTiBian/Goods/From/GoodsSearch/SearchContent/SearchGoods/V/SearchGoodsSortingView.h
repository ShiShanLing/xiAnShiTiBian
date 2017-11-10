//
//  SearchGoodsSortingView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchGoodsSortingViewDelegate <NSObject>



@end

/**
 *搜索到的商品进行排序
 */
@interface SearchGoodsSortingView : UIView

/*!@brief 分别为:选中cell的text、cell的index、cell对应的Button。 */
@property (nonatomic) void (^handleSelectDataBlock) (NSString *selectTitle, NSUInteger selectIndex ,NSUInteger selectButtonTag);

/*!@brief 二维数组，存放每个Button对应下的TableView数据。。 */
@property (nonatomic) NSMutableArray *menuDataArray;

@property (nonatomic, assign)id<SearchGoodsSortingViewDelegate>delegate;

@end
