//
//  NoInternetTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/7/31.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "NoInternetTVCell.h"

@implementation NoInternetTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)handleRefreshView:(id)sender {
    
}

- (void)layoutSubviews {

    self.RefreshViewBtn.layer.cornerRadius = 3;
    self.RefreshViewBtn.layer.masksToBounds = YES;
    self.RefreshViewBtn.layer.borderWidth = 1;
    self.RefreshViewBtn.layer.borderColor = MColor(134, 134, 134).CGColor;
    

}
@end
