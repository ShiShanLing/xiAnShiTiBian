//
//  OrderNumberTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/4.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "OrderNumberTVCell.h"

@interface OrderNumberTVCell ()

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UILabel *detailLabel;

@end

@implementation OrderNumberTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [UILabel new];
        _titleLabel.text = @"订单号";
        _titleLabel.textColor = MColor(51, 51, 51);
        _titleLabel.font = [UIFont systemFontOfSize:kFit(15)];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(100));
        
        self.detailLabel = [UILabel new];
        _detailLabel.text = @"2235675465357";
        _detailLabel.textColor = MColor(134, 134, 134);
        _detailLabel.textAlignment = 2;
        _detailLabel.font = MFont(kFit(15));
        [self.contentView addSubview:_detailLabel];
        _detailLabel.sd_layout.rightSpaceToView(self.contentView, kFit(12)).leftSpaceToView(_titleLabel, kFit(12)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
        
        UILabel *label = [UILabel new];
        label.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:label];
        label.sd_layout.leftSpaceToView(self.contentView, kFit(12)).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(12)).heightIs(0.5);

    }
    return self;
}
- (void)cellAssignment:(NSArray *)array {
    _titleLabel.text = array[0];
    _detailLabel.text = array[1];


}

@end
