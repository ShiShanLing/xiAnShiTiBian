
//
//  TypeView.m
//  AddShoppingCart
//
// Created by 石山岭 on 2016/12/14.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "TypeView.h"

@implementation TypeView {

    NSMutableArray *_BtnArray;
    UILabel *buttomLabel;
}

//-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename
- (void)setPhotoNamesArray:(NSArray *)photoNamesArray {
    
        if (!_BtnArray) {
            _BtnArray = [NSMutableArray new];
        }
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        lab.text = @"测试规格";
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:14];
        [self addSubview:lab];
        
        BOOL  isLineReturn = NO;
        float upX = 10;
        float upY = 40;
         int needsToAddItemsCount = (int)(photoNamesArray.count - _BtnArray.count);
        //  NSLog(@"%d---------------------------", needsToAddItemsCount);
        for (int i = 0; i<needsToAddItemsCount; i++) {
            NSString *str = [photoNamesArray objectAtIndex:i] ;
          
            NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
            CGSize size = [str sizeWithAttributes:dic];

            if ( upX > (self.frame.size.width-20 -size.width-35)) {
                isLineReturn = YES;
                upX = kFit(10);
                upY += kFit(38);
            }
            UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(upX, upY, size.width+30,28);
            [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn setTitle:[photoNamesArray objectAtIndex:i] forState:0];
            btn.layer.cornerRadius = 8;
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            btn.layer.borderWidth = 0;
            [btn.layer setMasksToBounds:YES];
            
            [self addSubview:btn];
            btn.tag = 101+i;
            [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
            upX+=size.width+35;
             [_BtnArray addObject:btn];
        }
        upY +=40;
        UILabel *line = [UILabel new];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        self.height = upY+11;
        self.seletIndex = -1;
        line.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, upY).heightIs(0.5);
    
        [self setupAutoHeightWithBottomView:line bottomMargin:10];
}
-(void)touchbtn:(UIButton *)btn{
    [_BtnArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.backgroundColor = MColor(245, 245, 245);
    }];
    
    btn.backgroundColor = kNavigation_Color;
    if ([_delegate respondsToSelector:@selector(btnindex:)]) {
        [_delegate btnindex:btn.tag];
    }
   
}

@end
