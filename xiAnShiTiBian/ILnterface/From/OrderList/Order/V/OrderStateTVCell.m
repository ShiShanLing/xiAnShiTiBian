//
//  OrderStateTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/11.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "OrderStateTVCell.h"

@interface OrderStateTVCell ()
/**
 *服务保障 价钱
 */
@property (nonatomic, strong)UILabel *safeguardLabel;
/**
 *服务保障数量
 */
@property (nonatomic, strong)UILabel *safeguardNumLabel;
/**
 *介绍 (商品多少件 一共多少钱)获得多少积分
 */
@property (nonatomic, strong)UILabel *introduceLabel;
/**
 *通用的按钮1  common 因为名字是可变的 所以命名随意了  按钮比较复杂 请点击进入按钮内部查看   tag值代表第几个按钮 201代表点击的是第N个cell上的最后一个按钮 依次类推
 */
@property (nonatomic, strong)OrderBtn *commonBtnOne;
/**
 *通用的按钮1  common
 */
@property (nonatomic, strong)OrderBtn *commonBtnTwo;
/**
 *通用的按钮1  common
 */
@property (nonatomic, strong)OrderBtn *commonBtnThree;

@property (nonatomic, strong)UILabel *OrderTimeLabel;

@end

@implementation OrderStateTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *topView = [UIView new];
        topView.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:topView];
        topView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(50);

        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"运费:";
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.font = MFont(kFit(13));
        [topView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(topView, kFit(12)).topSpaceToView(topView, kFit(5)).widthIs(kFit(100)).heightIs(kFit(13));
        
        self.safeguardLabel = [UILabel new];
        _safeguardLabel.textColor = MColor(0, 0, 0);
        _safeguardLabel.text = @"￥18.50";
        _safeguardLabel.textAlignment = 2;
        _safeguardLabel.font = MFont(kFit(11));
        [topView addSubview:_safeguardLabel];
        _safeguardLabel.sd_layout.rightSpaceToView(topView, kFit(12)).topEqualToView(titleLabel).widthIs(kFit(100)).heightIs(kFit(11));
        
        self.safeguardNumLabel = [UILabel new];
        _safeguardNumLabel.text = @"X 1";
        _safeguardNumLabel.textAlignment = 2;
        _safeguardNumLabel.textColor = MColor(134, 134, 134);
        _safeguardNumLabel.font = MFont(kFit(11));
        [topView addSubview:_safeguardNumLabel];
        _safeguardNumLabel.sd_layout.rightSpaceToView(topView, kFit(12)).topSpaceToView(_safeguardLabel, kFit(11)).widthIs(kFit(100)).heightIs(kFit(11));
        
        self.OrderTimeLabel = [UILabel new];
        _OrderTimeLabel.text = @"2016-3-13";
        _OrderTimeLabel.textColor = MColor(51, 51, 51);
        _OrderTimeLabel.font = MFont(kFit(13));
        [topView addSubview:_OrderTimeLabel];
        _OrderTimeLabel.sd_layout.leftSpaceToView(topView, kFit(12)).topSpaceToView(_safeguardLabel, kFit(11)).rightSpaceToView(_safeguardNumLabel, 10).heightIs(kFit(13));
        
        UIView *middleView = [UIView new];
        middleView.backgroundColor = MColor(255, 255, 255);
        [self.contentView addSubview:middleView];
        middleView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(topView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(40));
        
        self.introduceLabel = [UILabel new];
        _introduceLabel.text = @"共5件商品 合计:￥300.5(不含运费) 获得600积分";
        _introduceLabel.textAlignment = 2;
        _introduceLabel.textColor = MColor(51, 51, 51);
        _introduceLabel.font = MFont(kFit(13));
        [middleView addSubview:_introduceLabel];
        _introduceLabel.sd_layout.rightSpaceToView(middleView, kFit(12)).centerYEqualToView(middleView).leftSpaceToView(middleView, kFit(12)).heightIs(kFit(20));
        
        UILabel *middleLabel = [UILabel new];
        middleLabel.backgroundColor = MColor(238, 238, 238);
        [middleView addSubview:middleLabel];
        middleLabel.sd_layout.leftSpaceToView(middleView, kFit(0)).bottomSpaceToView(middleView, 0).rightSpaceToView(middleView, kFit(0)).heightIs(kFit(0.5));
        
        
        UIView *underView = [UIView new];
        underView.backgroundColor = MColor(255, 255, 255);
        [self.contentView addSubview:underView];
        underView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(middleView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(40));

        self.commonBtnOne = [OrderBtn new];
        _commonBtnOne.tag = 201;
        [_commonBtnOne setTitle:@"付款" forState:(UIControlStateNormal)];
        _commonBtnOne.layer.cornerRadius = 3;
        _commonBtnOne.layer.masksToBounds = YES;
        _commonBtnOne.layer.borderWidth = 0.5;
        _commonBtnOne.layer.borderColor = [kNavigation_Color CGColor];
        _commonBtnOne.titleLabel.font = MFont(kFit(13));
        [_commonBtnOne setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
        [_commonBtnOne addTarget:self action:@selector(handleCommonBtnOne:) forControlEvents:(UIControlEventTouchUpInside)];
        [underView addSubview:_commonBtnOne];
        _commonBtnOne.sd_layout.rightSpaceToView(underView, kFit(12)).centerYEqualToView(underView).widthIs(kFit(75)).heightIs(kFit(27.5));
        
        self.commonBtnTwo = [OrderBtn new];
        _commonBtnTwo.tag = 202;
        [_commonBtnTwo setTitle:@"取消订单" forState:(UIControlStateNormal)];
        _commonBtnTwo.layer.cornerRadius = 3;
        _commonBtnTwo.layer.masksToBounds = YES;
        _commonBtnTwo.layer.borderWidth = 0.5;
        _commonBtnTwo.layer.borderColor = [MColor(51, 51, 51) CGColor];
        _commonBtnTwo.titleLabel.font = MFont(kFit(13));
        [_commonBtnTwo setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        [_commonBtnTwo addTarget:self action:@selector(handleCommonBtnTwo:) forControlEvents:(UIControlEventTouchUpInside)];
        [underView addSubview:_commonBtnTwo];
        _commonBtnTwo.sd_layout.rightSpaceToView(_commonBtnOne, kFit(9)).centerYEqualToView(underView).widthIs(kFit(75)).heightIs(kFit(27.5));
        
        self.commonBtnThree = [OrderBtn new];
        [_commonBtnThree setTitle:@"朋友代付" forState:(UIControlStateNormal)];
        _commonBtnThree.layer.cornerRadius = 3;
        _commonBtnThree.layer.masksToBounds = YES;
        _commonBtnThree.layer.borderWidth = 0.5;
        _commonBtnThree.titleLabel.font = MFont(kFit(13));
        _commonBtnThree.layer.borderColor = [MColor(51, 51, 51) CGColor];
        [_commonBtnThree setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        [_commonBtnThree addTarget:self action:@selector(handleCommonBtnThree:) forControlEvents:(UIControlEventTouchUpInside)];
        [underView addSubview:_commonBtnThree];
        _commonBtnThree.sd_layout.rightSpaceToView(_commonBtnTwo, kFit(9)).centerYEqualToView(underView).widthIs(kFit(75)).heightIs(kFit(27.5));
        
        
        
        
    }
    return self;

}
//倒数第一个按钮
- (void)handleCommonBtnOne:(OrderBtn *)sender {
    if ([_delegate respondsToSelector:@selector(OrderCommonBtnOne:)]) {
        [_delegate OrderCommonBtnOne:sender];
    }
}
//倒数第二个按钮
- (void)handleCommonBtnTwo:(OrderBtn *)sender {
    if ([_delegate respondsToSelector:@selector(OrderCommonBtnTwo:)]) {
        [_delegate OrderCommonBtnTwo:sender];
    }
}
//倒数第三个按钮
- (void)handleCommonBtnThree:(UIButton *)sender {
    
}

- (void)OrderStateBtn:(BuyersOrderListModel *)model indexPath:(NSIndexPath *)indexPath{
    /*
     1 未付款
     按钮 -> 取消订单  付款
     2已付款 (未发货)
     按钮 -> 退款 提醒发货
     3已付款 (已发货)
     按钮 -> 确认收货
     4 交易完成
     按钮 -> 待评价 删除订单
     5 交易取消(取消未支付的订单)
     
     删除订单
     */
    switch (model.orderState.integerValue) {
        case 0:
            [self HasBeenCancelled:indexPath];
            break;
        case 5:
            [self WaitingMerchantsFreight:indexPath];
            break;
        case 10:
            [self WaitingPayment:indexPath];
            break;
        case 20 :
            [self WaitingShipments:indexPath];
            break;
        case 25 :
            [self WaitingShipments:indexPath];
            break;
        case 26:
            [self WaitingShipments:indexPath];
            break;
        case 28:
            [self WaitingReceipt:indexPath];
            break;
        case 30:
            [self WaitingReceipt:indexPath];
            break;
        case 40:
            [self WaitingEvaluation:indexPath];
            break;
        default:
            break;
    }
}
//已经取消的
- (void)HasBeenCancelled:(NSIndexPath *)indexPath {
    [_commonBtnOne setTitle:@"订单已取消" forState:(UIControlStateNormal)];
    _commonBtnOne.OrderType = 100;
    _commonBtnTwo.hidden = YES;
    _commonBtnThree.hidden = YES;

}
//待商家确认运费
- (void)WaitingMerchantsFreight:(NSIndexPath *)indexPath {
    
    _commonBtnOne.OrderType = 0;
    _commonBtnOne.indexPath = indexPath;
    [_commonBtnOne setTitle:@"取消订单" forState:(UIControlStateNormal)];
    _commonBtnTwo.hidden = YES;
    _commonBtnThree.hidden = YES;

    
}
//代付款
- (void)WaitingPayment:(NSIndexPath *)indexPath{
    _commonBtnOne.OrderType = 1;
    _commonBtnOne.indexPath = indexPath;
    _commonBtnTwo.OrderType = 1;
    _commonBtnTwo.indexPath = indexPath;
    [_commonBtnOne setTitle:@"付款" forState:(UIControlStateNormal)];
    [_commonBtnTwo setTitle:@"取消订单" forState:(UIControlStateNormal)];
    _commonBtnThree.hidden = YES;
    _commonBtnTwo.hidden = NO;
}
//待发货
- (void)WaitingShipments:(NSIndexPath *)indexPath{
    _commonBtnOne.OrderType = 2;
    _commonBtnOne.indexPath = indexPath;
    _commonBtnTwo.OrderType = 2;
    _commonBtnTwo.indexPath = indexPath;
    [_commonBtnOne setTitle:@"待发货" forState:(UIControlStateNormal)];
    [_commonBtnTwo setTitle:@"退款" forState:(UIControlStateNormal)];
    _commonBtnTwo.hidden = NO;
    _commonBtnThree.hidden = YES;
}
//待收货
- (void)WaitingReceipt:(NSIndexPath *)indexPath{
    _commonBtnOne.OrderType = 3;
    _commonBtnOne.indexPath = indexPath;
    [_commonBtnOne setTitle:@"确认收货" forState:(UIControlStateNormal)];
    _commonBtnTwo.hidden = YES;
    _commonBtnThree.hidden = YES;
}
//待评价
- (void)WaitingEvaluation:(NSIndexPath *)indexPath{
    _commonBtnOne.OrderType = 4;
    _commonBtnOne.indexPath = indexPath;
    _commonBtnTwo.OrderType = 4;
    _commonBtnTwo.indexPath = indexPath;
    [_commonBtnOne setTitle:@"评价" forState:(UIControlStateNormal)];
    [_commonBtnTwo setTitle:@"删除订单" forState:(UIControlStateNormal)];
    _commonBtnTwo.hidden = YES;
    _commonBtnThree.hidden = YES;
    
}
//已评价
- (void)AlreadyEvaluation:(NSIndexPath *)indexPath{
    _commonBtnOne.OrderType = 5;
    _commonBtnOne.indexPath = indexPath;
    _commonBtnOne.layer.borderColor = [MColor(51, 51, 51) CGColor];
    [_commonBtnOne setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
    _commonBtnTwo.hidden = YES;
    _commonBtnThree.hidden = YES;
}

-(void)setModel:(BuyersOrderListModel *)model {
    
   // NSLog(@"BuyersOrderListModel%@",model);
    _safeguardLabel.text = [NSString stringWithFormat:@"¥:%@", model.shippingFee];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: model.addTime];
    _OrderTimeLabel.text = currentDateStr;
    
    
    _introduceLabel.text = [NSString stringWithFormat:@"合计:￥%.2f(含运费)", model.orderAmount.floatValue];
    
    
}

@end
