//
//  ShopActivityTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/16.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShopActivityTVCell.h"
#import "SZCirculationImageView.h" //轮播图对象
@implementation ShopActivityTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSArray *pathArray = @[
                               @"http://i4.cqnews.net/news/attachement/jpg/site82/2016-08-23/9143505007648195979.jpg",
                               @"http://www.people.com.cn/mediafile/pic/20160830/95/17946987410935083075.jpg",
                               @"http://p.nanrenwo.net/uploads/allimg/160912/8388-160912092346-50.jpg",
                               @"http://upload.cbg.cn/2016/0728/1469695681806.jpg",
                               @"http://image.cnpp.cn/upload/images/20160905/09380421552_400x300.jpg",
                               @"http://cnews.chinadaily.com.cn/img/attachement/jpg/site1/20160729/0023ae82c931190560502f.jpg",
                               ];
        SZCirculationImageView *imageView = [[SZCirculationImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kFit(200)) andImageURLsArray:pathArray andTitles:nil];
        /*
         SZTitleViewBottomOnlyTitle,
         SZTitleViewBottomPageControlAndTitle,
         SZTitleViewBottomPageTitleAndControl,
         SZTitleViewTopOnlyTitle,
         SZTitleViewTopOnlyPageControl,
         SZTitleViewTopPageControlAndTitle,
         SZTitleViewTopPageTitleAndControl,
         */
        imageView.titleViewStatus = SZTitleViewBottomOnlyPageControl;
        imageView.pauseTime = 1.0;
        [self.contentView addSubview:imageView];

    }
    return self;
}

@end
