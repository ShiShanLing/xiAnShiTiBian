//
//  StoreDataEditorTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/19.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "StoreDataEditorTVCell.h"

@implementation StoreDataEditorTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"店铺资料";
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.font = MFont(kFit(12));
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).heightIs(kFit(12)).centerYEqualToView(self.contentView).widthIs(kFit(100));
        
        UIButton * editorIconBtn = [UIButton new];
        UIImage *editorImage = [UIImage imageNamed:@"bj"];
        editorImage = [editorImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [editorIconBtn setImage:editorImage forState:(UIControlStateNormal)];
        [editorIconBtn setTitleColor:MColor(134, 134, 134) forState:(UIControlStateNormal)];
        editorIconBtn.titleLabel.font = MFont(kFit(12));
        [editorIconBtn addTarget:self action:@selector(handleEditorBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:editorIconBtn];
        editorIconBtn.sd_layout.rightSpaceToView(self.contentView, kFit(7)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, kFit(0)).widthIs(kFit(30));
        UIButton * editorBtn = [UIButton new];
        [editorBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
        [editorBtn setTitleColor:MColor(134, 134, 134) forState:(UIControlStateNormal)];
        editorBtn.titleLabel.font = MFont(kFit(12));
        [editorBtn addTarget:self action:@selector(handleEditorBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:editorBtn];
        editorBtn.sd_layout.rightSpaceToView(editorIconBtn,0).widthIs(kFit(35)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
       
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(0.5));
    }
    return self;
}

- (void)handleEditorBtn {

    if ([_delegate respondsToSelector:@selector(StortDatEditor)]) {
        [_delegate StortDatEditor];
    }

}
@end
