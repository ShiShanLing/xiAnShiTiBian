//
//  GoodsEditorTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/9.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "GoodsEditorTVCell.h"
@interface GoodsEditorTVCell ()

/**
 *展示商品的图片
 */
@property (nonatomic, strong)UIImageView *showImage;
/**
 *商品名称
 */
@property (nonatomic, strong)UILabel *nameLabel;
/**
 *商品价格
 */
@property (nonatomic, strong)UILabel *priceLabel;
/**
 *商品选择状态
 */
@property (nonatomic, strong)UIButton *chooseBtn;

@end
@implementation GoodsEditorTVCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setCreatingControls];
        
    }
    return self;
}


- (void)setCreatingControls {
    
    self.chooseBtn = [UIButton new];
    UIImage *chooseImage = [UIImage imageNamed:@"gxq"];//gxh
    //[tapButton setImage:buttonimage forState:(UIControlStateNormal)];
    //设置图像渲染方式
    chooseImage = [chooseImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    _chooseBtn.userInteractionEnabled = NO;
    [_chooseBtn setImage:chooseImage forState:(UIControlStateNormal)];
    [self.contentView addSubview:_chooseBtn];
    _chooseBtn.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(42));
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kFit(42), 0, kScreen_widht-kFit(42), self.frame.size.height)];
    [self.contentView addSubview:view];
    
    self.showImage = [UIImageView new];
    self.showImage.image = [UIImage imageNamed:@"zly"];
    self.showImage.layer.cornerRadius = 3;
    self.showImage.layer.masksToBounds = YES;
    
    [view addSubview:self.showImage];
    self.showImage.sd_layout.leftSpaceToView(view, 0).topSpaceToView(view, 0).bottomSpaceToView(view, 0).widthIs(kFit(123)).autoHeightRatio(1);

    self.nameLabel = [UILabel new];
    self.nameLabel.text =@"绝版红尘木";
    CGFloat width =  [self getHeightByWidth:kFit(215) title:@"呵呵呵呵呵呵呵呵" font:[UIFont systemFontOfSize:kFit(15)]];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.font = [UIFont systemFontOfSize:kFit(15)];
    self.nameLabel.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
    [view addSubview:self.nameLabel];
    self.nameLabel.sd_layout.leftSpaceToView(self.showImage, kFit(12)).topSpaceToView(view, kFit(5)).heightIs(width).rightSpaceToView(view, 15);
    
    self.priceLabel = [UILabel new];
    self.priceLabel.text = @"￥ 599.00";
    self.priceLabel.font = MFont(kFit(12));
    self.priceLabel.textColor = [UIColor colorWithRed:255/256.0 green:50/256.0 blue:50/256.0 alpha:1];
    [view addSubview:self.priceLabel];
    self.priceLabel.sd_layout.leftSpaceToView(self.showImage, kFit(12)).bottomSpaceToView(view, kFit(10)).heightIs(18).widthIs(kFit(100));
    
    
    
    UILabel *bottomLabel = [UILabel new];
    bottomLabel.backgroundColor = MColor(238, 238, 238);
    [view addSubview:bottomLabel];
    bottomLabel.sd_layout.leftSpaceToView(_showImage, kFit(12)).bottomSpaceToView(view, 0).rightSpaceToView(view, kFit(12)).heightIs(0.5);
    
}


- (void)cellSelected:(BOOL)state {
    
    if (state) {
        UIImage *chooseImageH = [UIImage imageNamed:@"gxh"];//gxh
        //[tapButton setImage:buttonimage forState:(UIControlStateNormal)];
        //设置图像渲染方式
        chooseImageH = [chooseImageH imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
        [_chooseBtn setImage:chooseImageH forState:(UIControlStateNormal)];
    } else {
        UIImage *chooseImageH = [UIImage imageNamed:@"gxq"];//gxh
        //[tapButton setImage:buttonimage forState:(UIControlStateNormal)];
        //设置图像渲染方式
        chooseImageH = [chooseImageH imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
        [_chooseBtn setImage:chooseImageH forState:(UIControlStateNormal)];
    }

}


- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
-(void)setModel:(GoodsCollModel *)model{

    [self.showImage setImageViewAssignmentURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.goodsImage] image:[UIImage imageNamed:@"zly"]];
    
    CGFloat height =  [self getHeightByWidth:kFit(215-42) title: model.goodsName font:[UIFont systemFontOfSize:kFit(15)]];
    self.nameLabel.text = [NSString stringWithFormat:@"商品名称%@", model.goodsName];
    CGRect frame = self.nameLabel.frame;
    if (height > 45) {
        height = 45;
    }
    frame.size.height = height;
    self.priceLabel.text = [NSString stringWithFormat:@"商品价钱:%@", model.goodsStorePrice];

}

@end
