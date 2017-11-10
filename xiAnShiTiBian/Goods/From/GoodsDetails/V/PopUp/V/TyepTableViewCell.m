//
//  TyepTableViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/14.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "TyepTableViewCell.h"
#import "TypeView.h"
@interface TyepTableViewCell()<TypeSeleteDelegete>

/**
 *存储规格值
 */
@property (nonatomic, strong)NSMutableArray *tyepMArray;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation TyepTableViewCell {

    NSMutableArray *_BtnArray;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 15)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = MColor(51, 51, 51);
        _titleLabel.text = @"测试标题";
        [self.contentView addSubview:self.titleLabel];
        
        
        UILabel *line = [UILabel new];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        line.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(0.5);
    }
    return self;
}

- (void)PhotoNamesDic:(NSDictionary *)dic title:(NSString *)title indexPath:(NSIndexPath *)indexPath{
    _titleLabel.text = title;
    
    NSArray *keyArray = [dic allKeys];
    
    if (!_BtnArray) {
        _BtnArray = [NSMutableArray new];
    }
    BOOL  isLineReturn = NO;
    float upX = 10;
    float upY = 40;
    int needsToAddItemsCount = (int)(keyArray.count - _BtnArray.count);
    //  NSLog(@"%d---------------------------", needsToAddItemsCount);
    for (int i = 0; i<needsToAddItemsCount; i++) {
        NSString *Key1 = [keyArray objectAtIndex:i] ;
        NSString *value = dic[Key1];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
        CGSize size = [value sizeWithAttributes:dic];
        
        if (upX > (self.frame.size.width-20 -size.width-35)) {
            isLineReturn = YES;
            upX = kFit(10);
            upY += kFit(38);
        }
        OrderBtn *btn= [OrderBtn buttonWithType:UIButtonTypeCustom];
        btn.tyepID = Key1;
        btn.tyepName = value;
        btn.frame = CGRectMake(upX, upY, size.width+30,28);
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:value forState:0];
        btn.layer.cornerRadius = 8;
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        btn.layer.borderWidth = 0;
        [btn.layer setMasksToBounds:YES];
        [self addSubview:btn];
        btn.tag = (indexPath.row +1) * 100+i;
        [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
        upX+=size.width+35;
        [_BtnArray addObject:btn];
    }
    upY +=40;
}
-(void)touchbtn:(OrderBtn *)btn{
    [_BtnArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.backgroundColor = MColor(245, 245, 245);
    }];
    
    btn.backgroundColor = kNavigation_Color;
    if ([_delegate respondsToSelector:@selector(typeSubscript:)]) {
        [_delegate typeSubscript:btn];
    }
    
}
@end
