//
//  ContactTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/8.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ContactTVCell.h"

@interface ContactTVCell ()



@end

@implementation ContactTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bottomViewTwo = [UIView new];
        bottomViewTwo.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bottomViewTwo];
        bottomViewTwo.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, kFit(15)).rightSpaceToView(self.contentView, 0).heightIs(kFit(92.5));
        
        UILabel *titleLabelOne = [UILabel new];
        titleLabelOne.text = @"联系方式";
        titleLabelOne.textColor = MColor(134, 134, 134);
        titleLabelOne.font = MFont(kFit(15));
        [bottomViewTwo addSubview:titleLabelOne];
        titleLabelOne.sd_layout.leftSpaceToView(bottomViewTwo, kFit(15)).topSpaceToView(bottomViewTwo, kFit(17)).widthIs(100).heightIs(kFit(15));
        
        UIImageView *storeImage = [UIImageView new];
        storeImage.image = [UIImage imageNamed:@"dianhua"];
        [bottomViewTwo addSubview:storeImage];
        storeImage.sd_layout.leftSpaceToView(bottomViewTwo, kFit(15)).topSpaceToView(titleLabelOne, kFit(17)).widthIs(kFit(23)).heightIs(kFit(23));
        
        self.ContactPhoneTF = [UITextField new];
        _ContactPhoneTF.placeholder = @"请输入联系方式";
        _ContactPhoneTF.borderStyle = UITextBorderStyleNone;
        _ContactPhoneTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [bottomViewTwo addSubview:_ContactPhoneTF];
        _ContactPhoneTF.sd_layout.leftSpaceToView(storeImage, kFit(15)).topEqualToView(storeImage).rightSpaceToView(bottomViewTwo, kFit(30)).heightIs(kFit(25));
        
    }
    return self;
}

@end
