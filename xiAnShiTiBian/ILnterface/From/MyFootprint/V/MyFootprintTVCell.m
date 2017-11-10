//
//  MyFootprintTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/16.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MyFootprintTVCell.h"
@interface MyFootprintTVCell ()

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
 *编辑
 */
@property (nonatomic, strong)UIButton *morehsBtn;
/**
 *找相似
 */
@property (nonatomic, strong)UIButton *similarBtn;
@end

@implementation MyFootprintTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setCreatingControls];
    }
    return self;
}

- (void)setCreatingControls {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kFit(123))];
    [self.contentView addSubview:view];
    
    self.showImage = [UIImageView new];
    self.showImage.image = [UIImage imageNamed:@"zly"];
    self.showImage.layer.cornerRadius = 3;
    self.showImage.layer.masksToBounds = YES;
    
    [view addSubview:self.showImage];
    self.showImage.sd_layout.leftSpaceToView(view, 0).topSpaceToView(view, 0).bottomSpaceToView(view, 0).widthIs(kFit(123)).autoHeightRatio(1);
    
    self.nameLabel = [UILabel new];
    self.nameLabel.text =@"绝版红尘第三方木哈速度发生开发那空间是南方喀沙大概三个水电费";
    CGFloat Height =  [self getHeightByWidth:kFit(215) title:@"绝版红尘第三方木哈速度发生开发那空间是南方喀沙大概三个水电费" font:[UIFont systemFontOfSize:kFit(15)]];
    
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.font = [UIFont systemFontOfSize:kFit(15)];
    self.nameLabel.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
    [view addSubview:self.nameLabel];
    self.nameLabel.sd_layout.leftSpaceToView(self.showImage, kFit(12)).topSpaceToView(view, kFit(5)).heightIs(Height).rightSpaceToView(view, 15);
    
    self.priceLabel = [UILabel new];
    self.priceLabel.text = @"￥ 599.00";
    self.priceLabel.font = MFont(kFit(12));
    self.priceLabel.textColor = [UIColor colorWithRed:255/256.0 green:50/256.0 blue:50/256.0 alpha:1];
    [view addSubview:self.priceLabel];
    self.priceLabel.sd_layout.leftSpaceToView(self.showImage, kFit(12)).bottomSpaceToView(view, 20).heightIs(18).widthIs(kFit(100));
    
    self.similarBtn = [UIButton new];
    [_similarBtn setTitle:@"找相似" forState:(UIControlStateNormal)];
    [_similarBtn setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
    _similarBtn.titleLabel.font = MFont(kFit(12));
    _similarBtn.layer.cornerRadius = 3;
    _similarBtn.layer.masksToBounds = YES;
    _similarBtn.layer.borderWidth = 0.5;
    _similarBtn.layer.borderColor = [kNavigation_Color CGColor];
    [_similarBtn addTarget:self action:@selector(handleSimilarBtn:) forControlEvents:(UIControlEventTouchUpInside)];
   // [view addSubview:_similarBtn];
   // _similarBtn.sd_layout.rightSpaceToView (view, kFit(12)).bottomSpaceToView(view, kFit(7)).widthIs(kFit(50)).heightIs(kFit(25));
    
    UILabel *bottomLabel = [UILabel new];
    bottomLabel.backgroundColor = MColor(238, 238, 238);
    [view addSubview:bottomLabel];
    bottomLabel.sd_layout.leftSpaceToView(_showImage, kFit(12)).bottomSpaceToView(view, 0).rightSpaceToView(view, kFit(12)).heightIs(0.5);
    
}
//给按钮赋值
- (void)EditButtonTagAssignment:(NSIndexPath *)indexPaht {
    
    _morehsBtn.tag = indexPaht.row;
    _similarBtn.tag = indexPaht.row *100;
}
//计算label高度
- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
//编辑
- (void)handleMorehsBtn:(UIButton *)sender {
    
}
//找相似
- (void)handleSimilarBtn:(UIButton *)sender {
   
    
}
-(void)setModel:(GoodsDetailsModel *)model {
    NSLog(@"model.goodsImage%@", model);
    [self.showImage setImageViewAssignmentURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.goodsImage] image:[UIImage imageNamed:@"zly"]];
    self.nameLabel.text = [NSString stringWithFormat:@"商品名称:%@", model.goodsName];
    self.priceLabel.text =[NSString stringWithFormat:@"商品价格:%.2f¥", model.goodsStorePrice];

}




@end
