//
//  NextStepTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "NextStepTVCell.h"

@interface NextStepTVCell ()

@end

@implementation NextStepTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = MColor(238, 238, 238);
        UIButton *nextStepBtn = [UIButton new];
        nextStepBtn.userInteractionEnabled = NO;
        [nextStepBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
        [nextStepBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        nextStepBtn.backgroundColor = [UIColor whiteColor];
        nextStepBtn.layer.cornerRadius = 3;
        nextStepBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:nextStepBtn];
        nextStepBtn.sd_layout.widthIs(kFit(300)).heightIs(kFit(50)).centerXEqualToView(self.contentView).centerYEqualToView(self.contentView);
    }
    return self;
}

@end
