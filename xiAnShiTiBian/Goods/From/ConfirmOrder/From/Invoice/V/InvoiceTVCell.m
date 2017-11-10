//
//  InvoiceTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/22.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "InvoiceTVCell.h"
/**
 *199  166  234
 */
@implementation InvoiceTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *segmentationLabel = [UILabel new];
        segmentationLabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationLabel];
        segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(0.5);
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"发票内容";
        titleLabel.font = MFont(kFit(15));
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView (self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(17)).widthIs(kFit(100)).heightIs(kFit(15));
        
        UIButton *YESBtn = [UIButton new];//开发票
        [YESBtn setImage:[self imageRendering:@"gxq"] forState:(UIControlStateNormal)];
        YESBtn.tag = 261;
        
        YESBtn.titleLabel.font= MFont(kFit(14));
        [YESBtn setTitle:@"明细" forState:(UIControlStateNormal)];
        [YESBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        UIEdgeInsets frame;
        frame = YESBtn.imageEdgeInsets ;
        frame.right += 10;
        YESBtn.imageEdgeInsets = frame;
          [YESBtn addTarget:self action:@selector(handlePersonalBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:YESBtn];
        YESBtn.sd_layout.leftSpaceToView (self.contentView, 0).topSpaceToView(titleLabel, kFit(7.5)).widthIs(kFit(82)).heightIs(kFit(33));

        UIButton *NOBtn = [UIButton new];//不开发票
        [NOBtn setImage:[self imageRendering:@"gxh"] forState:(UIControlStateNormal)];
        NOBtn.tag = 262;
        NOBtn.titleLabel.font= MFont(kFit(14));
        [NOBtn setTitle:@"不开发票" forState:(UIControlStateNormal)];
        [NOBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        NOBtn.imageEdgeInsets = frame;
        [NOBtn addTarget:self action:@selector(handleEnterpriseBtn:) forControlEvents:(UIControlEventTouchUpInside)];

        [self.contentView addSubview:NOBtn];
        NOBtn.sd_layout.leftSpaceToView (self.contentView, 0).topSpaceToView(YESBtn, kFit(0)).widthIs(kFit(110)).heightIs(kFit(33));
        
        UILabel *bottomSegmentationLabel = [UILabel new];
        bottomSegmentationLabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:bottomSegmentationLabel];
        bottomSegmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, kFit(10.5)).rightSpaceToView(self.contentView, 0).heightIs(0.5);
        UIView *BottomView = [UIView new];
        BottomView.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:BottomView];
        BottomView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(bottomSegmentationLabel, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
        
    }
    return self;
}
//设置图像渲染方式
- (UIImage *)imageRendering:(NSString *)name{
    
    UIImage *buttonimage = [UIImage imageNamed:name];
    buttonimage = [buttonimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    return buttonimage;
    
}

- (void)handlePersonalBtn:(UIButton *)sender {//开发票
    
    [sender setImage:[self imageRendering:@"gxh"] forState:(UIControlStateNormal)];
    
    UIButton *btn = (UIButton *)[self viewWithTag:262];
    
    [btn setImage:[self imageRendering:@"gxq"] forState:(UIControlStateNormal)];
    
    if ([_delegate respondsToSelector:@selector(Invoice:)]) {
        [_delegate Invoice:1];
    }
    
}
- (void)handleEnterpriseBtn:(UIButton *)sender {//不开发票
    [sender setImage:[self imageRendering:@"gxh"] forState:(UIControlStateNormal)];
    
    UIButton *btn = (UIButton *)[self viewWithTag:261];
    [btn setImage:[self imageRendering:@"gxq"] forState:(UIControlStateNormal)];
    
    if ([_delegate respondsToSelector:@selector(Invoice:)]) {
        [_delegate Invoice:0];
    }
}


@end
