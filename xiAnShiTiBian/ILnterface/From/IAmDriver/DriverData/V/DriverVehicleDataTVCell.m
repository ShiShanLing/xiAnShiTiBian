//
//  DriverVehicleDataTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/14.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverVehicleDataTVCell.h"

@interface DriverVehicleDataTVCell ()
/**
 *汽车类型
 */
@property (nonatomic, strong)UILabel *CarName;
/**
 *实名认证状态 Real-name authentication state
 */
@property (nonatomic, strong)UILabel *CarBrandNumber;

@end

@implementation DriverVehicleDataTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *TopView = [UIView new];//标题
        TopView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:TopView];
        TopView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(47));
        {
            UILabel *titleLabel = [UILabel new];
            titleLabel.text = @"车辆";
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
            UIImage *image = [UIImage imageNamed:@"SelectModels"];
            image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
            [iconBtn setImage:image forState:(UIControlStateNormal)];
            [middleView addSubview:iconBtn];
            iconBtn.sd_layout.leftSpaceToView(middleView, kFit(2)).topSpaceToView(middleView, 0).bottomSpaceToView(middleView, 0).widthIs(kFit(45));
            
            UILabel * titleLabel = [UILabel new];
            titleLabel.text = @"货车类型";
            titleLabel.textColor =MColor(51, 51, 51);
            titleLabel.font = MFont(kFit(12));
            [middleView addSubview:titleLabel];
            titleLabel.sd_layout.leftSpaceToView(iconBtn, kFit(0)).widthIs(kFit(50)).heightIs(kFit(12)).centerYEqualToView(middleView);
            
            UILabel *contentLabel = [UILabel new];
            contentLabel.textColor = MColor(51, 51, 51);
            contentLabel.text = @"国产ISO9001认证火箭头火车";
            contentLabel.font = MFont(kFit(12));
            self.CarName = contentLabel;
            [middleView addSubview:contentLabel];
            contentLabel.sd_layout.leftSpaceToView(titleLabel, kFit(10)).centerYEqualToView(middleView).widthIs(kFit(200)).heightIs(kFit(12));
            
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
            UIImage *image = [UIImage imageNamed:@"wd-wssj-grxx-cph"];
            image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
            [iconBtn setImage:image forState:(UIControlStateNormal)];
            [bottomView addSubview:iconBtn];
            iconBtn.sd_layout.leftSpaceToView(bottomView, kFit(2)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).widthIs(kFit(45));
            
            UILabel * titleLabel = [UILabel new];
            titleLabel.text = @"车牌号";
            titleLabel.textAlignment = 0;
            titleLabel.textColor =MColor(51, 51, 51);
            titleLabel.font = MFont(kFit(12));
            [bottomView addSubview:titleLabel];
            titleLabel.sd_layout.leftSpaceToView(iconBtn, kFit(0)).widthIs(kFit(50)).heightIs(kFit(12)).centerYEqualToView(bottomView);
            
            UILabel *contentLabel = [UILabel new];
            contentLabel.textColor = MColor(51, 51, 51);
            contentLabel.text = @"国产ISO9001认证火箭头火车";
            self.CarBrandNumber = contentLabel;
            contentLabel.font = MFont(kFit(12));
            [bottomView addSubview:contentLabel];
            contentLabel.sd_layout.leftSpaceToView(titleLabel, kFit(10)).centerYEqualToView(bottomView).rightSpaceToView(bottomView, kFit(70)).heightIs(kFit(12));
            
            UIButton *editorBtn = [UIButton new];
            editorBtn.userInteractionEnabled = NO;
            editorBtn.titleLabel.font = MFont(kFit(12));
            [editorBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
            [editorBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
            [bottomView addSubview:editorBtn];
            editorBtn.sd_layout.rightSpaceToView(bottomView, kFit(0)).topSpaceToView(bottomView, 0).bottomSpaceToView(bottomView, 0).widthIs(kFit(50));
            
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
        [_delegate driverDataEditor:1];
    }
}

- (void)handleBottomTap:(UITapGestureRecognizer *)sender {
    if ([_delegate respondsToSelector:@selector(driverDataEditor:)]) {
        [_delegate driverDataEditor:2 ];
    }
}
- (void)ControlsAssignment:(NSString *)carName {
    self.CarName.text = carName;
    self.CarBrandNumber.text = carName;

}
@end
