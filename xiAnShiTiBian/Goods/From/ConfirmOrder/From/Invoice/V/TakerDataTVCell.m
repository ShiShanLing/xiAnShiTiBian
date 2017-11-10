//
//  TakerDataTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/22.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "TakerDataTVCell.h"

@implementation TakerDataTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        UILabel *segmentationLabelOne = [UILabel new];
        segmentationLabelOne.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationLabelOne];
        segmentationLabelOne.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(0.5);
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"收票人信息";
        titleLabel.font = MFont(kFit(15));
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView (self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(17)).widthIs(kFit(100)).heightIs(kFit(15));
        
        UILabel *segmentationLabelTwo = [UILabel new];
        segmentationLabelTwo.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationLabelTwo];
        segmentationLabelTwo.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(titleLabel, kFit(15)).rightSpaceToView(self.contentView, 0).heightIs(0.5);
        
        UILabel *label = [UILabel new];
        label.text = @"收票人手机号 :";
        label.textColor =MColor(51, 51, 51);
        label.font  = MFont(kFit(15));
        [self.contentView addSubview:label];
        label.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(segmentationLabelTwo, kFit(17.5)).widthIs(kFit(110)).heightIs(kFit(15));
        
        self.phoneTF = [UITextField new];
        _phoneTF.placeholder = @"必填";
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.font = MFont(kFit(15));
        _phoneTF.textColor = MColor(51, 51, 51);
        _phoneTF.borderStyle = UITextBorderStyleNone;
        [self.contentView addSubview:_phoneTF];
        _phoneTF.sd_layout.leftSpaceToView(label, kFit(0)).topSpaceToView(segmentationLabelTwo, kFit(17.5)).heightIs(kFit(15)).rightSpaceToView(self.contentView, kFit(15));
        
        UILabel *segmentationlabelThree = [UILabel new];
        segmentationlabelThree.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationlabelThree];
        segmentationlabelThree.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.phoneTF, kFit(17.5)).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
        
        UILabel *labelTwo = [UILabel new];
        labelTwo.text = @"收票人邮箱 :";
        labelTwo.textColor =MColor(51, 51, 51);
        labelTwo.font  = MFont(kFit(15));
        [self.contentView addSubview:labelTwo];
        labelTwo.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(segmentationlabelThree, kFit(17.5)).widthIs(kFit(110)).heightIs(kFit(15));
        
        self.emailTF = [UITextField new];
        _emailTF.placeholder = @"必填";
        _emailTF.keyboardType = UIKeyboardTypeEmailAddress;
        _emailTF.font = MFont(kFit(15));
        _emailTF.textColor = MColor(51, 51, 51);
        _emailTF.borderStyle = UITextBorderStyleNone;
        [self.contentView addSubview:_emailTF];
        _emailTF.sd_layout.leftSpaceToView(label, kFit(0)).topSpaceToView(segmentationlabelThree, kFit(17.5)).heightIs(kFit(15)).rightSpaceToView(self.contentView, kFit(15));

        
        UILabel *segmentationlabelFour = [UILabel new];
        segmentationlabelFour.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationlabelFour];
        segmentationlabelFour.sd_layout.leftSpaceToView(self.contentView, kFit(0)).bottomSpaceToView(self.contentView, kFit(0)).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
        
    }
    return self;

}

@end
