//
//  ServiceTableViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/10.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ServiceTableViewCell.h"

@implementation ServiceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.sericeViewOne = [[SericeView alloc] initWithFrame:CGRectMake(kFit(12), 0, (kScreen_widht-kFit(70))/3, self.contentView.frame.size.height)];
        _sericeViewOne.nameLabel.text = @"不包运费";
        [self.contentView addSubview:self.sericeViewOne];
        self.sericeViewTwo =  [[SericeView alloc] initWithFrame:CGRectMake(kFit(24) + self.sericeViewOne.frame.size.width, 0, (kScreen_widht-kFit(70))/3, self.contentView.frame.size.height)];
        _sericeViewTwo.nameLabel.text = @"满3000¥免运费";
        [self.contentView addSubview:self.sericeViewTwo];

        
        self.sericeViewThree = [[SericeView alloc] initWithFrame:CGRectMake(kFit(12)+CGRectGetMaxX(self.sericeViewTwo.frame), 0, (kScreen_widht-kFit(70))/3, self.contentView.frame.size.height)];
        _sericeViewThree.nameLabel.text = @"三年保修";
        [self.contentView addSubview:self.sericeViewThree];
        
        UILabel *segmentationLabel = [UILabel new];
        segmentationLabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationLabel];
        segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, 0).heightIs(0.5);
        }
    return self;

}
@end
