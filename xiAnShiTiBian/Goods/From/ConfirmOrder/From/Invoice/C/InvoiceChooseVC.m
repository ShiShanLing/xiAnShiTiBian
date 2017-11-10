//
//  InvoiceChooseVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/19.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "InvoiceChooseVC.h"
#import "InvoiceTypeTVCell.h"//选择发票cell
#import "SourceInvoiceTVCell.h"//发票抬头
#import "RecipientDetailsTVCell.h"//如果是电子发票 单位信息
#import "InvoiceTVCell.h"//发票信息
#import "InvoiceTypeTVCell.h"//纸质发票 或者电子发票选择
#import "RecipientDetailsTVCell.h"
#import "TakerDataTVCell.h"//点击发票需要的cell

@interface InvoiceChooseVC ()<UITableViewDelegate, UITableViewDataSource, InvoiceTypeTVCellDelegate, SourceInvoiceTVCellDelegate, InvoiceTVCellDelegate, RecipientDetailsTVCellDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)RecipientDetailsTVCell *RDCell;
@property (nonatomic, strong)TakerDataTVCell *TakerCell;

@end

@implementation InvoiceChooseVC {
    /**
     *发票抬头 个人或者企业  1是个人 2是企业
     */
    int invoiceHead;
    /**
     *发票类型   不开,电子或者纸质  0是不开发票 1是纸质发票  2是电子发票 通知 cell的个数也是由这个值决定的
     */
    int TaxType;
    /**
     *是否开发票 0不开 1开
     */
    int WhetherOrNotInvoice;
    /**
     *最后一个cell的高度,因为键盘出现可能会把输入框遮盖住 所以在键盘出现的时候让最后一个cell高度变高 然后上移 并 禁止cell滑动
     */
    int bottomCellHigh;
    /**
     * invoiceHead 为 2 的时候 companyName存储公司的名字
     */
    NSString *companyName;
}

- (void) registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}
//键盘出现时
- (void)keyboardWasShown:(NSNotification *)notif {
    CGRect frmae = self.tableView.frame;
    frmae.origin.y = -kFit(150);
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = frmae;
    }];
}
//键盘消失时让视图恢复原样
- (void) keyboardWasHidden:(NSNotification *) notif {
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, 0, kScreen_widht, kScreen_heigth);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self registerForKeyboardNotifications];///让界面岁键盘自适应
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = MColor(238, 238, 238);
    self.tableView.delegate = self;
    self.tableView.dataSource  =self;
    self.tableView.bounces = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[InvoiceTypeTVCell class] forCellReuseIdentifier:@"InvoiceTypeTVCell"];
    [self.tableView registerClass:[SourceInvoiceTVCell class] forCellReuseIdentifier:@"SourceInvoiceTVCell"];
    [self.tableView registerClass:[RecipientDetailsTVCell class] forCellReuseIdentifier:@"RecipientDetailsTVCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[InvoiceTVCell class] forCellReuseIdentifier:@"InvoiceTVCell"];
    [self.tableView registerClass:[RecipientDetailsTVCell class] forCellReuseIdentifier:@"RecipientDetailsTVCell"];
    [self.tableView registerClass:[TakerDataTVCell class] forCellReuseIdentifier:@"TakerDataTVCell"];
    [self.view addSubview:self.tableView];
    
    UIButton *determineBtn = [UIButton new];
    determineBtn.titleLabel.font = MFont(kFit(18));
    determineBtn.backgroundColor = kNavigation_Color;
    [determineBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [determineBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:determineBtn];
    
    UIButton *SaveBtn = [UIButton new];
    SaveBtn.backgroundColor = kNavigation_Color;
    [SaveBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    
    SaveBtn.titleLabel.textColor = MColor(255, 255, 255);
    SaveBtn.titleLabel.font = MFont(kFit(18));
    [SaveBtn addTarget:self action:@selector(handleSaveBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:SaveBtn];
    SaveBtn.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(kFit(55)).bottomSpaceToView(self.view, 0);

    
}
- (void)handleSaveBtn {
    if (_returnTextBlock) {
    
        NSString *str;
        if (invoiceHead == 1) {
            str = @"个人";
        }
        if (invoiceHead == 2) {
            if (companyName.length == 0) {
                [self showAlert:@"公司抬头不能为空!"];
                return;
            }else {
                str = companyName;
            }
        }
        _returnTextBlock(TaxType,str);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    TaxType = 0;
    
    invoiceHead = 1;
    WhetherOrNotInvoice = 0;
    bottomCellHigh = kFit(127);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (WhetherOrNotInvoice == 0) {
        return 1;
    }else {
        return 3;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (WhetherOrNotInvoice == 0) {//如果不开发票
        InvoiceTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvoiceTVCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {//否者 就开发票
        if (indexPath.row == 0) {//如果是第一个就显示发票信息选择
            InvoiceTypeTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvoiceTypeTVCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate  = self;
            return cell;
        }else if(indexPath.row == 1) {
            if (invoiceHead == 1) {//如果是个人
                SourceInvoiceTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SourceInvoiceTVCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
                return cell;
            }else {//否者就是公司
                self.RDCell = [tableView dequeueReusableCellWithIdentifier:@"RecipientDetailsTVCell" forIndexPath:indexPath];
                _RDCell.selectionStyle = UITableViewCellSelectionStyleNone;
                _RDCell.delegate = self;
                return _RDCell;
            }
    }else {
        InvoiceTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvoiceTVCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [_RDCell.TF resignFirstResponder];
    [_TakerCell.phoneTF resignFirstResponder];
    [_TakerCell.emailTF resignFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (WhetherOrNotInvoice == 1) {
    
    return bottomCellHigh;
    }else {

     if(indexPath.row == 1){
    if (invoiceHead == 1) {
        return kFit(110);
    }else {
        return kFit(133);
    }
         
    }else if(indexPath.row == 0){
        return kFit(110);
    }else {
        return kFit(150);
    }
    }
}
#pragma mark  InvoiceTypeTVCellDelegate  发票类型选择
//
- (void)InvoiceType:(int)index {
    
    if (index == 1) {
        TaxType = 2;
    }else {
        TaxType = 3;
    }
    [self.tableView reloadData];
}

- (void)transmissionCompanyName:(NSString *)name {

    companyName = name;

}

#pragma mark  SourceInvoiceTVCellDelegate  抬头类型 (个人)
//
- (void)SourceInvoiceType:(int)index {
    invoiceHead = 2; //点击之后变成企业发票
    [self.tableView reloadData];
}
#pragma mark  RecipientDetailsTVCellDelegate  (企业)
- (void)RecipientDetails:(int)index {
    invoiceHead = 1; //点击之后变成企业发票
    [self.tableView reloadData];
}
#pragma mark  InvoiceTVCellDelegate  发票信息开发票或者不开发票
- (void)Invoice:(int)index {
    
    TaxType = index;//只要点击明细就默认纸质发票
    WhetherOrNotInvoice = index;
    NSLog(@"WhetherOrNotInvoice%d", WhetherOrNotInvoice);
    [self.tableView reloadData];
}
//系统提示的弹出窗
- (void)timerFireMethod:(NSTimer*)theTimer {//弹出框
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}

@end
