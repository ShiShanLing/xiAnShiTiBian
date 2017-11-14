//
//  UIImageView+Extension.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)
/**
 *给一个链接 和默认图片
 */
- (void)setImageViewAssignmentURL:(NSString *)url image:(UIImage *)image;
@end
