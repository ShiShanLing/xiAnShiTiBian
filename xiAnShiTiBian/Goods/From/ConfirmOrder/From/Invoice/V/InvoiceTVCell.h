//
//  InvoiceTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/22.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InvoiceTVCellDelegate <NSObject>
/**
 *发票信息 不开发票或者明细 不开发票的话上面的cell都不存在
 */
- (void)Invoice:(int)index;

@end

/**
 *发票内容
 */
@interface InvoiceTVCell : UITableViewCell

@property (nonatomic, assign)id<InvoiceTVCellDelegate>delegate;

@end
