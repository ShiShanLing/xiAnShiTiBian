//
//  MapPopUpPaopaoView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/29.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MapPopUpPaopaoView.h"

@interface MapPopUpPaopaoView ()

@property (weak, nonatomic) IBOutlet UIButton *navigationImage;
@property (weak, nonatomic) IBOutlet UIButton *navigationBtn;
@property (weak, nonatomic) IBOutlet UIButton *enterImage;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (weak, nonatomic) IBOutlet UIView *navigtionView;
@property (weak, nonatomic) IBOutlet UIView *enterStoreView;

@end

@implementation MapPopUpPaopaoView


-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    [super hitTest:point withEvent:event];
    NSLog(@"hitTest=======================");
    //     当touch point是在_btn上，则hitTest返回_btn
    //1.获取这个点击位置转换按钮上的位置
    CGPoint btnPointInA = [self.navigationBtn convertPoint:point fromView:self.navigtionView];
    //2.判断这个转换后的位置是不是在这个按钮里  在这个按钮里返回这个按钮事件 hitTest和pointInside一般成对出现  hitTest方法由于会递归调用，有多少个子View调用多少次，所以这个方法里尽量不要写太复杂逻辑，以免处理不当效率低
    if ([self.navigationBtn pointInside:btnPointInA withEvent:event])
    {
        return  self.navigationBtn;
    }
    //     否则，返回默认处理
    return [super hitTest:point withEvent:event];
    
}

- (IBAction)handleNavigation:(UIButton *)sender {
    
    NSLog(@"handleNavigation%@", self.storeID);
    
    if ([_delegate respondsToSelector:@selector(navigationTap:)]) {
        [_delegate navigationTap:self];
    }
}
- (IBAction)handleEnterStoreTap:(UIButton *)sender {
    NSLog(@"handleEnterStoreTap%@", self.storeID);
    if ([_delegate respondsToSelector:@selector(enterstoreTap:)]) {
                [_delegate enterstoreTap:self];
            }

    
}


- (void)textView:(NSString *)str {
    
    self.storeID = str;
}


@end
