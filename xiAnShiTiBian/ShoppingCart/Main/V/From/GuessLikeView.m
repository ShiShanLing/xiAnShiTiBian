//
//  GuessLikeView.m
//  meidianjie
//
//  Created by HYS on 16/2/22.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "GuessLikeView.h"


@implementation GuessLikeView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat gImageW = frame.size.width;
        CGFloat gImageH = kFit(180);
        self.goodsImage = [UIImageView new];
        self.goodsImage.image = [UIImage imageNamed:@"zly"];
        [self addSubview:self.goodsImage];
         self.goodsImage.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).autoHeightRatio(1.0);
        
        self.goodsTitleLabel = [UILabel new];
        self.goodsTitleLabel.text = @"商品名字!";
        self.goodsTitleLabel.numberOfLines = 0;
        self.goodsTitleLabel.lineBreakMode = UILineBreakModeWordWrap;
        self.goodsTitleLabel.font = MFont(kFit(13));
        [self addSubview:self.goodsTitleLabel];
        self.goodsTitleLabel.sd_layout.leftSpaceToView(self, kFit(5)).rightSpaceToView(self, kFit(5)).topSpaceToView(self.goodsImage, 5).heightIs(kFit(30));

        self.searchBtn = [UIButton new];
        self.searchBtn.font = MFont(kFit(13));
        self.searchBtn.layer.borderWidth = 1;
        self.searchBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
        self.searchBtn.layer.cornerRadius = 3;
        self.searchBtn.layer.masksToBounds = YES;
        self.searchBtn.backgroundColor = [UIColor redColor];
        [self.searchBtn setTitle:@"找相似" forState:(UIControlStateNormal)];
       // [self addSubview:self.searchBtn];
      //  self.searchBtn.sd_layout.topSpaceToView(self.goodsTitleLabel, 5).rightSpaceToView(self, 5).widthIs(kFit(50)).autoHeightRatio(0.5).bottomSpaceToView(self, 5);
        
        self.goodsPrice = [UILabel new];
        self.goodsPrice.text = @"￥:2.5";
        self.goodsPrice.font = MFont(kFit(13));
        self.goodsPrice.textColor = [UIColor redColor];
        [self addSubview:self.goodsPrice];
        self.goodsPrice.sd_layout.leftSpaceToView(self,kFit(5)).bottomSpaceToView(self, kFit(10)).heightIs(kFit(20)).widthIs(kScreen_widht/4);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(likeGoodsClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)assignment:(NSString *)url {

    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"zly"]];
   }

- (void)likeGoodsClick:(UITapGestureRecognizer *)tap{
    if ([_delegate respondsToSelector:@selector(viewClick:)]) {
        [_delegate viewClick:self];
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

@end
