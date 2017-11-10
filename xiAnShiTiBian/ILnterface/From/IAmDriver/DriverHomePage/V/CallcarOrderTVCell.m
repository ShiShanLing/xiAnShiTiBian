//
//

//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "CallcarOrderTVCell.h"

@interface CallcarOrderTVCell ()
/**
 *头像
 */
@property (nonatomic, strong)UIImageView *headPortraitImage;
/**
 *发布人名字
 */
@property (nonatomic, strong)UILabel *publishPeopleName;
/**
 *发布人电话
 */
@property (nonatomic, strong)UILabel *publishPeoplePhone;
/**
 *用车时间
 */
@property (nonatomic, strong)UILabel *useCarTime;
/**
 *起点
 */
@property (nonatomic, strong)UILabel *originLabel;
/**
 *终点
 */
@property (nonatomic, strong)UILabel *endPointLabel;;
/**
 *需要的汽车类型
 */
@property (nonatomic, strong)UILabel *CarTypeLabel;
/**
 *接单按钮
 */
@property (nonatomic, strong)UIButton *receiveOrderBtn;
/**
 *订单详情按钮
 */
@property (nonatomic, strong)UIButton *OrderDetailsBtn;
/**
 *显示已结束订单的状态 默认隐藏 当cell判断该界面为历史订单是 再把上面两个按钮隐藏掉 吧这个显示出来
 */
@property (nonatomic, strong)UILabel *OrderStateLabel;
@end

@implementation CallcarOrderTVCell {

    

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            {
        self.headPortraitImage = [UIImageView new];
        _headPortraitImage.image = [UIImage imageNamed:@"zly"];
        _headPortraitImage.layer.cornerRadius = kFit(35);
        _headPortraitImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_headPortraitImage];
        _headPortraitImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(10)).widthIs(kFit(70)).heightIs(kFit(70));
        
        self.publishPeopleName = [UILabel new];
        _publishPeopleName.text = @"你猜啊";
        _publishPeopleName.textColor =MColor(51, 51, 51);
        _publishPeopleName.font = MFont(kFit(14));
        [self.contentView addSubview:_publishPeopleName];
        _publishPeopleName.sd_layout.leftSpaceToView(_headPortraitImage, kFit(15)).topSpaceToView(self.contentView, kFit(10)).rightSpaceToView(self.contentView, kFit(12)).heightIs(kFit(14));
        
        UIButton *PhoneImage = [UIButton new];
        UIImage *image1 = [UIImage imageNamed:@"wd-wssj-wldd-dh"];
        image1 = [image1 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [PhoneImage setImage:image1 forState:(UIControlStateNormal)];
        [self.contentView addSubview:PhoneImage];
        PhoneImage.sd_layout.leftSpaceToView(_headPortraitImage, kFit(15)).topSpaceToView(_publishPeopleName, kFit(10)).widthIs(kFit(22)).heightIs(kFit(22));
        
        self.publishPeoplePhone = [UILabel new];
        _publishPeoplePhone.text = @"13673387452";
        _publishPeoplePhone.textColor = MColor(51, 51, 51);
        _publishPeoplePhone.font = MFont(kFit(14));
        [self.contentView addSubview:_publishPeoplePhone];
        _publishPeoplePhone.sd_layout.leftSpaceToView(PhoneImage, kFit(10)).topEqualToView(PhoneImage).rightSpaceToView(self.contentView, kFit(12)).heightIs(kFit(22));
        }
        UILabel * isolationLineLabelOne = [UILabel new];
        isolationLineLabelOne.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:isolationLineLabelOne];
        isolationLineLabelOne.sd_layout.leftSpaceToView(_headPortraitImage, kFit(15)).topSpaceToView(_headPortraitImage, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(0.5));
            {
        UIButton *useCarTimeImage = [UIButton new];
        UIImage *image2 = [UIImage imageNamed:@"wd-wssj-sj"];
        image2 = [image2 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [useCarTimeImage setImage:image2 forState:(UIControlStateNormal)];
        [self.contentView addSubview:useCarTimeImage];
        useCarTimeImage.sd_layout.leftSpaceToView(self.contentView, kFit(7)).topSpaceToView(isolationLineLabelOne, kFit(10)).widthIs(kFit(22)).heightIs(kFit(22));
        
        self.useCarTime = [UILabel new];
        _useCarTime.text = @"2016-01-01";
        _useCarTime.font = MFont(kFit(12));
        _useCarTime.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_useCarTime];
        _useCarTime.sd_layout.leftSpaceToView(useCarTimeImage, kFit(5)).topSpaceToView(isolationLineLabelOne, kFit(10)).rightSpaceToView(self.contentView, kFit(12)).heightIs(kFit(22));
        
        UIButton *originImage = [UIButton new];
        UIImage *image3 = [UIImage imageNamed:@"wd-wssj-mddw"];
        image3 = [image3 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [originImage setImage:image3 forState:(UIControlStateNormal)];
        [self.contentView addSubview:originImage];
        originImage.sd_layout.leftSpaceToView(self.contentView, kFit(7)).topSpaceToView(useCarTimeImage, 0).widthIs(kFit(22)).heightIs(kFit(22));
        
        self.originLabel = [UILabel new];
        _originLabel.text = @"这是订单的起点";
        _originLabel.font = MFont(kFit(12));
        _originLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_originLabel];
        _originLabel.sd_layout.leftSpaceToView(useCarTimeImage, kFit(5)).topSpaceToView(_useCarTime, 0).rightSpaceToView(self.contentView, kFit(12)).heightIs(kFit(22));
        
        UIButton *endPointImage = [UIButton new];
        UIImage *image4 = [UIImage imageNamed:@"wd-wssj-cfdw"];
        image4 = [image4 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [endPointImage setImage:image4 forState:(UIControlStateNormal)];
        [self.contentView addSubview:endPointImage];
        endPointImage.sd_layout.leftSpaceToView(self.contentView, kFit(7)).topSpaceToView(originImage, 0).widthIs(kFit(22)).heightIs(kFit(22));
        
        self.endPointLabel = [UILabel new];
        _endPointLabel.text = @"这是订单的终点";
        _endPointLabel.font = MFont(kFit(12));
        _endPointLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_endPointLabel];
        _endPointLabel.sd_layout.leftSpaceToView(endPointImage, kFit(5)).topSpaceToView(_originLabel, 0).rightSpaceToView(self.contentView, kFit(12)).heightIs(kFit(22));
        
        UIButton *CarTypeImage = [UIButton new];
        UIImage *image5 = [UIImage imageNamed:@"wd-wssj-hclx"];
        image5 = [image5 imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [CarTypeImage setImage:image5 forState:(UIControlStateNormal)];
        [self.contentView addSubview:CarTypeImage];
        CarTypeImage.sd_layout.leftSpaceToView(self.contentView, kFit(7)).topSpaceToView(endPointImage, 0).widthIs(kFit(22)).heightIs(kFit(22));
        
        self.CarTypeLabel = [UILabel new];
        _CarTypeLabel.text = @"大火车";
        _CarTypeLabel.font = MFont(kFit(12));
        _CarTypeLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_CarTypeLabel];
        _CarTypeLabel.sd_layout.leftSpaceToView(CarTypeImage, kFit(5)).topSpaceToView(_endPointLabel, 0).rightSpaceToView(self.contentView, kFit(12)).heightIs(kFit(22));
        }
        UILabel * isolationLineLabelTwo = [UILabel new];
        isolationLineLabelTwo.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:isolationLineLabelTwo];
        isolationLineLabelTwo.sd_layout.leftSpaceToView(self.contentView, kFit(12)).rightSpaceToView(self.contentView, 0).heightIs(kFit(0.5)).topSpaceToView(_CarTypeLabel, kFit(4));
            {
        //接单按钮
            self.receiveOrderBtn = [UIButton new];
            [_receiveOrderBtn setTitle:@"接单" forState:(UIControlStateNormal)];
            [_receiveOrderBtn setTitleColor:MColor(255, 80, 0) forState:(UIControlStateNormal)];
            _receiveOrderBtn.titleLabel.font = MFont(kFit(13));
            _receiveOrderBtn.layer.borderWidth = 1;
            _receiveOrderBtn.layer.borderColor = MColor(255, 80, 0).CGColor;
            _receiveOrderBtn.layer.cornerRadius = 3;
            _receiveOrderBtn.layer.masksToBounds = YES;
                [_receiveOrderBtn addTarget:self action:@selector(handleReceiveOrderBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.contentView addSubview:_receiveOrderBtn];
            _receiveOrderBtn.sd_layout.rightSpaceToView(self.contentView, kFit(12)).topSpaceToView(isolationLineLabelTwo, kFit(6)).widthIs(kFit(75)).heightIs(kFit(28));
        //订单详情
            self.OrderDetailsBtn = [UIButton new];
            [_OrderDetailsBtn setTitle:@"订单详情" forState:(UIControlStateNormal)];
            [_OrderDetailsBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
            _OrderDetailsBtn.titleLabel.textColor = MColor(51, 51, 51);
            _OrderDetailsBtn.titleLabel.font = MFont(kFit(13));
            _OrderDetailsBtn.layer.borderWidth = 1;
            _OrderDetailsBtn.layer.borderColor = MColor(51, 51, 51).CGColor;
            _OrderDetailsBtn.layer.cornerRadius = 3;
            _OrderDetailsBtn.layer.masksToBounds = YES;
                [_receiveOrderBtn addTarget:self action:@selector(handleOrderDetailsBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.contentView addSubview:_OrderDetailsBtn];
            _OrderDetailsBtn.sd_layout.rightSpaceToView(_receiveOrderBtn, kFit(10)).topSpaceToView(isolationLineLabelTwo, kFit(6)).widthIs(kFit(75)).heightIs(kFit(28));
        }
        UILabel * bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(0.5)).bottomSpaceToView(self.contentView, 0);
        
        self.OrderStateLabel = [UILabel new];
        _OrderStateLabel.text = @"已完成";
        _OrderStateLabel.textColor = kNavigation_Color;
        _OrderStateLabel.hidden = YES;
        _OrderStateLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_OrderStateLabel];
        _OrderStateLabel.sd_layout.rightSpaceToView(self.contentView, kFit(12)).topSpaceToView(isolationLineLabelTwo, kFit(6)).widthIs(kFit(75)).heightIs(kFit(28));
        
    }
    return self;

}

/**
 *接单按钮
 */
- (void)handleReceiveOrderBtn:(UIButton *)sender {

    if ([_delegate respondsToSelector:@selector(handleReceiveOrderBtn:)]) {
        [_delegate handleReceiveOrderBtn:sender];
    }
}

/**
 *订单详情
 */
- (void)handleOrderDetailsBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(handleOrderDetailsBtn:)]) {
        [_delegate handleOrderDetailsBtn:sender];
    }
}

- (void)completedOrder{
    
    _OrderDetailsBtn.hidden = YES;
    _receiveOrderBtn.hidden = YES;
    _OrderStateLabel.hidden = NO;
    
}

- (void)ButtonAssignment:(NSIndexPath *)indexPath {

    _receiveOrderBtn.tag = indexPath.row;
    _OrderDetailsBtn.tag = indexPath.row;
}

-(void)setModel:(DriverCarOrderModel *)model {

    _publishPeopleName.text = model.storeName;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: model.createTime];
    _useCarTime.text = currentDateStr;
    _originLabel.text = [NSString stringWithFormat:@"%@", model.daddress];
    _endPointLabel.text = model.address;
    _publishPeoplePhone.text = model.storeTel;
    
}

@end
