//
//  OrderShopNameTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/10.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "OrderShopNameTVCell.h"

@interface OrderShopNameTVCell ()
/**
 *店铺名字
 */
@property (nonatomic, strong)UILabel *ShopNameLabel;
/**
 *交易状态
 */
@property (nonatomic, strong)UILabel *OrderStatus;
/**
 *箭头btn
 */
@property (nonatomic, strong)UIButton *arrowBtn;
@end

@implementation OrderShopNameTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *shopImage = [UIImageView new];
        shopImage.image = [UIImage imageNamed:@"dp"];
        [self.contentView addSubview:shopImage];
        shopImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).centerYEqualToView(self.contentView).widthIs(kFit(21)).heightIs(kFit(21));

        CGFloat width = [self getWidthWithTitle:@"不要迷恋哥.哥只是个传说" font:[UIFont systemFontOfSize:kFit(14)]];
        NSLog(@"计算label宽度%f", width);
        self.ShopNameLabel = [UILabel new];
        _ShopNameLabel.font = MFont(kFit(14));
        _ShopNameLabel.text = @"不要迷恋哥.哥只是个传说";
        _ShopNameLabel.textColor = MColor(0, 0, 0);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShopNameClick:)];
        [_ShopNameLabel addGestureRecognizer:tap];
        [self.contentView addSubview:_ShopNameLabel];
        _ShopNameLabel.sd_layout.leftSpaceToView(shopImage, kFit(15)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(width);
        
        self.arrowBtn = [UIButton new];
        UIImage *arrowImage = [UIImage imageNamed:@"jt"];
        arrowImage = [arrowImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_arrowBtn setImage:arrowImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:_arrowBtn];
        _arrowBtn.sd_layout.leftSpaceToView(_ShopNameLabel, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(27.5);
        
        self.OrderStatus = [UILabel new];
        _OrderStatus.textColor = MColor(255, 80, 0);
        _OrderStatus.font = MFont(14);
        _OrderStatus.text = @"交易成功";
        _OrderStatus.textAlignment =2;
        [self.contentView addSubview:_OrderStatus];
        _OrderStatus.sd_layout.rightSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(kFit(100));
    }
    return self;
}
//给cell内部控件赋值
- (void)OrderState:(int)state indexPath:(NSIndexPath *)indexPath{
    
   
    _ShopNameLabel.tag = indexPath.section;
   
    
}

- (void)setModel:(BuyersOrderListModel *)model {
    CGFloat width = [self getWidthWithTitle:model.storeName font:[UIFont systemFontOfSize:kFit(14)]];
    //NSLog(@"计算label宽度%f model.stateOrder%@", width, model.orderState);

    _ShopNameLabel.text = model.storeName;
    _ShopNameLabel.sd_layout.widthIs(width);
    
    int orderState = (int)[model.orderState intValue];
    switch (orderState) {
        case 0://待定运费
            _OrderStatus.text = @"订单已取消";
            break;
        case 5://待定运费
            _OrderStatus.text = @"待计算运费";
            break;
        case 10://带付款
            _OrderStatus.text = @"待买家付款";
            break;
        case 20://待发货
            _OrderStatus.text = @"待商家发货";
            break;
        case 25://待发货
            _OrderStatus.text = @"待商家发货";
            break;
        case 26://待发货
            _OrderStatus.text = @"待商家发货";
            break;
        case 28://待收货
            _OrderStatus.text = @"待买家收货";
            break;
        case 30://待收货
            _OrderStatus.text = @"待买家收货";
            break;
        case 40://待评价
            _OrderStatus.text = @"待评价";
            break;
        case 50://待评价
            _OrderStatus.text = @"待评价";
            break;
        case 60://待评价
            _OrderStatus.text = @"待评价";
            break;
            
        default:
            break;
    }
        
}

//label 宽度自使用
- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
//商店名字点击事件
- (void)ShopNameClick:(UITapGestureRecognizer *)tap {

    if ([_delegate respondsToSelector:@selector(ShopChoose:)]) {
        [_delegate ShopChoose:tap.self.view.tag];
    }
}

@end
