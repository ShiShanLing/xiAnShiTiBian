//
//  IconView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IconView;

@protocol IconViewDelegate <NSObject>

- (void)FunctionChoose:(IconView *)view;

@end


@interface IconView : UIView

@property (nonatomic, strong)UIImageView *iconImage;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, assign)id<IconViewDelegate>delegate;

@end
