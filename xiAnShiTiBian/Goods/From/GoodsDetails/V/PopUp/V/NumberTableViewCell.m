//
//  NumberTableViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/14.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "NumberTableViewCell.h"
#import "ModifyNumberView.h"

@interface NumberTableViewCell() <ModifyNumberViewDelegate>



@end

@implementation NumberTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleLabel  =[UILabel new];
        titleLabel.text = @"数量 :";
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.textAlignment = 1;
        titleLabel.font = MFont(kFit(15));
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(50);
        
        self.ModifyNumberView = [[ModifyNumberView alloc] initWithFrame:CGRectMake(0, 0, 0, kFit(36))];
        _ModifyNumberView.delegate = self;
        [self.contentView addSubview:_ModifyNumberView];
        _ModifyNumberView.sd_layout.topSpaceToView(self.contentView, kFit(15)).rightSpaceToView(self.contentView, kFit(20)).widthIs(kFit(130)).heightIs(kFit(36));
    }
    return self;

}

@end
