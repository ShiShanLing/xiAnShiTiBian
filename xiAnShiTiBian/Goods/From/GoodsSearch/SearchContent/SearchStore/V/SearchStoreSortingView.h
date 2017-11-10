//
//  SearchStoreSortingView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/3.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchStoreSortingView : UIView
/*!@brief 分别为:选中cell的text、cell的index、cell对应的Button。 */
@property (nonatomic) void (^handleSelectDataBlock) (NSString *selectTitle, NSUInteger selectIndex ,NSUInteger selectButtonTag);

/*!@brief 二维数组，存放每个Button对应下的TableView数据。。 */
@property (nonatomic) NSMutableArray *menuDataArray;

@end
