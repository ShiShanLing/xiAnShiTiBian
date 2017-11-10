//
//  InputView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/9.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "InputView.h"

@implementation InputView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel =[UILabel new];
        _titleLabel.text = @"这是测试数据";
        _titleLabel.textColor = MColor(51, 51, 51);
        _titleLabel.font = MFont(kFit(14));
        [self addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(self, kFit(22)).centerYEqualToView(self).widthIs(kFit(90)).heightIs(kFit(13));
        
        self.dataTF = [UITextField new];
        _dataTF.font = MFont(kFit(13));
        _dataTF.textColor = MColor(51, 51, 51);
       // _dataTF.delegate = self;
        _dataTF.placeholder = @"请顺便填什么东西.什么都行";
        [self addSubview:_dataTF];
        _dataTF.sd_layout.leftSpaceToView(_titleLabel, kFit(0)).heightIs(kFit(13)).centerYEqualToView(self).rightSpaceToView(self, kFit(12));
        
        UILabel *UnderLabel = [UILabel new];
        UnderLabel.backgroundColor = MColor(238, 238, 238);
        [self addSubview:UnderLabel];
        UnderLabel.sd_layout.leftSpaceToView(self, kFit(0)).bottomSpaceToView(self, 0).rightSpaceToView(self, kFit(0)).heightIs(kFit(0.5));
        
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!textField.window.isKeyWindow) {
        [textField.window makeKeyAndVisible];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
}


@end
