//
//  ClassificationView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/6.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ClassificationViewDelegate <NSObject>

-(void)btn_classification:(UIButton*)btn;

@end
/**
 *店铺内商品分类
 */
@interface ClassificationView : UIView

@property (nonatomic, assign)id<ClassificationViewDelegate>delegate;

@end
