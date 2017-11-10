//
//  GoodsRecCViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/1.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "GoodsRecCViewCell.h"
@implementation GoodsRecCViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self CreatingControls];
        
    }
    return self;
}
- (void)CreatingControls {
    self.goodsImage = [UIImageView new];
    self.goodsImage.image = [UIImage imageNamed:@"zly"];
    [self.contentView addSubview:self.goodsImage];
    self.goodsImage.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).autoHeightRatio(1.0);
  CGFloat height =  [self getHeightByWidth:self.frame.size.width - kFit(5) title:@"赵丽颖是个美女,虽然她脸很大!" font:MFont(kFit(13))];
    self.goodsName = [UILabel new];
    self.goodsName.text = @"商品名字!";
    self.goodsName.numberOfLines = 0;
    self.goodsName.lineBreakMode = UILineBreakModeWordWrap;
    self.goodsName.font = MFont(kFit(13));
    [self.contentView addSubview:self.goodsName];
    self.goodsName.sd_layout.leftSpaceToView(self.contentView, kFit(5)).rightSpaceToView(self.contentView, kFit(10)).topSpaceToView(self.goodsImage, 5).heightIs(height);
    
    
//    self.searchBtn = [UIButton new];
//    self.searchBtn.font = MFont(kFit(13));
//    self.searchBtn.layer.borderWidth = 1;
//    self.searchBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
//    self.searchBtn.layer.cornerRadius = 3;
//    self.searchBtn.layer.masksToBounds = YES;
//    self.searchBtn.backgroundColor = [UIColor redColor];
//    [self.searchBtn setTitle:@"找相似" forState:(UIControlStateNormal)];
//    [self.contentView addSubview:self.searchBtn];
//    self.searchBtn.sd_layout.topSpaceToView(self.goodsName, 5).rightSpaceToView(self.contentView, 5).widthIs(50).autoHeightRatio(0.5).bottomSpaceToView(self.contentView, 5).topSpaceToView(self.goodsName, 5);
    
    
    self.goodsPrice = [UILabel new];
    self.goodsPrice.text = @"￥:多少钱都不卖";
    self.goodsPrice.font = MFont(kFit(13));
    self.goodsPrice.textColor = [UIColor redColor];
    [self.contentView addSubview:self.goodsPrice];
    self.goodsPrice.sd_layout.leftSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView, 10).heightIs(20).rightSpaceToView(self.contentView, 15);
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

-(void)setModel:(GoodsDetailsModel *)model {
    [self.goodsImage setImageViewAssignmentURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.goodsImage] image:[UIImage imageNamed:@"jiazaishibai"]];
    self.goodsName.text = model.goodsName;
    self.goodsPrice.text = [NSString stringWithFormat:@"¥:%.2f", model.goodsStorePrice];
    
}
@end
