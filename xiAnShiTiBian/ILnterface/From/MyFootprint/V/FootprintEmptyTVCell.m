//
//  FootprintEmptyTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/16.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "FootprintEmptyTVCell.h"

@implementation FootprintEmptyTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews {

    self.stateBtn.layer.cornerRadius = 3;
    self.stateBtn.layer.masksToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)handleStateBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(handleStateBtn:)]) {
        [_delegate handleStateBtn:sender];
    }
}

@end
