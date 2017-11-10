//
//  NotLoggedInTableViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/7/28.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "NotLoggedInTableViewCell.h"

@implementation NotLoggedInTableViewCell

-(void)layoutSubviews {
    self.logInBrn.layer.cornerRadius = 3;
    self.logInBrn.layer.masksToBounds =YES;
    self.logInBrn.layer.borderWidth =1;
    self.logInBrn.layer.borderColor = MColor(134, 134, 134).CGColor;

}
- (IBAction)handleLogIn:(id)sender {
    if ([_delegate respondsToSelector:@selector(handleLogInBtn)]) {
        [_delegate handleLogInBtn];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
