//
//  MyEvaluationTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/16.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MyEvaluationTVCell.h"

@interface MyEvaluationTVCell ()

/**
 *用户头像
 */
@property (nonatomic, strong)UIImageView *userImage;
/**
 *用户等级
 */
@property (nonatomic, strong)UIImageView *userLevelImage;
/**
 *用户昵称
 */
@property (nonatomic, strong)UILabel *userName;
/**
 *评论过几次
 */
@property (nonatomic, strong)UILabel *commentsNumLabel;
/**
 *被点赞过几次
 */
@property (nonatomic, strong)UILabel *BePraisedLabel;
@end

@implementation MyEvaluationTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.userImage = [UIImageView new];
        _userImage.image = [UIImage imageNamed:@"zly"];
        _userImage.layer.cornerRadius = kFit(15);
        _userImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_userImage];
        _userImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(25)).widthIs(kFit(30)).heightIs(kFit(30));
        
        self.userName = [UILabel new];
        _userName.text = @"石山岭";
        _userName.textColor = MColor(51, 51, 51);
        _userName.font = MFont(kFit(14));
        [self.contentView addSubview:_userName];
        _userName.sd_layout.leftSpaceToView(_userImage, kFit(10)).topEqualToView(_userImage).widthIs(kFit(100)).heightIs(kFit(14));
        
        self.userLevelImage = [UIImageView new];
        _userLevelImage.image = [UIImage imageNamed:@"vip"];
        [self.contentView addSubview:_userLevelImage];
        _userLevelImage.sd_layout.leftEqualToView(_userName).topSpaceToView(_userName, kFit(3)).widthIs(kFit(15)).heightIs(kFit(15));
        
        self.commentsNumLabel = [UILabel new];
        _commentsNumLabel.text = @"30";
        _commentsNumLabel.font = MFont(kFit(15));
        _commentsNumLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_commentsNumLabel];
        _commentsNumLabel.sd_layout.leftEqualToView(_userName).topSpaceToView(_userLevelImage, kFit(20)).widthIs(kFit(100)).heightIs(kFit(15));
        
        UILabel *commentsLable = [UILabel new];
        commentsLable.text = @"发布的评价";
        commentsLable.textColor = MColor(161, 161, 161);
        commentsLable.font = MFont(kFit(8));
        [self.contentView addSubview:commentsLable];
        commentsLable.sd_layout.leftEqualToView(_userName).topSpaceToView(self.commentsNumLabel, kFit(7)).widthIs(kFit(40)).heightIs(kFit(8));
        
        UILabel *BeLablel = [UILabel new];
        BeLablel.text = @"被点赞";
        BeLablel.textColor = MColor(161, 161, 161);
        BeLablel.font = MFont(kFit(8));
        [self.contentView addSubview:BeLablel];
        BeLablel.sd_layout.leftSpaceToView(commentsLable, kFit(75)).widthIs(kFit(100)).heightIs(kFit(8)).topEqualToView(commentsLable);
        
        self.BePraisedLabel = [UILabel new];
        _BePraisedLabel.textColor = MColor(51, 51, 51);
        _BePraisedLabel.text = @"31";
        _BePraisedLabel.font = MFont(kFit(15));
        [self.contentView addSubview:_BePraisedLabel];
        _BePraisedLabel.sd_layout.leftEqualToView(BeLablel).bottomSpaceToView(BeLablel, kFit(7)).widthIs(kFit(100)).heightIs(kFit(15));
        
        UILabel *dividerLabelOne = [UILabel new];
        dividerLabelOne.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:dividerLabelOne];
        dividerLabelOne.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(commentsLable, kFit(25)).rightSpaceToView(self.contentView, 0).heightIs(0.5);
        
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottomView];
        bottomView.sd_layout.leftSpaceToView(self.contentView , 0).topSpaceToView(dividerLabelOne, 0).rightSpaceToView(self.contentView, 0).heightIs(37);
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.text = @"全部评价";
        titleLabel.font = MFont(kFit(12));
        [bottomView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(bottomView, kFit(12)).centerYEqualToView(bottomView).widthIs(kFit(200)).heightIs(kFit(12));
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [bottomView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, kFit(0)).rightSpaceToView(bottomView, 0).heightIs(0.5);
        
    }
    return self;
}
@end
