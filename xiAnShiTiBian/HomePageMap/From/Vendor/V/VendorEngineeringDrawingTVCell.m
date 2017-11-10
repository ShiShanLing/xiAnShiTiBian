//
//  VendorEngineeringDrawingTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/23.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "VendorEngineeringDrawingTVCell.h"
#import "VendorEngineeringView.h"

@interface VendorEngineeringDrawingTVCell ()

@property (nonatomic, strong)VendorEngineeringView *VendorEngineeringOne;
@property (nonatomic, strong)VendorEngineeringView *VendorEngineeringTwo;
@property (nonatomic, strong)VendorEngineeringView *VendorEngineeringThree;
@property (nonatomic, strong)VendorEngineeringView *VendorEngineeringFour;

@end

@implementation VendorEngineeringDrawingTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UILabel *segmentationLabel = [UILabel new];
        segmentationLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:segmentationLabel];
        segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, kFit(0)).rightSpaceToView(self.contentView, 0).heightIs(kFit(10));
        
        UILabel *tilteLabel = [UILabel new];
        tilteLabel.text = @"工程展示";
        tilteLabel.textColor = MColor(51, 51, 51);
        tilteLabel.font = MFont(kFit(17));
        [self.contentView addSubview:tilteLabel];
        tilteLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(segmentationLabel,kFit(17.5)).widthIs(kFit(100)).heightIs(kFit(17.5));
        
        
        UIButton *moreBtn = [UIButton new];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:kFit(14)];
        [moreBtn setTitle:@"更多" forState:(UIControlStateNormal)];
        [moreBtn setTitleColor:MColor(134, 134, 134) forState:(UIControlStateNormal)];
        UIImage *buttonimage = [UIImage imageNamed:@"jt"];
        buttonimage = [buttonimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [moreBtn setImage:buttonimage forState:(UIControlStateNormal)];
        UIEdgeInsets imageframe;
        imageframe = moreBtn.imageEdgeInsets;
        imageframe.right -= 40;
        moreBtn.imageEdgeInsets = imageframe;
        UIEdgeInsets titleframe;
        titleframe = moreBtn.titleEdgeInsets;
        titleframe.left -=42;
        moreBtn.titleEdgeInsets = titleframe;
        [moreBtn addTarget:self action:@selector(handleMoreBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:moreBtn];
        moreBtn.sd_layout.rightSpaceToView(self.contentView, 0).topSpaceToView(segmentationLabel, kFit(5)).heightIs(kFit(42)).widthIs(kFit(50));
        
        
        self.VendorEngineeringOne = [VendorEngineeringView new];
        [self.contentView addSubview:_VendorEngineeringOne];
        _VendorEngineeringOne.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(tilteLabel, kFit(17.5)).widthIs(kFit(173)).heightIs(kFit(180));
        
        self.VendorEngineeringTwo = [VendorEngineeringView new];
        [self.contentView addSubview:_VendorEngineeringTwo];
        _VendorEngineeringTwo.sd_layout.leftSpaceToView(_VendorEngineeringOne, kFit(10)).topSpaceToView(tilteLabel, kFit(17.5)).widthIs(kFit(170)).heightIs(kFit(180));
        
        self.VendorEngineeringThree = [VendorEngineeringView new];
        [self.contentView addSubview:_VendorEngineeringThree];
        _VendorEngineeringThree.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(_VendorEngineeringOne, kFit(10)).widthIs(kFit(173)).heightIs(kFit(180));
        
        
        self.VendorEngineeringFour = [VendorEngineeringView new];
        [self.contentView addSubview:_VendorEngineeringFour];
        _VendorEngineeringFour.sd_layout.leftSpaceToView(_VendorEngineeringOne, kFit(10)).topSpaceToView(_VendorEngineeringOne, kFit(10)).widthIs(kFit(173)).heightIs(kFit(180));

        
    }
    return self;
    
}
- (void)handleMoreBtn {
    if ([_delegate respondsToSelector:@selector(MoreEngineering)]) {
        [_delegate MoreEngineering];
    }
    
}

@end
