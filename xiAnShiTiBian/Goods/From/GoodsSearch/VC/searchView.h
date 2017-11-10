//
//  searchView.h
//  搜索页面的封装
//
//  Created by 石山岭 on 2016/12/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol searchViewDelegate <NSObject>

- (void)ReturnOnALayer;

- (void)ChangeSearchType;

@end

@interface searchView : UIView <UITextFieldDelegate>

@property (nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)UIButton *typeBtn;

@property(nonatomic, strong)UITextField *searchTF;

@property(nonatomic, strong)UIButton *cancelBtn;

@property (nonatomic, assign)id<searchViewDelegate>delegate;

@end
