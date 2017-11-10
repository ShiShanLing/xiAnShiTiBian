//
//  SellerSATVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerSATVCell.h"
@interface SellerSATVCell ()

@property (nonatomic, strong)UILabel *blankLabel;

@end
@implementation SellerSATVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.blankLabel = [UILabel new];
        _blankLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:_blankLabel];
        _blankLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(10));
        
        self.consigneeLabel = [UILabel new];
        _consigneeLabel.text = @"发货人:石山岭";
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
        _addressLabel.text = @"发货地址 : 杭州市上城区沙地路1-2.3 \n燕语林森4栋2单元603";
        _addressLabel.font = MFont(kFit(14));
        _addressLabel.numberOfLines = 0;
        _addressLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_addressLabel];
        _addressLabel.sd_layout.leftSpaceToView(self.contentView, kFit(15)).topSpaceToView(_consigneeLabel, kFit(15)).rightSpaceToView(self.contentView, kFit(15)).heightIs(35);
        
        UILabel *segmentationlabel = [UILabel new];
        segmentationlabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:segmentationlabel];
        segmentationlabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(_addressLabel, kFit(25)).rightSpaceToView(self.contentView, 0).heightIs(kFit(1));
        
        self.chooseBtn = [OrderBtn new];
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
        imageOne = [buttonimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
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
- (void)handleChooseBtn:(OrderBtn *)sender {
    sender.selected = !sender.selected;
    if ([_delegate respondsToSelector:@selector(ModifyDefaultShippingAddress:)]) {
        [_delegate ModifyDefaultShippingAddress:sender];
    }
}

//给btn赋值
- (void)BtnTagAssignment:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        _blankLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(0);
    }
    _deleteBtn.indexPath = indexPath;
    _editorBtn.indexPath = indexPath;
    _chooseBtn.indexPath = indexPath;
}

- (void)setModel:(SellerShipAddressModel *)model {
    _consigneeLabel.text = [NSString stringWithFormat:@"发货人:%@",model.sellerName];
    _telephoneLabel.text = model.mobPhone;
    _addressLabel.text = [NSString stringWithFormat:@"%@ \n%@",model.areaInfo ,model.address];
    if ([model.isDefault isEqualToString:@"1"]) {
        _chooseBtn.selected = YES;
    }else {
    
        _chooseBtn.selected = NO;
    }
}

@end
