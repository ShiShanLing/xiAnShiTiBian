
//
//  AlertsTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "AlertsTVCell.h"


@interface AlertsTVCell ()

@property (nonatomic, strong)UILabel *titleLable;
@property (nonatomic, strong)UISwitch *chooseSwitch;

@end

@implementation AlertsTVCell

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UILabel new];
    }
    return _titleLable;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLable.text = @"消息通知";
        _titleLable.font = MFont(kFit(14));
        _titleLable.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_titleLable];
        _titleLable.sd_layout.leftSpaceToView(self.contentView,kFit(12)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(120));

        
        self.chooseSwitch  = [UISwitch new];
        BOOL setting =  _chooseSwitch.isOn;
        [_chooseSwitch setOn:setting animated:YES];
        _chooseSwitch.onTintColor = kNavigation_Color;
        _chooseSwitch.tintColor = MColor(210, 210, 210);
        [_chooseSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_chooseSwitch];
    
        _chooseSwitch.sd_layout.rightSpaceToView(self.contentView, kFit(12)).widthIs(kFit(40)).heightIs(kFit(25)).centerYEqualToView(self.contentView);
        
        UILabel *segmentationlabel = [UILabel new];
        segmentationlabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationlabel];
        segmentationlabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
    }
    return self;
}

- (void)switchAction:(UISwitch *)sender {



}

- (void)subscript:(int)index judge:(BOOL)judge {
    
    switch (index) {
        case 1:{
            _titleLable.text = @"接收消息推送";
            if (judge) {
                _chooseSwitch.on = YES;
            }else {
               _chooseSwitch.on = NO;
            }
        }
            break;
        case 2:{
            _titleLable.font = MFont(kFit(12));
            _titleLable.text = @"买家消息推送";
            _chooseSwitch.sd_layout.rightSpaceToView(self.contentView, kFit(12)).widthIs(kFit(35)).heightIs(kFit(20)).centerYEqualToView(self.contentView);
            if (judge) {
                _chooseSwitch.on = YES;
            }else {
               _chooseSwitch.on = NO;
            }
        }
            break;
        case 3:{
            _titleLable.font = MFont(kFit(12));
            _titleLable.text = @"商家消息推送";
            if (judge) {
                _chooseSwitch.on = YES;
            }else {
                _chooseSwitch.on = NO;
            }
        }
            break;
        case 4:{
            _titleLable.font = MFont(kFit(12));
            _titleLable.text = @"车主消息推送";
            if (judge) {
                _chooseSwitch.on = YES;
            }else {
                _chooseSwitch.on = NO;
            }

        }
            break;
                default:
            break;
    }
    

}

@end
