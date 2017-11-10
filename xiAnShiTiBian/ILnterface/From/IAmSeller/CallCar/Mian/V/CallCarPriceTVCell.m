//
//  CallCarPriceTVCell.m
//  
//
//  Created by 石山岭 on 2017/1/21.
//
//

#import "CallCarPriceTVCell.h"

@interface CallCarPriceTVCell ()
/**
 *显示叫车的价钱
 */
@property (nonatomic, strong)UILabel *priceLabel;



@end

@implementation CallCarPriceTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.priceLabel = [UILabel new];
        _priceLabel.text = @"￥180.00";
        _priceLabel.textColor = MColor(52, 51, 51);
        _priceLabel.font = MFont(kFit(14));
        _priceLabel.textAlignment = 1;
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"约￥120.00(价格)"];
        [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFit(15)] range:NSMakeRange(0, str1.length - 5)];
        [str1 addAttribute:NSForegroundColorAttributeName value:MColor(255, 51, 51) range:NSMakeRange(1,str1.length - 5)];
        _priceLabel.attributedText = str1;
        [self.contentView addSubview:_priceLabel];
        _priceLabel.sd_layout.centerXEqualToView(self.contentView).heightIs(kFit(14)).widthIs(kScreen_widht).topSpaceToView(self.contentView, kFit(15));
        
        UILabel *promptLabel = [UILabel new];
        promptLabel.font = MFont(kFit(14));
        promptLabel.textAlignment = 1;
        promptLabel.textColor = MColor(51, 51, 51);
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"*实际运费可能因实际里程等因素而议"];
        [str addAttribute:NSForegroundColorAttributeName value:MColor(255, 51, 51) range:NSMakeRange(0,1)];
        promptLabel.attributedText = str;
        [self.contentView addSubview:promptLabel];
        promptLabel.sd_layout.bottomSpaceToView(self.contentView, kFit(15)).heightIs(kFit(14)).centerXEqualToView(self.contentView).widthIs(kScreen_widht);
    }
    return self;
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

- (void)CallCarPrice:(NSString *)Price {
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"约￥%@(价格)",Price]];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFit(15)] range:NSMakeRange(0, str1.length - 5)];
    [str1 addAttribute:NSForegroundColorAttributeName value:MColor(255, 51, 51) range:NSMakeRange(1,str1.length - 5)];
    _priceLabel.attributedText = str1;

}

@end
