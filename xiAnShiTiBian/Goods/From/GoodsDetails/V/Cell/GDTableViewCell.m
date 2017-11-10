//
//  GDTableViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/9.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "GDTableViewCell.h"

#define kWinht (kScreen_widht - kFit(12) * 4) / 3

@interface GDTableViewCell ()

@property (nonatomic, strong)SZCirculationImageView *SZCIV;


@end

@implementation GDTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.blankLabel = [UIView new];
        
        [self.contentView addSubview:_blankLabel];
        _blankLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(305));
        
       
        self.goodsName = [UILabel new];
        self.goodsName.text = @"商品名字!";
        self.goodsName.font = MFont(kFit(13));
        [self.contentView addSubview:self.goodsName];
        self.goodsName.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(_blankLabel, kFit(17)).heightIs(kFit(17)).rightSpaceToView(self.contentView, kFit(12));
        
        self.goodsOPrice = [UILabel new];
        self.goodsOPrice.textColor = [UIColor redColor];
        self.goodsOPrice.font = MFont(kFit(17));
        self.goodsOPrice.text = @"￥:35000";
        [self.contentView addSubview:self.goodsOPrice];
        self.goodsOPrice.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.goodsName, kFit(15)).heightIs(kFit(17)).widthIs(self.frame.size.width/3);
        
        self.goodsPPrice = [UILabel new];
        self.goodsPPrice.textColor = [UIColor lightGrayColor];
        
        NSAttributedString *attrStr =
        [[NSAttributedString alloc]initWithString:@"￥:45000"
                                       attributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:14.f],
           NSForegroundColorAttributeName:MColor(161, 161, 161),
           NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
           NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
        
        self.goodsPPrice.attributedText = attrStr;
        [self.contentView addSubview:self.goodsPPrice];
        self.goodsPPrice.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.goodsOPrice, kFit(10)).heightIs(kFit(14)).widthIs(self.frame.size.width/3);
        
        self.GoodsAwardPoints = [UILabel new];
        self.GoodsAwardPoints.textColor = [UIColor lightGrayColor];
        self.GoodsAwardPoints.text = @"购买送3000积分";
        self.GoodsAwardPoints.font = MFont(kFit(14));
        
        [self.contentView addSubview:self.GoodsAwardPoints];
        self.GoodsAwardPoints.sd_layout.leftSpaceToView(self.goodsPPrice, kFit(12)).topSpaceToView(self.goodsOPrice, kFit(10)).heightIs(kFit(14)).widthIs(self.frame.size.width/3);
        
        self.GoodsPeopleBuy = [UILabel new];
        self.GoodsPeopleBuy.textColor = [UIColor lightGrayColor];
        self.GoodsPeopleBuy.text = @"20人购买";
        self.GoodsPeopleBuy.textAlignment = 2;
        self.GoodsPeopleBuy.font = MFont(kFit(14));
        [self.contentView addSubview:self.GoodsPeopleBuy];
        self.GoodsPeopleBuy.sd_layout.leftSpaceToView(self.GoodsAwardPoints, kFit(12)).topSpaceToView(self.goodsOPrice, kFit(10)).heightIs(kFit(14)).widthIs(self.frame.size.width/3);

        UILabel *segmentationLabel = [[UILabel alloc] init];
        segmentationLabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationLabel];
        segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, 0).heightIs(0.5);
    }
    return self;
}
- (void)GoodsImageAssignment:(GoodsDetailsModel *)model {
    
    NSLog(@"GoodsImageAssignment%@",model);
    
    NSArray *pathArray = (NSArray *)model.goodsImageMore;
    self.SZCIV = [[SZCirculationImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kFit(305)) andImageURLsArray:pathArray andTitles:nil];
    _SZCIV.titleViewStatus = SZTitleViewTopOnlyTitle;
    _SZCIV.pauseTime = 2.0;
    [self.blankLabel addSubview:_SZCIV];

    _goodsName.text = model.goodsName;
    _goodsOPrice.text = [NSString stringWithFormat:@"¥:%.2f", model.goodsStorePrice];
    _goodsPPrice.attributedText = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥:%.2f", model.goodsMarketPrice]
                                                                 attributes:
                                    @{NSFontAttributeName:[UIFont systemFontOfSize:14.f],
                                     NSForegroundColorAttributeName:MColor(161, 161, 161),
                                     NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                     NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    if (model.giftPoints == 0) {
        _GoodsAwardPoints.text = @"";
    }else {
        _GoodsAwardPoints.text = [NSString stringWithFormat:@"购买送%hd积分", model.giftPoints];
    }
    
    _GoodsPeopleBuy.text = [NSString stringWithFormat:@"%hd人购买", model.salenum];
}

@end
