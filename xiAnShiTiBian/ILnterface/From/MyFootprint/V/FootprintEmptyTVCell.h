//
//  FootprintEmptyTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/16.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FootprintEmptyTVCellDelegate <NSObject>

- (void)handleStateBtn:(UIButton *)sender;

@end

@interface FootprintEmptyTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;

@property (nonatomic, weak)id<FootprintEmptyTVCellDelegate>delegate;

@end
