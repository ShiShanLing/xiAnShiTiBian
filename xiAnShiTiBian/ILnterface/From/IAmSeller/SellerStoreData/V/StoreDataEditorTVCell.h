//
//  StoreDataEditorTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/19.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StoreDataEditorTVCellDelegate <NSObject>

- (void)StortDatEditor;

@end

@interface StoreDataEditorTVCell : UITableViewCell

@property (nonatomic, assign)id<StoreDataEditorTVCellDelegate>delegate;

@end
