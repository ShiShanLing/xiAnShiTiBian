//
//  DriverHRDTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverHRDTVCell.h"

@interface DriverHRDTVCell ()

@property (nonatomic, strong)UILabel *stateLabel;

@end

@implementation DriverHRDTVCell

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
    }
    return _stateLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.stateLabel = [UILabel new];
        _stateLabel.text = @"已完成";
        _stateLabel.font =MFont(kFit(14));
        _stateLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_stateLabel];
        _stateLabel.sd_layout.rightSpaceToView(self.contentView, kFit(12)).centerYEqualToView (self.contentView).widthIs(kFit(63)).heightIs(kFit(27));
    }
    return self;
}



@end
