//
//  SCSNAView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/28.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "SCSNAView.h"
#import "SearchBoxView.h"

@interface SCSNAView ()<SearchBoxViewDelegate>
@property (nonatomic, strong)SearchBoxView * searchBoxView;
@end

@implementation SCSNAView




-(instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton *returnBtn = [UIButton new];
        [returnBtn setImage:[UIImage imageNamed:@"baidiganhui"] forState:(UIControlStateNormal)];
        [returnBtn addTarget:self action:@selector(handleReturnBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:returnBtn];
        returnBtn.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 22).widthIs(kFit(41)).heightIs(34);
        
        UIButton *messageBtn = [UIButton new];
        [messageBtn setImage:[UIImage imageNamed:@"gdhshd"] forState:(UIControlStateNormal)];
        [messageBtn addTarget:self action:@selector(handleMessageBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:messageBtn];
        messageBtn.sd_layout.rightSpaceToView(self, 0).topSpaceToView(self, 22).widthIs(kFit(41)).heightIs(34);
        
        self.searchBoxView = [SearchBoxView new];
        _searchBoxView.backgroundColor = MColor(238, 238, 238);
        _searchBoxView.Delegate = self;
        _searchBoxView.titleLabel.backgroundColor = MColor(238, 238, 238);
        [self addSubview:_searchBoxView];
        _searchBoxView.sd_layout.leftSpaceToView(returnBtn, kFit(3)).topSpaceToView(self, 22).rightSpaceToView(messageBtn, kFit(3)).heightIs(kFit(34));
        
        UILabel *segmentationLabel = [UILabel new];
        segmentationLabel.backgroundColor = MColor(210, 210, 210);
        [self addSubview:segmentationLabel];
        segmentationLabel.sd_layout.leftSpaceToView(self, 0).bottomSpaceToView(self, 0.5).rightSpaceToView(self, 0).heightIs(0.5);
    }
    return self;
}

- (void)SearchJump {

    if ([_delegate respondsToSelector:@selector(SelectedObjects:)]) {
        [_delegate SelectedObjects:0];
    }

}

- (void)handleReturnBtn {

    if ([_delegate respondsToSelector:@selector(SelectedObjects:)]) {
        [_delegate SelectedObjects:1];
    }

}

- (void)handleMessageBtn {
    
    if ([_delegate respondsToSelector:@selector(SelectedObjects:)]) {
        [_delegate SelectedObjects:2];
    }

}
@end
