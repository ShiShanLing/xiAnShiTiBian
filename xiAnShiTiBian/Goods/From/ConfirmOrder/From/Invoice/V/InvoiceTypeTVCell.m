//
//  InvoiceTypeTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/19.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "InvoiceTypeTVCell.h"

@implementation InvoiceTypeTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *TopSegmentationLabel = [UILabel new];
        TopSegmentationLabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:TopSegmentationLabel];
        TopSegmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(0.5);
        
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"发票内容";
        titleLabel.font = MFont(kFit(15));
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView (self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(17)).widthIs(kFit(100)).heightIs(kFit(15));
        
        UIButton *paperTaxBtn = [UIButton new];
        paperTaxBtn.tag = 241;
        paperTaxBtn.titleLabel.font = MFont(kFit(14));
        [paperTaxBtn setTitle:@"纸质发票" forState:(UIControlStateNormal)];
        [paperTaxBtn setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
        [paperTaxBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateSelected)];
        [paperTaxBtn.layer setMasksToBounds:YES];
        [paperTaxBtn.layer setCornerRadius:kFit(3)]; //设置矩形四个圆角半径
        [paperTaxBtn.layer setBorderWidth:0.5]; //边框宽度
        [paperTaxBtn.layer setBorderColor:[kNavigation_Color CGColor]];
        [paperTaxBtn addTarget:self action:@selector(handleYESBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:paperTaxBtn];
        paperTaxBtn.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(titleLabel, kFit(15)).widthIs(kFit(95)).heightIs(kFit(35));
        
        
        UIButton *electronicTaxBtn = [UIButton new];
        electronicTaxBtn.tag = 242;
        electronicTaxBtn.titleLabel.font = MFont(kFit(14));
        [electronicTaxBtn setTitle:@"电子发票" forState:(UIControlStateNormal)];
        [electronicTaxBtn setTitleColor:kNavigation_Color forState:(UIControlStateSelected)];
        [electronicTaxBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        [electronicTaxBtn.layer setMasksToBounds:YES];
        [electronicTaxBtn.layer setCornerRadius:kFit(3)]; //设置矩形四个圆角半径
        [electronicTaxBtn.layer setBorderWidth:0.5]; //边框宽度
        [electronicTaxBtn.layer setBorderColor:[MColor(161, 161, 161) CGColor]];
        [electronicTaxBtn addTarget:self action:@selector(handleNOBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:electronicTaxBtn];
       electronicTaxBtn.sd_layout.leftSpaceToView(paperTaxBtn, kFit(12)).topSpaceToView(titleLabel, kFit(15)).widthIs(kFit(95)).heightIs(kFit(35));
        
        
        
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

- (void)handleYESBtn:(UIButton *)sender {
        [sender.layer setBorderColor:[kNavigation_Color CGColor]];
        [sender setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
        UIButton *btn = (UIButton *)[self viewWithTag:242];
        [btn.layer setBorderColor:[MColor(161, 161, 161) CGColor]];
        [btn setTitleColor:MColor(161, 161, 161) forState:(UIControlStateNormal)];
    
        if ([_delegate respondsToSelector:@selector(InvoiceType:)]) {
            [_delegate InvoiceType:1];
        }
    
}

- (void)handleNOBtn:(UIButton *)sender {
    
    [sender.layer setBorderColor:[kNavigation_Color CGColor]];
    [sender setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
    UIButton *btn = (UIButton *)[self viewWithTag:241];
    [btn.layer setBorderColor:[MColor(161, 161, 161) CGColor]];
    [btn setTitleColor:MColor(161, 161, 161) forState:(UIControlStateNormal)];
    if ([_delegate respondsToSelector:@selector(InvoiceType:)]) {
        [_delegate InvoiceType:2];
    }

    
}

@end
