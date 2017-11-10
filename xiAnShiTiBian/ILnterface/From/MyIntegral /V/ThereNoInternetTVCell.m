//
//  ThereNoInternetTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/3.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ThereNoInternetTVCell.h"

@implementation ThereNoInternetTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"wangluoduan"];
        [self.contentView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(self).widthIs(kFit(87.5)).heightIs(kFit(57)).topSpaceToView(self.contentView,kFit(135-43));
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"网络连接好像断了";
        titleLabel.textAlignment = 1;
        titleLabel.textColor = MColor(134, 134, 134);
        titleLabel.font = MFont(kFit(15));
        [self.contentView addSubview:titleLabel];
         titleLabel.sd_layout.centerXEqualToView(self).widthIs(kScreen_widht).heightIs(kFit(15)).topSpaceToView(imageView, kFit(25));
        UILabel *promptLabel = [UILabel new];
        promptLabel.text = @"请刷新或者检查网络设置";
        promptLabel.textAlignment = 1;
        promptLabel.textColor = MColor(161, 161, 161);
        promptLabel.font = MFont(kFit(12));
        [self.contentView addSubview:promptLabel];
        promptLabel.sd_layout.centerXEqualToView(self).widthIs(kScreen_widht).heightIs(kFit(12)).topSpaceToView(titleLabel, kFit(15));

        UIButton *refreshBtn = [UIButton new];
        refreshBtn.layer.cornerRadius = 3;
        refreshBtn.layer.masksToBounds = YES;
        refreshBtn.layer.borderWidth = 0.5;
        refreshBtn.layer.borderColor = [MColor(134, 134, 134) CGColor];
        [refreshBtn setTitle:@"重新刷新" forState:(UIControlStateNormal)];
        [refreshBtn setTitleColor:MColor(134, 134, 134) forState:(UIControlStateNormal)];
        refreshBtn.titleLabel.font = MFont(kFit(14));
        [refreshBtn addTarget:self action:@selector(handleRefreshBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:refreshBtn];
        refreshBtn.sd_layout.centerXEqualToView(self).widthIs(kFit(94)).heightIs(kFit(33)).topSpaceToView(promptLabel, kFit(15));
        
    }
    return self;
}
- (void)handleRefreshBtn {

    if ([_delegate respondsToSelector:@selector(RefreshInterface)]) {
        
        [_delegate RefreshInterface];
        
    }
}
@end
