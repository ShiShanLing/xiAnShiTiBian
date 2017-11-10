//
//  MessageCViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/7.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "MessageCViewCell.h"

@implementation MessageCViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.showImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        self.showImage.layer.cornerRadius = 3;
        self.showImage.layer.masksToBounds = YES;
        self.showImage.image = [UIImage imageNamed:@"11.jpg"];
        [self.contentView addSubview:self.showImage];
    }
    return self;
}

@end
