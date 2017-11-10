//
//  ConfirmOrderGoodsTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ConfirmOrderGoodsTVCell.h"

@implementation ConfirmOrderGoodsTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
               //商品图片
        self.goodsImage = [UIImageView new];
        _goodsImage.image = [UIImage imageNamed:@"zly"];
        [self.contentView addSubview:_goodsImage];
        
           //商品名称
        _goodNameLabel = [UILabel new];
        _goodNameLabel.textAlignment = NSTextAlignmentJustified;
        _goodNameLabel.text = @"商品名字!";
        
        _goodNameLabel.font = MFont(kFit(15));
        [self.contentView addSubview:_goodNameLabel];
        
        //现在价格
        _nowPriceLabel = [UILabel new];;
        _nowPriceLabel.text = @"￥:35000.00";
        _nowPriceLabel.font = MFont(kFit(15));
        _nowPriceLabel.textColor = MColor(255, 50, 50);
        [self.contentView addSubview:_nowPriceLabel];
        
//        NSAttributedString *attrStr =
//        [[NSAttributedString alloc]initWithString:@"￥:45000.00"
//                                       attributes:
//         @{NSFontAttributeName:MFont(kFit(12)),
//           NSForegroundColorAttributeName:[UIColor lightGrayColor],
//           NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
//           NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
//        
//        
//        
//        //之前价格
//        self.oldPriceLabel = [UILabel new];
//        self.oldPriceLabel.attributedText = attrStr;
//        _oldPriceLabel.font = MFont(kFit(13));
//        _oldPriceLabel.textColor = MColor(123, 123, 123);
//        
//        [self.contentView addSubview:_oldPriceLabel];
        
        self.goodCountLabel = [UILabel new];
        _goodCountLabel.font = MFont(kFit(15));
        _goodCountLabel.textColor = MColor(51, 51, 51);
        _goodCountLabel.text = @"X 2";
        _goodCountLabel.textAlignment = 2;
        [self.contentView addSubview:_goodCountLabel];
        
        //颜色分类
        self.colorLabel = [UILabel new];
        _colorLabel.font = MFont(kFit(12));
        //self.colorLabel.text = @"颜色: 黑色";
        _colorLabel.textColor = MColor(123, 123, 123);
        _colorLabel.numberOfLines = 0;
        [self.contentView addSubview:_colorLabel];
        
//        self.typeLabel = [UILabel new];
//        _typeLabel.font = MFont(kFit(12));
//        self.typeLabel.text = @"规格: XXL";
//        _typeLabel.textColor = MColor(123, 123, 123);
//        _typeLabel.numberOfLines = 0;
//        [self.contentView addSubview:_typeLabel];
        
        UILabel *segmentationlabel = [UILabel new];
        segmentationlabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationlabel];
        segmentationlabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
        
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _goodsImage.sd_layout.leftSpaceToView(self.contentView, kFit(10)).topSpaceToView(self.contentView, kFit(27)).widthIs(kFit(81)).heightIs(kFit(85));
    
    _goodNameLabel.sd_layout.leftSpaceToView(self.goodsImage, kFit(10)).topSpaceToView(self.contentView, kFit(25)).heightIs(kFit(15)).rightSpaceToView(self.contentView,5);
    //现在价格
    //现在价格
    CGFloat  widht = [self getWidthWithTitle:@"￥:35000.00" font:[UIFont systemFontOfSize:kFit(15)]];
    
    _nowPriceLabel.sd_layout.leftSpaceToView(self.goodsImage, kFit(10)).topSpaceToView(self.goodNameLabel, kFit(10)).heightIs(kFit(15)).widthIs(widht);
    
//    //原价
//    _oldPriceLabel.sd_layout.leftSpaceToView(self.nowPriceLabel, kFit(10)).bottomSpaceToView(self.nowPriceLabel, -kFit(15)).heightIs(kFit(15)).rightSpaceToView(self.contentView, kFit(15));
    
    _goodCountLabel.sd_layout.rightSpaceToView(self.contentView, kFit(12)).topSpaceToView(_nowPriceLabel, kFit(32)).widthIs(kFit(100)).heightIs(kFit(15));
    
    //规格
    _colorLabel.sd_layout.leftSpaceToView(self.goodsImage, kFit(10)).topSpaceToView(self.nowPriceLabel, kFit(10)).rightSpaceToView(self.goodCountLabel, kFit(10)).bottomSpaceToView(self.contentView, 0);
    
    
}
//在model的set方法里面给cell的控件赋值
- (void)setModel:(ShoppingCartGoodsModel *)model {
    
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImage_URL, model.goodsImages]] placeholderImage:[UIImage imageNamed:@"ImageLoadDefault"]];
    _goodNameLabel.text = model.goodsName;
    _goodCountLabel.text = [NSString stringWithFormat:@"x %d",model.goodsNum];
    _nowPriceLabel.text = [NSString stringWithFormat:@"¥:%.2f", model.goodsPrice];
    
    if ([model.specInfo isKindOfClass:[NSString class]]) {//如果是NSString
        
        
    }else {
    //获取规格
    NSDictionary * specDic = (NSDictionary *)model.specInfo;
  
    NSArray *keyArr =[specDic allKeys];
    
    for (int i  = 0; i < keyArr.count; i ++) {
        if (i == 0) {
            self.colorLabel.text = [NSString stringWithFormat:@"%@:%@", keyArr[i], specDic[keyArr[i]]];
        }else {
            self.colorLabel.text = [NSString stringWithFormat:@"%@ \n%@:%@",self.colorLabel.text, keyArr[i], specDic[keyArr[i]]];
            }
        }
    }
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
