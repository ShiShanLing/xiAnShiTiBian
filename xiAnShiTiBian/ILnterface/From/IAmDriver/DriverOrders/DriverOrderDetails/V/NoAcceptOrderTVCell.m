
//
//  NoAcceptOrderTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "NoAcceptOrderTVCell.h"

@implementation NoAcceptOrderTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton *AcceptOrderBtn = [UIButton new];
        [AcceptOrderBtn setTitle:@"我要接单" forState:(UIControlStateNormal)];
        AcceptOrderBtn.userInteractionEnabled = NO;
        [AcceptOrderBtn setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
        AcceptOrderBtn.layer.cornerRadius = 3;
        AcceptOrderBtn.layer.masksToBounds =YES;
        AcceptOrderBtn.layer.borderWidth = 1;
        AcceptOrderBtn.layer.borderColor = kNavigation_Color.CGColor;
        AcceptOrderBtn.titleLabel.font = MFont(kFit(14));
        [AcceptOrderBtn addTarget:self action:@selector(handleAcceptOrderBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:AcceptOrderBtn];
        AcceptOrderBtn.sd_layout.centerXEqualToView(self.contentView).centerYEqualToView (self.contentView).widthIs(kFit(113)).heightIs(kFit(28));
    }
    return self;
}
- (void)handleAcceptOrderBtn {


}

@end
