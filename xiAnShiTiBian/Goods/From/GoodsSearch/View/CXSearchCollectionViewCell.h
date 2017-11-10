//
//  CXsearchCollectionViewCell.h
//  搜索页面的封装
//
//  Created by 石山岭 on 2016/12/1.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXSearchCollectionViewCell;

@protocol SelectCollectionCellDelegate <NSObject>
- (void)selectButttonClick:(CXSearchCollectionViewCell *)cell;
@end

@interface CXSearchCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *contentButton;

@property (weak, nonatomic) id<SelectCollectionCellDelegate> selectDelegate;
+ (CGSize) getSizeWithText:(NSString*)text;

@end
