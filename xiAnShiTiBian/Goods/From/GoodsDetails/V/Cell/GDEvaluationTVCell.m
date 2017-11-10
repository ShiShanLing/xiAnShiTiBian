//
//  GDEvaluationTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/10.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "GDEvaluationTVCell.h"

@implementation GDEvaluationTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        

        NSArray *arr = [[NSArray alloc]initWithObjects:@"商品信息", @"商品评价", nil];
        //先创建一个数组用于设置标题
        
        UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:arr];
        segment.selectedSegmentIndex = 0;
        //在没有设置[segment setApportionsSegmentWidthsByContent:YES]时，每个的宽度按segment的宽度平分
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:kFit(15)],
                                                 NSForegroundColorAttributeName: [UIColor whiteColor]};
        [segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:kFit(15)],
                                                   NSForegroundColorAttributeName: MColor(134, 134, 134)};
        [segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        segment.tintColor = MColor(134, 134, 134);
        [segment addTarget:self action:@selector(handleSegment:) forControlEvents:(UIControlEventValueChanged)];
        segment.frame = CGRectMake(kFit(12), kFit(25), kScreen_widht - kFit(24), kFit(40));
        [self.contentView addSubview:segment];
    }
    return self;
}
- (void)handleSegment:(UISegmentedControl *)sender {
    if ([_delegate respondsToSelector:@selector(ChooseClick:)]) {
        [_delegate ChooseClick:sender.selectedSegmentIndex];
    }
    
    
    NSLog(@"---------%ld", (long)sender.selectedSegmentIndex);
    
}
@end
