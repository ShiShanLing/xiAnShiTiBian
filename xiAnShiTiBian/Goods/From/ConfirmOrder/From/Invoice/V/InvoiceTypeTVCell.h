//
//  InvoiceTypeTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/19.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InvoiceTypeTVCellDelegate <NSObject>

- (void)InvoiceType:(int)index;

@end

/**
 *选择发票类型  不开发票 纸质发票  电子发票  
 */
@interface InvoiceTypeTVCell : UITableViewCell


@property (nonatomic , assign)id<InvoiceTypeTVCellDelegate>delegate;

@end
