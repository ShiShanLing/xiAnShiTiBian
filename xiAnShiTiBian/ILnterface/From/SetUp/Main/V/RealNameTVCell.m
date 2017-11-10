//
//  RealNameTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/9.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "RealNameTVCell.h"

@implementation RealNameTVCell

-(void)layoutSubviews {

    self.realNameStateLabel.layer.cornerRadius = 6;
    self.realNameStateLabel.layer.masksToBounds = YES;
    self.realNameStateLabel.layer.borderWidth = 1;
    

}

@end
