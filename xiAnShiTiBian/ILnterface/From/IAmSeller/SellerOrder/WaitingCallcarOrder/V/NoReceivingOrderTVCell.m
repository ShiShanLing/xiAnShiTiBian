//
//  NoReceivingOrderTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "NoReceivingOrderTVCell.h"

@implementation NoReceivingOrderTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = MColor(238, 238, 238);
        UILabel *middlelabel = [UILabel new];
        [self.contentView addSubview:middlelabel];
        middlelabel.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(0.5);
        
        UIButton *iconBtn = [UIButton new];
        iconBtn.userInteractionEnabled = NO;
        UIImage *image = [UIImage imageNamed:@"wd-wssj-dfh-jcxq"];
        image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [iconBtn setImage:image forState:(UIControlStateNormal)];
        [self.contentView addSubview:iconBtn];
        iconBtn.sd_layout.bottomSpaceToView(middlelabel, kFit(-15)).centerXEqualToView(self.contentView).widthIs(kFit(71)).heightIs(kFit(71));
        
        UILabel *promptLabel = [UILabel new];
        promptLabel.text = @"司机尚未接单,请耐心等待...";
        promptLabel.textColor = MColor(51, 51, 51);
        promptLabel.textAlignment = 1;
        promptLabel.font = MFont(kFit(16));
        [self.contentView addSubview:promptLabel];
        promptLabel.sd_layout.topSpaceToView(middlelabel, kFit(30)).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(16));
        
    }
    return self;
}
@end
