//
//  MapStoreTableView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/15.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MapStoreTableView.h"

#define kSelfTopSpacing 118
#define kHamburgHighly 39
@implementation MapStoreTableView

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 拿到UITouch就能获取当前点
    UITouch *touch = [touches anyObject];
    // 获取当前点
    CGPoint curP = [touch locationInView:self];
    // 获取上一个点
    CGPoint preP = [touch previousLocationInView:self];
    // 获取手指x轴偏移量
    CGFloat offsetX = curP.x - preP.x;
    // 获取手指y轴偏移量
    CGFloat offsetY = curP.y - preP.y;
    // 移动当前view
    if (self.frame.origin.y<kSelfTopSpacing && offsetY<0) {
        
    }else if (self.frame.origin.y>kScreen_heigth-kHamburgHighly - 49 && offsetY>0) {
        
    }else{
        
        if (self.frame.origin.y <=kSelfTopSpacing  && offsetY<0) {
            
        }else {
            self.transform = CGAffineTransformTranslate(self.transform, 0, offsetY);
        }
    }
    if (self.frame.origin.y <= kSelfTopSpacing  && offsetY < 0) {
        NSNotification * notice = [NSNotification notificationWithName:@"allowSliding" object:nil userInfo:@{@"1":@"开启"}];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        
    }else if (self.frame.origin.y <= kSelfTopSpacing  && offsetY > 0) {
        NSNotification * notice = [NSNotification notificationWithName:@"BanSliding" object:nil userInfo:@{@"1":@"关闭"}];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        
    }
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 拿到UITouch就能获取当前点
    UITouch *touch = [touches anyObject];
    // 获取当前点
    CGPoint curP = [touch locationInView:self];
    // 获取上一个点
    CGPoint preP = [touch previousLocationInView:self];
    // 获取手指x轴偏移量
    CGFloat offsetX = curP.x - preP.x;
    // 获取手指y轴偏移量
    CGFloat offsetY = curP.y - preP.y;

    CGFloat Y = self.frame.origin.y;
  //  NSLog(@"self.frame.origin.y%f  offsetY%f",self.frame.origin.y, offsetY);
    CGRect frame = self.frame;
    
    if (offsetY < 0) { //如果是上啦
        if (Y <= kSelfTopSpacing) {
            frame.origin.y = kSelfTopSpacing;
           
        }else if(Y > kFit(400)) {
            frame.origin.y = kScreen_heigth - kHamburgHighly - 49;
        }else if (Y > kFit(200) && Y < kFit(500)) {
            frame.origin.y = kFit(267);
        }else if(Y < 200){

            frame.origin.y = kSelfTopSpacing;
        }
    }else {//下拉
        if (Y < kSelfTopSpacing) {
            frame.origin.y = kSelfTopSpacing;
        }else if(Y > kFit(350)) {
            frame.origin.y = kScreen_heigth - kHamburgHighly -49;
        }else if (Y > kFit(113) && Y < kFit(400)) {
            frame.origin.y = 267;
        }
    }
    if (frame.origin.y == kSelfTopSpacing) {
        NSNotification * notice = [NSNotification notificationWithName:@"WhetherInTopNC" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    }else {
        NSNotification * notice = [NSNotification notificationWithName:@"leaveTopNC" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    }
    __block MapStoreTableView *TV = self;
    [UIView animateWithDuration:0.5 animations:^{
        TV.frame = frame;
    }];
    
}
@end
