//
//  SellerSATVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *发货地址的编辑事件
 */
@protocol SellerSATVCellDelegate <NSObject>
/**
 *删除发货地址
 */
- (void)ShoppingAddDeleteBtn:(OrderBtn *)sender;
/**
 *编辑发货地址
 */
- (void)ShoppingAddEditorBtn:(OrderBtn *)sender;
/**
 *修改默认发货地址
 */
- (void)ModifyDefaultShippingAddress:(OrderBtn *)sender;
@end

/**
 *商家发货地址cell
 */
@interface SellerSATVCell : UITableViewCell

@property (nonatomic, assign)id<SellerSATVCellDelegate>delegate;
/**
 *收货人
 */
@property (nonatomic, strong)UILabel *consigneeLabel;
/**
 *收货人手机号
 */
@property (nonatomic, strong)UILabel *telephoneLabel;
/**
 *收货地址
 */
@property (nonatomic, strong)UILabel *addressLabel;
/**
 *详情地址
 */
@property (nonatomic, strong)UILabel *detailsLabel;
/**
 *选择默认地址btn
 */
@property (nonatomic, strong)OrderBtn *chooseBtn;
/**
 *文字显示  显示默认地址或者是设为默认......
 */
@property (nonatomic, strong)UILabel *stateLabel;
/**
 *删除按钮
 */
@property (nonatomic, strong)OrderBtn *deleteBtn;
/**
 *编辑按钮
 */
@property (nonatomic, strong)OrderBtn *editorBtn;

- (void)BtnTagAssignment:(NSIndexPath *)indexPath;

@property (nonatomic, strong)SellerShipAddressModel *model;

@end
