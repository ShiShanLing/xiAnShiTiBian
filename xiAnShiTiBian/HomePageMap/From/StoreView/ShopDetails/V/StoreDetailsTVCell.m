//
//  StoreDetailsTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/7.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "StoreDetailsTVCell.h"

@implementation StoreDetailsTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *naeme = [UILabel new];
        naeme.font = [UIFont systemFontOfSize:14];
         naeme.textColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1];
        self.nameLabel = naeme;
        
        UILabel *content = [UILabel new];
        content.font = [UIFont systemFontOfSize:12];
        content.textColor = [UIColor colorWithRed:134/256.0 green:134/256.0 blue:134/256.0 alpha:1];
        self.contentLabel = content;
        [self.contentView sd_addSubviews:@[naeme, content]];
        self.nameLabel.sd_layout
        .widthIs(70)
        .heightIs(15)
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 20);
        
        self.contentLabel.sd_layout.leftSpaceToView(self.nameLabel, 10).topSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).autoHeightRatio(0);
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(0.5);
        
        
         [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:15];
        
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    self.contentLabel.text = text;
}
@end
