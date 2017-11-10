//
//  ShoppingCartGoodsTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/8.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ShoppingCartGoodsTVCell.h"
#import "UIImageView+WebCache.h"

@implementation ShoppingCartGoodsTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        //选择商品btn
        _selectedBtn = [UIButton new];
        [_selectedBtn setImage:[UIImage imageNamed:@"gxq"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"gxh"] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectedBtn];
        //商品图片
        self.goodsImage = [UIImageView new];
        _goodsImage.image = [UIImage imageNamed:@"zly"];
        [self.contentView addSubview:_goodsImage];
        //商品名称
        _goodNameLabel = [UILabel new];
        _goodNameLabel.text = @"商品名字!";
        _goodNameLabel.font = MFont(kFit(15));
        _goodNameLabel.numberOfLines = 0;
        [self.contentView addSubview:_goodNameLabel];
        
        //现在价格
        _nowPriceLabel = [UILabel new];;
        _nowPriceLabel.text = @"￥:35000.00";
        _nowPriceLabel.font = MFont(kFit(15));
        _nowPriceLabel.textColor = MColor(255, 50, 50);
        [self.contentView addSubview:_nowPriceLabel];
        NSAttributedString *attrStr =
        [[NSAttributedString alloc]initWithString:@"￥:45000.00"
                                       attributes:
         @{NSFontAttributeName:MFont(kFit(12)),
           NSForegroundColorAttributeName:[UIColor lightGrayColor],
           NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
           NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
        
        //之前价格
        self.oldPriceLabel = [UILabel new];
        self.oldPriceLabel.attributedText = attrStr;
        _oldPriceLabel.font = MFont(kFit(13));
        _oldPriceLabel.textColor = MColor(123, 123, 123);
        
        [self.contentView addSubview:_oldPriceLabel];
 
        //颜色分类
        self.colorLabel = [UILabel new];
        _colorLabel.font = MFont(kFit(12));
        _colorLabel.textColor = MColor(123, 123, 123);
        _colorLabel.numberOfLines = 0;
        [self.contentView addSubview:_colorLabel];
        
//        self.typeLabel = [UILabel new];
//        _typeLabel.font = MFont(kFit(12));
//      //  self.typeLabel.text = @"规格: XXL";
//        _typeLabel.textColor = MColor(123, 123, 123);
//        _typeLabel.numberOfLines = 0;
//        [self.contentView addSubview:_typeLabel];
        
        self.ModifyNumberView  = [[ModifyNumberView alloc] initWithFrame:CGRectMake(0, 0, 0, kFit(25))];
        _ModifyNumberView.hidden = YES;
        [self.contentView addSubview:_ModifyNumberView];
        
        self.goodCountLabel = [UILabel new];
        _goodCountLabel.font = MFont(kFit(12));
        _goodCountLabel.textAlignment = 2;
        _goodCountLabel.text = @"数量:X 1";
        _goodCountLabel.textColor = MColor(123, 123, 123);
        [self.contentView addSubview:_goodCountLabel];
        
        self.segmentationLabel = [UILabel new];
        _segmentationLabel.backgroundColor =  MColor(238, 238, 238);
        [self.contentView addSubview:_segmentationLabel];
        _segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(1);
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _selectedBtn.sd_layout.leftSpaceToView(self.contentView, kFit(10)).topSpaceToView(self.contentView, 0).widthIs(kFit(30)).bottomSpaceToView(self.contentView, 0);
    
    _goodsImage.sd_layout.leftSpaceToView(self.selectedBtn, kFit(10)).topSpaceToView(self.contentView, kFit(5)).widthIs(kFit(92)).heightIs(kFit(92));

     _goodNameLabel.sd_layout.leftSpaceToView(self.goodsImage, kFit(10)).topSpaceToView(self.contentView, kFit(5)).heightIs(kFit(15)).rightSpaceToView(self.contentView,5);
    //现在价格
   CGFloat  widht = [self getWidthWithTitle:@"￥:35000.00" font:[UIFont systemFontOfSize:kFit(15)]];
    _nowPriceLabel.sd_layout.leftSpaceToView(self.goodsImage, kFit(10)).topSpaceToView(self.goodNameLabel, kFit(10)).heightIs(kFit(15)).widthIs(widht);
    //原价
    _oldPriceLabel.sd_layout.leftSpaceToView(self.nowPriceLabel, kFit(10)).bottomSpaceToView(self.nowPriceLabel, -kFit(15)).heightIs(kFit(15)).widthIs(widht);
    
    self.ModifyNumberView.sd_layout.rightSpaceToView(self.contentView, kFit(20)).bottomSpaceToView(self.contentView, kFit(25)).heightIs(kFit(25)).widthIs(kFit(90));
    
    self.goodCountLabel.sd_layout.rightSpaceToView(self.contentView, kFit(20)).bottomSpaceToView(self.contentView, kFit(12)).heightIs(kFit(25)).widthIs(kFit(40));
    //规格
    _colorLabel.sd_layout.leftSpaceToView(self.goodsImage, kFit(10)).topSpaceToView(self.nowPriceLabel, kFit(10)).rightSpaceToView(self.goodCountLabel, kFit(10)).bottomSpaceToView(self.contentView, 0);
}

- (void)selectedClick:(UIButton *)sender {
    _selectedBtn.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(ShoppingCartGoodsSelectedClick:)]) {
        [self.delegate ShoppingCartGoodsSelectedClick:sender.tag];
    }
}
- (void)setModel:(ShoppingCartGoodsModel *)model {
    _model = model;
  //  NSLog(@"model%@", model);
      [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImage_URL, _model.goodsImages]] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    _selectedBtn.selected = model.isSelect;
    _goodNameLabel.text = model.goodsName;
    _nowPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", model.goodsPrice];
    NSAttributedString *attrStr =
    [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥%.2f", model.goodsPrice]
                                   attributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:kFit(12)],
       NSForegroundColorAttributeName:[UIColor lightGrayColor],
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    self.oldPriceLabel.attributedText = nil;
    _goodCountLabel.text = [NSString stringWithFormat:@"x%d", model.goodsNum];
    
    if ([model.specInfo isKindOfClass:[NSString class]]) {//如果是NSString
        
        
    }else {
    NSDictionary *specDic = model.specInfo;
 //   NSLog(@"报错的规格ID%@", specDic);
    NSArray *keyArr = [specDic allKeys];
    
    for (int i  = 0; i < keyArr.count; i ++) {
        if (i == 0) {
            self.colorLabel.text = [NSString stringWithFormat:@"%@:%@", keyArr[i], specDic[keyArr[i]]];
        }else {
        
            self.colorLabel.text = [NSString stringWithFormat:@"%@ \n%@:%@",self.colorLabel.text, keyArr[i], specDic[keyArr[i]]];
        }
        }
    }
}

- (void)ControlsAssignment:(NSIndexPath *)indexPath subscript:(BOOL)subscript{
    
    if (subscript) {
        _segmentationLabel.backgroundColor = MColor(228, 228, 228);
        _segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(0.5);
    }
    _selectedBtn.tag =indexPath.section * 100 + indexPath.row-1;
    
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


@end
