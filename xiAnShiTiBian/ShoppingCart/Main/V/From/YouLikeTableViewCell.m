//
//  YouLikeTableViewCell.m
//  meidianjie
//
//  Created by HYS on 16/2/22.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "YouLikeTableViewCell.h"

@interface YouLikeTableViewCell ()<GuessLikeViewDelegate>

@property (nonatomic, strong)NSArray *array;

@end

@implementation YouLikeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        self.likeViewL = [[GuessLikeView alloc]init];
        _likeViewL.delegate = self;
        _likeViewL.tag = 0;
        [self.contentView addSubview:self.likeViewL];
        _likeViewL.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 3).widthIs((kScreen_widht-3)/2).heightIs(kFit(259));
        
        self.likeViewR = [[GuessLikeView alloc]initWithFrame:CGRectMake(YouLikeCellW + YouLikeInset, 0, YouLikeCellW, kFit(259))];
        _likeViewR.delegate = self;
        _likeViewR.tag = 1;
        [self.contentView addSubview:self.likeViewR];
        _likeViewR.sd_layout.rightSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 3).widthIs((kScreen_widht-3)/2).heightIs(kFit(259));
    }
    return self;
}

- (void)viewClick:(GuessLikeView *)tap {

    if ([_delegate respondsToSelector:@selector(handleLikeViewClick:)]) {
        [_delegate handleLikeViewClick:tap];
    }
}

- (void)grantLikeViewAddCode:(NSIndexPath *)indexPath {
    self.likeViewL.indexPath = indexPath;
    self.likeViewR.indexPath = indexPath;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(void)setModelL:(GoodsDetailsModel *)modelL {
    [self.likeViewL.goodsImage setImageViewAssignmentURL:[NSString stringWithFormat:@"%@%@", kImage_URL, modelL.goodsImage] image:[UIImage imageNamed:@"jiazaishibai"]];
    
    self.likeViewL.goodsTitleLabel.text = modelL.goodsName;
    self.likeViewL.goodsPrice.text = [NSString stringWithFormat:@"¥:%.2f", modelL.goodsStorePrice];
}
-(void)setModelR:(GoodsDetailsModel *)modelR {

[self.likeViewR.goodsImage setImageViewAssignmentURL:[NSString stringWithFormat:@"%@%@", kImage_URL, modelR.goodsImage] image:[UIImage imageNamed:@"jiazaishibai"]];
    self.likeViewR.goodsTitleLabel.text = modelR.goodsName;
    self.likeViewR.goodsPrice.text = [NSString stringWithFormat:@"¥:%.2f", modelR.goodsStorePrice];
}
@end
