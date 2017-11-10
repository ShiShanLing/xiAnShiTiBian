
//
//  DriverCertificationStatusTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/14.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverCertificationStatusTVCell.h"

@implementation DriverCertificationStatusTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *TopView = [UIView new];//标题
        TopView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:TopView];
        TopView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(47));
        {
            UILabel *titleLabel = [UILabel new];
            titleLabel.text = @"司机认证";
            titleLabel.textColor = MColor(51, 51, 51);
            titleLabel.font = MFont(kFit(15));
            [TopView addSubview:titleLabel];
            titleLabel.sd_layout.leftSpaceToView(TopView, kFit(12)).widthIs(kFit(100)).centerYEqualToView(TopView).heightIs(kFit(15));
            UILabel *bottomLabel = [UILabel new];
            bottomLabel.backgroundColor = MColor(238, 238, 238);
            [TopView addSubview:bottomLabel];
            bottomLabel.sd_layout.leftSpaceToView(TopView, kFit(0)).bottomSpaceToView(TopView, 0).rightSpaceToView(TopView, kFit(0)).heightIs(kFit(0.5));
        }
        UIView *middleView = [UIView new]; //司机是否认证
        middleView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:middleView];
        middleView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(TopView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(47));
        UITapGestureRecognizer *middleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMiddleTap:)];
        [middleView addGestureRecognizer:middleTap];
        {
            
            UIButton *iconBtn = [UIButton new];
            iconBtn.userInteractionEnabled = NO;
            UIImage *image = [UIImage imageNamed:@"wd-wssj-grxx-sjrz"];
            image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
            [iconBtn setImage:image forState:(UIControlStateNormal)];
            [middleView addSubview:iconBtn];
            iconBtn.sd_layout.leftSpaceToView(middleView, kFit(2)).topSpaceToView(middleView, 0).bottomSpaceToView(middleView, 0).widthIs(kFit(45));
            
            UILabel * titleLabel = [UILabel new];
            titleLabel.text = @"司机认证";
            titleLabel.textColor =MColor(51, 51, 51);
            titleLabel.font = MFont(kFit(12));
            [middleView addSubview:titleLabel];
            titleLabel.sd_layout.leftSpaceToView(iconBtn, kFit(0)).topSpaceToView(middleView, kFit(13)).widthIs(kFit(50)).heightIs(kFit(12));
            
            UIButton *attestationStateBtn = [UIButton new];
            [attestationStateBtn setTitle:@"已认证" forState:(UIControlStateNormal)];
            attestationStateBtn.titleLabel.font = MFont(kFit(8));
            [attestationStateBtn setTitleColor:MColor(60, 186, 153) forState:(UIControlStateNormal)];
            attestationStateBtn.layer.cornerRadius = kFit(6);
            attestationStateBtn.layer.masksToBounds = YES;
            attestationStateBtn.layer.borderWidth = 1;
            attestationStateBtn.layer.borderColor = MColor(60, 186, 153).CGColor;
            [middleView addSubview:attestationStateBtn];
            attestationStateBtn.sd_layout.leftSpaceToView(titleLabel, kFit(10)).topSpaceToView(middleView, kFit(13)).widthIs(kFit(50)).heightIs(kFit(12));
            
            UILabel *illustrateLabel = [UILabel new];
            illustrateLabel.textColor = MColor(161, 161, 161);
            illustrateLabel.text = @"驾驶证,行驶证需要进行平台认证";
            illustrateLabel.font = MFont(kFit(10));
            [middleView addSubview:illustrateLabel];
            illustrateLabel.sd_layout.leftSpaceToView(iconBtn, 0).topSpaceToView(attestationStateBtn, kFit(5)).widthIs(kFit(200)).heightIs(kFit(10));
            
            UIButton *editorBtn = [UIButton new];
            editorBtn.userInteractionEnabled = NO;
            UIImage *editorImage = [UIImage imageNamed:@"qbddjt"];
            editorImage = [editorImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
            [editorBtn setImage:editorImage forState:(UIControlStateNormal)];
            [middleView addSubview:editorBtn];
            editorBtn.sd_layout.rightSpaceToView(middleView, kFit(0)).topSpaceToView(middleView, 0).bottomSpaceToView(middleView, 0).widthIs(kFit(32));

            
            UILabel *bottomLabel = [UILabel new];
            bottomLabel.backgroundColor = MColor(238, 238, 238);
            [middleView addSubview:bottomLabel];
            bottomLabel.sd_layout.leftSpaceToView(middleView, kFit(0)).bottomSpaceToView(middleView, 0).rightSpaceToView(middleView, kFit(0)).heightIs(kFit(0.5));
            
        }
        UIView *bottomView = [UIView new]; //司机是否认证
        bottomView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottomView];
        bottomView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(middleView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(47));
        UITapGestureRecognizer *bottomTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBottomTap:)];
        [bottomView addGestureRecognizer:bottomTap];
        {
            UIButton *iconBtn = [UIButton new];
            iconBtn.userInteractionEnabled = NO;
            UIImage *image = [UIImage imageNamed:@"wd-wssj-grxx-smrz"];
            image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
            [iconBtn setImage:image forState:(UIControlStateNormal)];
            [bottomView addSubview:iconBtn];
            iconBtn.sd_layout.leftSpaceToView(bottomView, kFit(2)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).widthIs(kFit(45));
            
            UILabel * titleLabel = [UILabel new];
            titleLabel.text = @"司机认证";
            titleLabel.textColor =MColor(51, 51, 51);
            titleLabel.font = MFont(kFit(12));
            [bottomView addSubview:titleLabel];
            titleLabel.sd_layout.leftSpaceToView(iconBtn, kFit(0)).topSpaceToView(bottomView, kFit(13)).widthIs(kFit(50)).heightIs(kFit(12));
            
            UIButton *attestationStateBtn = [UIButton new];
            [attestationStateBtn setTitle:@"已认证" forState:(UIControlStateNormal)];
            [attestationStateBtn setTitleColor:MColor(60, 186, 153) forState:(UIControlStateNormal)];
            attestationStateBtn.layer.cornerRadius = kFit(6);
            attestationStateBtn.layer.masksToBounds = YES;
            attestationStateBtn.layer.borderWidth = 1;
            attestationStateBtn.titleLabel.font = MFont(kFit(8));
            attestationStateBtn.layer.borderColor = MColor(60, 186, 153).CGColor;
            [bottomView addSubview:attestationStateBtn];
            attestationStateBtn.sd_layout.leftSpaceToView(titleLabel, kFit(10)).topSpaceToView(bottomView, kFit(13)).widthIs(kFit(50)).heightIs(kFit(12));
            
            UILabel *illustrateLabel = [UILabel new];
            illustrateLabel.textColor = MColor(161, 161, 161);
            illustrateLabel.text = @"驾驶证,行驶证需要进行平台认证";
            illustrateLabel.font = MFont(kFit(10));
            [bottomView addSubview:illustrateLabel];
            illustrateLabel.sd_layout.leftSpaceToView(iconBtn, 0).topSpaceToView(attestationStateBtn, kFit(5)).widthIs(kFit(200)).heightIs(kFit(10));
            
            UIButton *editorBtn = [UIButton new];
            editorBtn.userInteractionEnabled = NO;
            UIImage *editorImage = [UIImage imageNamed:@"qbddjt"];
            editorImage = [editorImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
            [editorBtn setImage:editorImage forState:(UIControlStateNormal)];
            [bottomView addSubview:editorBtn];
            editorBtn.sd_layout.rightSpaceToView(bottomView, kFit(0)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).widthIs(kFit(32));
            
            UILabel *bottomLabel = [UILabel new];
            bottomLabel.backgroundColor = MColor(238, 238, 238);
            [bottomView addSubview:bottomLabel];
            bottomLabel.sd_layout.leftSpaceToView(bottomView, kFit(0)).bottomSpaceToView(bottomView, 0).rightSpaceToView(bottomView, kFit(0)).heightIs(kFit(0.5));
        }
    }
    return self;
}

- (void)handleMiddleTap:(UITapGestureRecognizer *)sender {
    
    if ([_delegate respondsToSelector:@selector(driverDataEditor:)]) {
        [_delegate driverDataEditor:3];
    }
    
}

- (void)handleBottomTap:(UITapGestureRecognizer *)sender {
    if ([_delegate respondsToSelector:@selector(driverDataEditor:)]) {
        [_delegate driverDataEditor:4];
    }
}

@end
