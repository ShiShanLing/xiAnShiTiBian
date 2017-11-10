//
//  ShoppingCartGoodsEditorTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/10.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShoppingCartGoodsEditorTVCell.h"

@implementation ShoppingCartGoodsEditorTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        //选择商品btn
        self.selectedBtn = [OrderBtn new];
        [_selectedBtn setImage:[UIImage imageNamed:@"gxq"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"gxh"] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectedBtn];
         _selectedBtn.sd_layout.leftSpaceToView(self.contentView, kFit(10)).topSpaceToView(self.contentView, 0).widthIs(kFit(30)).bottomSpaceToView(self.contentView, 0);
        //商品图片
        self.goodsImage = [UIImageView new];
        _goodsImage.image = [UIImage imageNamed:@"zly"];
        [self.contentView addSubview:_goodsImage];
           _goodsImage.sd_layout.leftSpaceToView(self.selectedBtn, kFit(10)).topSpaceToView(self.contentView, kFit(5)).widthIs(kFit(92)).heightIs(kFit(92));
        
        self.deleteBtn = [OrderBtn new];
        _deleteBtn.backgroundColor = kNavigation_Color;
        [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_deleteBtn addTarget:self action:@selector(handleDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteBtn];
        _deleteBtn.sd_layout.rightSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(60));
        
        self.goodsNameLabel = [UILabel new];
        _goodsNameLabel.textColor = MColor(51, 51, 51);
        _goodsNameLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_goodsNameLabel];
        _goodsNameLabel.sd_layout.leftSpaceToView(self.goodsImage, kFit(10)).topSpaceToView(self.contentView, kFit(9)).heightIs(kFit(14)).rightSpaceToView(_deleteBtn, 10);
        
        self.ModifyNumberView = [[ModifyNumberView alloc] initWithFrame:CGRectMake(0, 0, 0, kFit(26))];
        _ModifyNumberView.delegate = self;
        _ModifyNumberView.numberTF.layer.borderColor = [MColor(238, 238, 238) CGColor];
        _ModifyNumberView.layer.borderColor = [MColor(238, 238, 238) CGColor];
        [self.contentView addSubview:_ModifyNumberView];
        _ModifyNumberView.sd_layout.topSpaceToView(_goodsNameLabel, kFit(10)).leftSpaceToView(_goodsImage, kFit(10)).widthIs(91).heightIs(kFit(26));
        
        self.dropDownBtn = [OrderBtn new];
        
        UIImage *deopDownImage = [UIImage imageNamed:@"wd-wssj-wldd-xjt"];
        deopDownImage = [deopDownImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_dropDownBtn setImage:deopDownImage forState:(UIControlStateNormal)];
        [_dropDownBtn addTarget:self action:@selector(handleSpecEditorBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_dropDownBtn];
         _dropDownBtn.sd_layout.rightSpaceToView(_deleteBtn,kFit(10)).bottomSpaceToView(self.contentView, kFit(10)).widthIs(kFit(16)).heightIs(kFit(30));
        
        //颜色分类
        self.specLabel = [UILabel new];
        _specLabel.font = MFont(kFit(12));
        self.specLabel.text = @"没有规格!";
        _specLabel.textColor = MColor(123, 123, 123);
        _specLabel.numberOfLines = 0;
        _specLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *specLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSpecLabelTap:)];
        [_specLabel addGestureRecognizer:specLabelTap];
        [self.contentView addSubview:_specLabel];
        _specLabel.sd_layout.leftSpaceToView(_goodsImage, kFit(10)).bottomSpaceToView(self.contentView, kFit(9)).rightSpaceToView(_dropDownBtn, 2).heightIs(kFit(30));
        
        self.segmentationLabel = [UILabel new];
        _segmentationLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_segmentationLabel];
        _segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(2);
    }
    return self;
}
//规格编辑点击事件
- (void)handleSpecEditorBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(specEditor:)]) {
        [_delegate specEditor:(int)sender.tag];
    }
}
//规格编辑点击事件
- (void)handleSpecLabelTap:(UITapGestureRecognizer *)tap {
    if ([_delegate respondsToSelector:@selector(specEditor:)]) {
        [_delegate specEditor:(int)tap.self.view.tag];
    }
}

- (void)selectedClick:(UIButton *)sender {
    _selectedBtn.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(ShoppingCartGoodsSelectedClick:)]) {
        [self.delegate ShoppingCartGoodsSelectedClick:(int)sender.tag];
    }
}

- (void)setModel:(ShoppingCartGoodsModel *)model {
    _model = model;
    _selectedBtn.selected = model.isSelect;
    self.goodsNameLabel.text = model.goodsName;
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImage_URL, _model.goodsImages]] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    _ModifyNumberView.numberTF.text = [NSString stringWithFormat:@"%d", model.goodsNum];
    //self.specLabel.text = @"颜色: 黑色你好啊我很好吃饭了吗,没有,我请你吃便便吧..不吃!";
    if ([model.specInfo isKindOfClass:[NSString class]]) {//如果是NSString
        
        
    }else {
        NSDictionary *specDic = model.specInfo;
        //   NSLog(@"报错的规格ID%@", specDic);
        NSArray *keyArr = [specDic allKeys];
        
        for (int i  = 0; i < keyArr.count; i ++) {
            if (i == 0) {
                self.specLabel.text = [NSString stringWithFormat:@"%@:%@", keyArr[i], specDic[keyArr[i]]];
            }else {
                
                self.specLabel.text = [NSString stringWithFormat:@"%@ \n%@:%@",self.specLabel.text, keyArr[i], specDic[keyArr[i]]];
            }
        }
    }

}

- (void)ControlsAssignment:(NSIndexPath *)indexPath subscript:(BOOL)subscript{
    
    if (subscript) {
        _segmentationLabel.backgroundColor = MColor(228, 228, 228);
        _segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(0.5);
    }

    _selectedBtn.indexPath = indexPath;
    _specLabel.tag = indexPath.section * 100 + indexPath.row-1;
    _dropDownBtn.indexPath = indexPath;
}

- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
- (void)handleDeleteBtn:(UIButton *)sender {

    if ([_delegate respondsToSelector:@selector(GoodsDeleteEvents:)]) {
        [_delegate GoodsDeleteEvents:sender.tag];
    }
    

}

@end
