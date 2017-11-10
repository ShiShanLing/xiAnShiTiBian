//
//  MapSearchView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MapSearchViewDelegate <NSObject>

- (void)ReturnOnALayer;

-(void)MapSearchType:(int)tag;

@end

@interface MapSearchView : UIView


@property(nonatomic, strong)UITextField *searchTF;

@property(nonatomic, strong)UIButton *cancelBtn;

@property(nonatomic, assign)id<MapSearchViewDelegate>delegate;

@end
