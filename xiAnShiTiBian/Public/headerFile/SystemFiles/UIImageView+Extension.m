//
//  UIImageView+Extension.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)
- (void)setImageViewAssignmentURL:(NSString *)url image:(UIImage *)image{
    
    
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:image];
    
}
@end
