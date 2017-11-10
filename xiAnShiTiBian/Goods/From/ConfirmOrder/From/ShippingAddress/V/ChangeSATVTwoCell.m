//
//  ChangeSATVTwoCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/17.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ChangeSATVTwoCell.h"

@interface ChangeSATVTwoCell ()

@property (nonatomic, strong)UILabel *blankLabel;

@end

@implementation ChangeSATVTwoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.blankLabel = [UILabel new];
        _blankLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:_blankLabel];
        _blankLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(10));
        
        self.consigneeLabel = [UILabel new];
        _consigneeLabel.text = @"收件人:石山岭";
        _consigneeLabel.font = MFont(kFit(14));
        _consigneeLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_consigneeLabel];
        _consigneeLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(_blankLabel, kFit(25)).widthIs(kFit(130)).heightIs(kFit(14));
        
        self.telephoneLabel = [UILabel new];
        _telephoneLabel.text = @"13673387452";
        _telephoneLabel.font = MFont(kFit(14));
        _telephoneLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_telephoneLabel];
        _telephoneLabel.sd_layout.rightSpaceToView(self.contentView, kFit(20)).topEqualToView(_consigneeLabel).leftSpaceToView(_consigneeLabel, kFit(15)).heightIs(kFit(14));
        
        self.addressLabel = [UILabel new];
        _addressLabel.text = @"收货地址 : 杭州市上城区沙地路1-2.3 \n燕语林森4栋2单元603";
        _addressLabel.font = MFont(kFit(14));
        _addressLabel.numberOfLines = 0;
        _addressLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_addressLabel];
        _addressLabel.sd_layout.leftSpaceToView(self.contentView, kFit(15)).topSpaceToView(_consigneeLabel, kFit(15)).rightSpaceToView(self.contentView, kFit(15)).heightIs(35);
        
        UILabel *segmentationlabel = [UILabel new];
        segmentationlabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:segmentationlabel];
        segmentationlabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(_addressLabel, kFit(25)).rightSpaceToView(self.contentView, 0).heightIs(kFit(1));
        
        self.chooseBtn = [UIButton new];
        [_chooseBtn setImage:[UIImage imageNamed:@"gxq"] forState:(UIControlStateNormal)];
        [_chooseBtn setImage:[UIImage imageNamed:@"gxh"] forState:(UIControlStateSelected)];
        [_chooseBtn addTarget:self action:@selector(handleChooseBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_chooseBtn];
        _chooseBtn.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(segmentationlabel, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(43));
        
        
        
        self.deleteBtn = [OrderBtn new];
        _deleteBtn.tag = 201;
        _deleteBtn.titleLabel.font =MFont(kFit(14));
        UIImage *buttonimage = [UIImage imageNamed:@"ljt"];
        //设置图像渲染方式
        buttonimage = [buttonimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_deleteBtn setImage:buttonimage forState:(UIControlStateNormal)];
        [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        [_deleteBtn setTitleColor:[UIColor colorWithRed:134/256.0 green:134/256.0 blue:134/256.0 alpha:1] forState:(UIControlStateNormal)];
        UIEdgeInsets frame;
        frame = _deleteBtn.imageEdgeInsets ;
        frame.right += 10;
        _deleteBtn.imageEdgeInsets = frame;
        [_deleteBtn addTarget:self action:@selector(handleDeleteBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_deleteBtn];
        _deleteBtn.sd_layout.rightSpaceToView(self.contentView, kFit(12)).topSpaceToView(segmentationlabel, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(70));
        
        self.editorBtn = [OrderBtn buttonWithType:(UIButtonTypeSystem)];
        _editorBtn.titleLabel.font =MFont(kFit(14));
        _editorBtn.tag = 202;
        UIImage *imageOne = [UIImage imageNamed:@"bj"];
        //设置图像渲染方式
        imageOne = [imageOne imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_editorBtn setImage:imageOne forState:(UIControlStateNormal)];
        [_editorBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
        [_editorBtn setTitleColor:[UIColor colorWithRed:134/256.0 green:134/256.0 blue:134/256.0 alpha:1] forState:(UIControlStateNormal)];
        
        frame = _editorBtn.imageEdgeInsets ;
        frame.right += 10;
        _editorBtn.imageEdgeInsets = frame;
        [_editorBtn addTarget:self action:@selector(handleEditorBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_editorBtn];
        _editorBtn.sd_layout.rightSpaceToView(_deleteBtn, kFit(20)).topSpaceToView(segmentationlabel, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(70));
    }
    return self;
}
//删除
- (void)handleDeleteBtn:(OrderBtn *)sender {
    
    if ([_delegate respondsToSelector:@selector(ShoppingAddDeleteBtn:)]) {

        [_delegate ShoppingAddDeleteBtn:sender];
    }
    
}
//编辑
- (void)handleEditorBtn:(OrderBtn *)sender {
    if ([_delegate respondsToSelector:@selector(ShoppingAddEditorBtn:)]) {
        [_delegate ShoppingAddEditorBtn:sender];
    }
}
//修改默认地址
- (void)handleChooseBtn:(UIButton *)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = YES;
    if ([_delegate respondsToSelector:@selector(ChangeDefaultShippingAddress:)]) {
        [_delegate ChangeDefaultShippingAddress:sender];
    }
}
//给btn赋值
- (void)BtnTagAssignment:(NSIndexPath *)indexPath model:(ShippingAddressModel *)model{
    NSLog(@"--------%@", model.isDefault);
    if ([model.isDefault isEqualToString:@"1"]) {
        _chooseBtn.selected = YES;
    }else {
        _chooseBtn.selected = NO;
    }
    if (indexPath.row == 0) { //不要管这行代码 你看不懂的
         _blankLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(0);
    }
    _editorBtn.tag = indexPath.row;
    _deleteBtn.tag = indexPath.row;
    _chooseBtn.tag = indexPath.row;
    
    _consigneeLabel.text =model.trueName;
    _telephoneLabel.text =model.mobPhone;
    _addressLabel.text = [NSString stringWithFormat:@"%@ \n%@", model.areaInfo, model.address];
    
    
    _deleteBtn.indexPath = indexPath;
    _editorBtn.indexPath = indexPath;

}
@end
