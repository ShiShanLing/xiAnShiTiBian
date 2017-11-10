//
//  LeaveWordTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "LeaveWordTVCell.h"

@implementation LeaveWordTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *label = [UILabel new];
        label.text = @"买家留言 :";
        label.textColor =MColor(51, 51, 51);
        label.font  = MFont(kFit(15));
        [self.contentView addSubview:label];
        label.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(17.5)).widthIs(kFit(80)).heightIs(kFit(15));
        
        self.TF = [UITextField new];
        _TF.placeholder = @"选填";
        _TF.font = MFont(kFit(15));
        _TF.textColor = MColor(51, 51, 51);
        _TF.borderStyle = UITextBorderStyleNone;
        [self.contentView addSubview:_TF];
        _TF.sd_layout.leftSpaceToView(label, kFit(0)).topSpaceToView(self.contentView, 17.5).heightIs(kFit(15)).rightSpaceToView(self.contentView, kFit(15));
        
        UILabel *segmentationlabel = [UILabel new];
        segmentationlabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationlabel];
        segmentationlabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
        
    }
    return self;
}

@end
