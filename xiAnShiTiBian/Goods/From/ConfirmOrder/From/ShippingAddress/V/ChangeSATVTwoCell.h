//
//  ChangeSATVTwoCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/17.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *收货地址的编辑事件
 */
@protocol ChangeSATVTwoCellDelegate <NSObject>
/**
 *删除地址
 */
- (void)ShoppingAddDeleteBtn:(OrderBtn *)sender;
/**
 *编辑收货地址
 */
- (void)ShoppingAddEditorBtn:(OrderBtn *)sender;
/**
 *修改默认收货地址
 */
- (void)ChangeDefaultShippingAddress:(UIButton *)sender;

@end
/**
 *修改默认收货地址 上端有空隙的cell
 */
@interface ChangeSATVTwoCell : UITableViewCell
@property (nonatomic, assign)id<ChangeSATVTwoCellDelegate>delegate;
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
@property (nonatomic, strong)UIButton *chooseBtn;
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

- (void)BtnTagAssignment:(NSIndexPath *)indexPath model:(ShippingAddressModel *)model;

@end
