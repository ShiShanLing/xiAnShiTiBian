//
//  WithdrawalAmountTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/8.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "WithdrawalAmountTVCell.h"

@interface WithdrawalAmountTVCell ()


@end

@implementation WithdrawalAmountTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bottomViewOne = [UIView new];
        bottomViewOne.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottomViewOne];
        bottomViewOne.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(137));
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"提现金额";
        titleLabel.textColor = MColor(134, 134, 134);
        titleLabel.font = MFont(kFit(15));
        [bottomViewOne addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(bottomViewOne, kFit(15)).topSpaceToView(bottomViewOne, kFit(17)).widthIs(100).heightIs(kFit(15));
        
        UIImageView *RMBImage = [UIImageView new];
        RMBImage.image = [UIImage imageNamed:@"g720"];
        [bottomViewOne addSubview:RMBImage];
        RMBImage.sd_layout.leftSpaceToView(bottomViewOne, kFit(15)).topSpaceToView(titleLabel, kFit(17)).widthIs(kFit(18)).heightIs(kFit(25));
        
        self.RMBNumberTF = [UITextField new];
        
        NSString * holderText= @"请输入金额(积分) 必须是100的倍数";
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
        [placeholder addAttribute:NSFontAttributeName
                            value:[UIFont boldSystemFontOfSize:14]
                            range:NSMakeRange(0, holderText.length)];
        _RMBNumberTF.attributedPlaceholder = placeholder;
        _RMBNumberTF.borderStyle = UITextBorderStyleNone;
        _RMBNumberTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [bottomViewOne addSubview:_RMBNumberTF];
        _RMBNumberTF.sd_layout.leftSpaceToView(RMBImage, kFit(15)).topEqualToView(RMBImage).rightSpaceToView(bottomViewOne, kFit(30)).heightIs(kFit(25));
        
        UILabel *dividerLabel = [UILabel new];
        dividerLabel.backgroundColor = MColor(210, 210, 210);
        [bottomViewOne addSubview:dividerLabel];
        dividerLabel.sd_layout.leftSpaceToView(bottomViewOne, kFit(12)).rightSpaceToView(bottomViewOne, kFit(12)).topSpaceToView(_RMBNumberTF, kFit(17)).heightIs(0.5);
        
        self.AllTakeBtn = [UIButton new];
        [_AllTakeBtn setTitle:@"全部提现" forState:(UIControlStateNormal)];
        [_AllTakeBtn setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
        _AllTakeBtn.titleLabel.font = MFont(kFit(14));
        [bottomViewOne addSubview:_AllTakeBtn];
        _AllTakeBtn.sd_layout.rightSpaceToView(bottomViewOne, 0).topSpaceToView(dividerLabel, 0).widthIs(kFit(70)).bottomSpaceToView(bottomViewOne, 0);
        
        self.ExistingLntegral = [UILabel new];
        _ExistingLntegral.text = @"现有积分:600000 (可提现￥6000)";
        _ExistingLntegral.textColor = MColor(161, 161, 161);
        _ExistingLntegral.font = MFont(kFit(14));
        [bottomViewOne addSubview:_ExistingLntegral];
        _ExistingLntegral.sd_layout.leftSpaceToView(bottomViewOne, kFit(15)).topSpaceToView(dividerLabel, kFit(15)).rightSpaceToView(_AllTakeBtn, kFit(15)).heightIs(kFit(14));
        
    }
    return self;
}
@end
