//
//  DownMenuCellTableViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/3.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DownMenuCell.h"

@implementation DownMenuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configCellView];
    }
    
    return self;
}


-(void)configCellView
{
    self.selectImageView.hidden=YES;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    CGRect frame = self.textLabel.frame;
    frame.origin.x += 20;
    self.textLabel.frame = frame;
    [self addSubview:self.selectImageView];
}


-(UIImageView *)selectImageView
{
    if (_selectImageView) {
        return _selectImageView;
    }
    
    UIImage *image = [UIImage imageNamed:@"ok"];
    self.selectImageView = [[UIImageView alloc]init];
    self.selectImageView.image=image;
    
    self.selectImageView.frame = CGRectMake(0,0,image.size.width,image.size.height);
    
    self.selectImageView.center = CGPointMake(kScreen_widht-40, self.frame.size.height/2);
    
    return self.selectImageView;
}

//设置字体颜色
- (void)setIsSelected:(BOOL)isSelected
{
    
    _isSelected = isSelected;
    if (isSelected) {
        self.textLabel.textColor = [UIColor redColor];
        self.backgroundColor =[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:.7];
        self.selectImageView.hidden = NO;
    }else
    {
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.selectImageView.hidden = YES;
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
}


@end
