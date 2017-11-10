//
//  MapStoreShowTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/15.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MapStoreShowTVCell.h"

@interface MapStoreShowTVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeAddressLabel;
/**
 *
 */
@property (nonatomic, strong)FBCScoreStar *start;
@end

@implementation MapStoreShowTVCell {

OrderBtn *storeBtn;
}



- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)handleDidSelectBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(handleSelectBtn:)]) {
        [_delegate handleSelectBtn:sender];
    }
}
- (IBAction)handleMapNavigation:(UIButton *)sender {
    CLLocationCoordinate2D Position;
    Position.longitude = _model.storeLongitude.floatValue;
    Position.latitude = _model.storeLatitude.floatValue;
    if ([_delegate respondsToSelector:@selector(handleMapNavigationCC:)]) {
        [_delegate handleMapNavigationCC:Position];
    }
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)setModel:(MapSearchStoreModel *)model {
    _model = model;
    [self.storeImage setImageViewAssignmentURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.storeLogo] image:[UIImage imageNamed:@"jiazaishibai"]];
    self.storeNameLabel.text = [NSString stringWithFormat:@"%@", model.storeName];
    self.storeAddressLabel.text = [NSString stringWithFormat:@"地址:%@%@", model.areaInfo, model.storeAddress];
    self.start = [[FBCScoreStar alloc] initWithFrame:CGRectMake(96, 34, 60, 12)];
    _start.startColor = MColor(242, 48, 48);
    _start.score = 10;
    [self.contentView addSubview:_start];
    _start.sd_layout.leftSpaceToView(self.contentView, 94).topSpaceToView(self.contentView, 34).widthIs(60).heightIs(12);
}
@end

