
//
//  CommentsTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/10.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "CommentsTVCell.h"

@implementation CommentsTVCell
/**
 *用户头像
 */
//@property (nonatomic, strong)UIImageView *userImage;
/**
 *用户昵称
 */
//@property (nonatomic, strong)UILabel *userName;
/**
 *用户等级
 */
//@property (nonatomic, strong)UIImageView *userLevel;
/**
 *评论星级
 */
//@property (nonatomic, strong)UIView *GoodsstarLevel;
/**
 *评论内容
 */
//@property (nonatomic, strong)UILabel *GoodsCommentsContent;
/**
 *评论时间
 */
//@property (nonatomic, strong)UILabel *GoodsCommentsTime;
/**
 *商品颜色
 */
//@property (nonatomic, strong)UILabel *goodsColor;
/**
 *商品规格
 */
//@property (nonatomic, strong)UILabel *goodsType;
/**
 *购买时间
 */
//@property (nonatomic, strong)UILabel *GoodsbuyTime;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)   reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setCreatingControls];
    }
    return self;
}
- (void)setCreatingControls {
    
    self.userImage = [UIImageView new];
    _userImage.image = [UIImage imageNamed:@"zly"];
    _userImage.layer.cornerRadius = kFit(45)/2;
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = kFit(45)/2;
    _userImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_userImage];
    _userImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(20)).widthIs(kFit(45)).autoHeightRatio(1);
    
    self.userName = [UILabel new];
    _userName.textColor = MColor(51, 51, 51);
    _userName.text = @"赵**";
    _userName.font = MFont(kFit(12));
    [self.contentView addSubview:self.userName];
    CGFloat widht =  [self getWidthWithTitle:@"李***" font:MFont(kFit(12))];
    _userName.sd_layout.leftSpaceToView(self.userImage, kFit(10)).topSpaceToView(self.contentView, kFit(36)).widthIs(widht).heightIs(kFit(12));
    
    self.userLevel = [UIImageView new];
    _userLevel.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:self.userLevel];
    _userLevel.sd_layout.leftSpaceToView(_userName, kFit(8)).topSpaceToView(self.contentView, kFit(30)).widthIs(kFit(16)).autoHeightRatio(1);
    
    self.GoodsCommentsTime = [UILabel new];
    _GoodsCommentsTime.text = @"2016-12-23";
    _GoodsCommentsTime.font = MFont(kFit(12));
    _GoodsCommentsTime.textAlignment = 2;
    _GoodsCommentsTime.textColor = MColor(161, 161, 161);
    [self.contentView addSubview:_GoodsCommentsTime];
    _GoodsCommentsTime.sd_layout.rightSpaceToView(self.contentView, kFit(15)).topEqualToView(_userName).widthIs(kFit(100)).heightIs(kFit(12));
    
    
    self.start = [[FBCScoreStar alloc] initWithFrame:CGRectMake(10, 65, 70, 14)];
    _start.startColor = [UIColor orangeColor];
    _start.score = 5;
    [self.contentView addSubview:_start];
    _start.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(_GoodsCommentsTime, kFit(14)).widthIs(100).heightIs(kFit(14));
    
    self.GoodsCommentsContent = [UILabel new];
    _GoodsCommentsContent.text = @"真心不错,商家服务很好,快递也很给力!给满星";
    _GoodsCommentsContent.font = MFont(kFit(14));
    _GoodsCommentsContent.textColor = MColor(51, 51, 51);
    [self.contentView addSubview:_GoodsCommentsContent];
    _GoodsCommentsContent.sd_layout.topSpaceToView(self.start, kFit(15)).leftSpaceToView(self.contentView, kFit(15)).rightSpaceToView(self.contentView, kFit(15)).autoHeightRatio(0);
    
    self.goodsColor = [UILabel new];
    _goodsColor.text = @"颜色 :白色";
    _goodsColor.font = MFont(kFit(12));
    _goodsColor.textColor = MColor(161, 161, 161);
    [self.contentView addSubview:_goodsColor];
    _goodsColor.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(_GoodsCommentsContent, kFit(25)).heightIs(12).widthIs(kScreen_widht);
    
    self.goodsType = [UILabel new];
    _goodsType.text = @"规格 :XXL";
    _goodsType.font = MFont(kFit(12));
    _goodsType.textColor = MColor(161, 161, 161);
    [self.contentView addSubview:self.goodsType];
    _goodsType.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.goodsColor,kFit(10)).heightIs(kFit(12)).widthIs(kScreen_widht);
    
    UILabel *segmentationLabel = [[UILabel alloc] init];
    segmentationLabel.backgroundColor = MColor(210, 210, 210);
    [self.contentView addSubview:segmentationLabel];
    segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(0.5).topSpaceToView(_goodsType, kFit(24.5));
    
    [self setupAutoHeightWithBottomView:segmentationLabel bottomMargin:kFit(0)];

}
- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}



@end
