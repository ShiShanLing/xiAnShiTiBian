//
//  SourceInvoiceTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/19.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SourceInvoiceTVCellDelegate <NSObject>

- (void)SourceInvoiceType:(int)index;

@end

/**
 *发票来源(抬头) (个人)
 */
@interface SourceInvoiceTVCell : UITableViewCell

@property (nonatomic, strong)UITextField *TF;
@property (nonatomic, assign)id<SourceInvoiceTVCellDelegate>delegate;
@end
