//
//  ShopCartHeadViewCell.m
//  meidianjie
//
//  Created by HYS on 16/1/5.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "ShopCartHeadViewCell.h"
@implementation ShopCartHeadViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //店铺全选
        self.selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setImage:[UIImage imageNamed:@"gxq"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"gxh"] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectedBtn];
        
        //店铺小图标
        _shopIcon = [[UIImageView alloc]init];
        _shopIcon.image = [UIImage imageNamed:@"dp"];
        
        [self.contentView addSubview:_shopIcon];
        //店铺名称
         _shopNameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_shopNameLabel];
        //更多
        self.editorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editorBtn setTitle:@"完成" forState:(UIControlStateNormal)];
         _editorBtn.titleLabel.font = MFont(kFit(14));
        [_editorBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        [_editorBtn setTitle:@"编辑"  forState:UIControlStateSelected];
        [_editorBtn addTarget:self action:@selector(handleeditorBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_editorBtn];
        
        UILabel *dividerLineLabel = [[UILabel alloc] init];
        dividerLineLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:dividerLineLabel];
        dividerLineLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(1);
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _selectedBtn.width = kFit(30);
    _selectedBtn.height = self.contentView.height;
    _selectedBtn.x = kFit(10);
    _selectedBtn.centerY = CGRectGetMidY(self.contentView.frame);
    _shopIcon.x = kFit(5) + CGRectGetMaxX(_selectedBtn.frame);
    _shopIcon.width = kFit(18);
    _shopIcon.height = kFit(18);
    _shopIcon.centerY = CGRectGetMidY(_selectedBtn.frame);
    _shopNameLabel.x = kFit(8) + CGRectGetMaxX(_shopIcon.frame);
    _shopNameLabel.font = MFont(kFit(TextSize));
    _shopNameLabel.centerY = CGRectGetMidY(_selectedBtn.frame);
    _shopNameLabel.textColor = MColor(10, 10, 10);
    _editorBtn.sd_layout.rightSpaceToView(self.contentView, kFit(0)).widthIs(kFit(68)).centerYEqualToView(self.contentView).heightIs(self.contentView.height);
     
}
//选择点击事件
- (void)selectedClick:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    if ([self.delegate respondsToSelector:@selector(shopCartStoreSelectedClick:state:)]) {
        [self.delegate shopCartStoreSelectedClick:(int)sender.tag state:sender.selected];
    }
}

- (void)handleeditorBtn:(UIButton *)sender {
    
    NSLog(@"handleeditorBtn%@", sender.selected?@"YES":@"NO");
    if ([_delegate respondsToSelector:@selector(ShopGoodsEditor:state:)]) {
        [_delegate ShopGoodsEditor:(int)sender.tag state:sender.selected];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
//店铺商品编辑事件
- (void)ControlsAssignment:(NSIndexPath *)indexPath {
    
    _editorBtn.tag = indexPath.section;
    _selectedBtn.tag = indexPath.section;
    
}

- (void)setModel:(ShoppingCartStoreModel *)model{
   // _selectedBtn.selected = model.isSelect;
    _selectedBtn.selected = model.isSelect;
    _editorBtn.selected = model.isEditor;
    _model = model;
    _shopNameLabel.text = model.storeName;
    [_shopNameLabel sizeToFit];
    _shopNameLabel.centerY = CGRectGetMidY(_selectedBtn.frame);
}
@end
