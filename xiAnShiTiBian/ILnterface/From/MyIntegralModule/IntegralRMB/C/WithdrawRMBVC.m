//
//  WithdrawRMBVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/15.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "WithdrawRMBVC.h"
#import "WithdrawalAmountTVCell.h"
#import "ContactTVCell.h"
#import "WithdrawalBasicDataTVCell.h"
#import "WithdrawValidationTVCell.h"
@interface WithdrawRMBVC ()<UITableViewDelegate, UITableViewDataSource, WithdrawValidationTVCellDelegate, UITextFieldDelegate>

@property (nonatomic, strong)UITextField *RMBNumberTF;
@property (nonatomic, strong)UITextField *ContactPhoneTF;
@property (nonatomic, strong)UILabel *ExistingLntegral;
@property (nonatomic, strong)UIButton *AllTakeBtn;

@property (nonatomic, strong)UITableView *tableView;
/**
 *
 */
@property (nonatomic, strong)WithdrawalAmountTVCell *withdrawalAmountTVCell;
/**
 *
 */
@property (nonatomic, strong)ContactTVCell *contactTVCell;
/**
 *
 */
@property (nonatomic, strong)WithdrawalBasicDataTVCell *withdrawalBasicDataTVCell;
/**
 *
 */
@property (nonatomic, strong)WithdrawValidationTVCell *withdrawValidationTVCell;

/**
 *提现积分数量
 */
@property (nonatomic, strong)NSString *WithdrawalAmountStr;
/**
 *真实姓名
 */
@property (nonatomic, strong)NSString *RealNameStr;
/**
 *身份证号
 */
@property (nonatomic, strong)NSString *IdNumberStr;
/**
 *银行卡号
 */
@property (nonatomic, strong)NSString *BankCardStr;
/**
 *手机号
 */
@property (nonatomic, strong)NSString *phoneNumberStr;
/**
 *验证码
 */
@property (nonatomic, strong)NSString *VerificationCode;
@end

@implementation WithdrawRMBVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MColor(238, 238, 238);
    [self.view addSubview:self.tableView];
    [self configurationNavigationBar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    UIButton *submitBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [submitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    submitBtn.frame = CGRectMake(0, kScreen_heigth-59, kScreen_widht, 59);
    submitBtn.font = MFont(kFit(18));
    submitBtn.backgroundColor = kNavigation_Color;
    [submitBtn addTarget:self action:@selector(handleSubmitBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:submitBtn];
    
    
}

- (void)handleSubmitBtn {
    int integer = _WithdrawalAmountStr.intValue/100;
    int surplus = _WithdrawalAmountStr.intValue%100;
    
    if (integer == 0 || surplus != 0) {
        [self showAlert:@"您填写的数量不是100的倍数" time:1.0];
    }else if (_WithdrawalAmountStr.length == 0 || _RealNameStr.length==0 || _IdNumberStr.length == 0 || _BankCardStr.length == 0 ||_phoneNumberStr.length == 0 || _VerificationCode.length == 0) {
        [self showAlert:@"选项不能为空" time:1.0];
    }else {
        NSString *URL_Str = [NSString stringWithFormat:@"%@/pontsApi/apply",kSHY_100];
        NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
        URL_Dic[@"points"] = _WithdrawalAmountStr;
        URL_Dic[@"trueName"] = _RealNameStr;
        URL_Dic[@"idCard"] = _IdNumberStr;
        URL_Dic[@"bankCardNumber"] = _BankCardStr;
        URL_Dic[@"memberId"] = self.membersID;
        URL_Dic[@"mobileCode"] = _VerificationCode;
        URL_Dic[@"telPhone"] = _phoneNumberStr;
        
        NSLog(@"URL_Str%@ URL_Dic%@",URL_Str,URL_Dic);
        __weak WithdrawRMBVC *VC = self;
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"uploadProgress%@", uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject%@", responseObject);
            NSString *messageStr = responseObject[@"message"];
            if ([messageStr isEqualToString:@"1"]) {
                UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功:等待审核(时间为3-5个工作日)" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    [VC.navigationController popViewControllerAnimated:YES];
                }];
                // 3.将“取消”和“确定”按钮加入到弹框控制器中
                [alertV addAction:cancle];
                // 4.控制器 展示弹框控件，完成时不做操作
                [self presentViewController:alertV animated:YES completion:^{
                    nil;
                }];
                
            }else {
                
                [VC showAlert:@"提交失败请稍后重试" time:1.0];
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error%@", error);
        }];
        
    }

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.withdrawalAmountTVCell.RMBNumberTF resignFirstResponder];
    [self.contactTVCell.ContactPhoneTF resignFirstResponder];
    [self.withdrawalBasicDataTVCell.NameTF resignFirstResponder];
    [self.withdrawalBasicDataTVCell.IdNumberTF resignFirstResponder];
    [self.withdrawalBasicDataTVCell.BankCard resignFirstResponder];
    [self.withdrawValidationTVCell.phoneNumberTF resignFirstResponder];
    [self.withdrawValidationTVCell.VerificationCodeTF resignFirstResponder];
}

-(void)keyboardWillShow:(NSNotification *)note{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, keyBoardRect.size.height, 0);
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note{
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    return YES;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.withdrawalAmountTVCell.RMBNumberTF) {
        [self.withdrawalBasicDataTVCell.NameTF becomeFirstResponder];
        return NO;
    }else
    if (textField == self.withdrawalBasicDataTVCell.NameTF) {
        [self.withdrawalBasicDataTVCell.IdNumberTF becomeFirstResponder];
        return NO;
    }else
    if (textField == self.withdrawalBasicDataTVCell.IdNumberTF) {
        [self.withdrawalBasicDataTVCell.BankCard becomeFirstResponder];
        return NO;
    }else
    if (textField == self.withdrawalBasicDataTVCell.BankCard) {
        [self.withdrawValidationTVCell.phoneNumberTF becomeFirstResponder];
        return NO;
    }else
    if (textField == self.withdrawValidationTVCell.phoneNumberTF) {
        [self.withdrawValidationTVCell.VerificationCodeTF becomeFirstResponder];
        return NO;
    }else
    if (textField == self.withdrawValidationTVCell.VerificationCodeTF) {
        [self.withdrawValidationTVCell.VerificationCodeTF resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
    
}

- (void)configurationNavigationBar{
    self.navigationItem.title = @"积分提现";
    self.navigationController.navigationBar.barTintColor = kNavigation_whrColor;//导航条颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color, NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];//改变导航条标题的颜色与大小
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;

}
//返回上一界面
- (void)handleReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super.navigationController setNavigationBarHidden:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kScreen_heigth-56) style:(UITableViewStyleGrouped)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"WithdrawalBasicDataTVCell" bundle:nil] forCellReuseIdentifier:@"WithdrawalBasicDataTVCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"WithdrawValidationTVCell" bundle:nil] forCellReuseIdentifier:@"WithdrawValidationTVCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[WithdrawalAmountTVCell class] forCellReuseIdentifier:@"WithdrawalAmountTVCell"];
        [_tableView registerClass:[ContactTVCell class] forCellReuseIdentifier:@"ContactTVCell"];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return kFit(137);
    }else  if (indexPath.section == 1){
        return 152;
    }else {
        return 112;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        self.withdrawalAmountTVCell= [tableView dequeueReusableCellWithIdentifier:@"WithdrawalAmountTVCell" forIndexPath:indexPath];
        _withdrawalAmountTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _withdrawalAmountTVCell.RMBNumberTF.delegate = self;
        _withdrawalAmountTVCell.RMBNumberTF.tag = 0;
        _withdrawalAmountTVCell.RMBNumberTF.returnKeyType = UIReturnKeyNext;
        _withdrawalAmountTVCell.RMBNumberTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [_withdrawalAmountTVCell.RMBNumberTF addTarget:self action:@selector(textFieldWithText:) forControlEvents:(UIControlEventEditingChanged)];
        int money = self.integralStr.intValue/100;
        
   
        
        _withdrawalAmountTVCell.ExistingLntegral.text = [NSString stringWithFormat:@"现有积分:%@ (可提现￥%d)", self.integralStr, money];
        return _withdrawalAmountTVCell;
    }else  if (indexPath.section == 1){
        self.withdrawalBasicDataTVCell = [tableView dequeueReusableCellWithIdentifier:@"WithdrawalBasicDataTVCell" forIndexPath:indexPath];
        _withdrawalBasicDataTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _withdrawalBasicDataTVCell.NameTF.delegate = self;
        _withdrawalBasicDataTVCell.NameTF.returnKeyType = UIReturnKeyNext;
        _withdrawalBasicDataTVCell.NameTF.tag = 1;
        [_withdrawalBasicDataTVCell.NameTF addTarget:self action:@selector(textFieldWithText:) forControlEvents:(UIControlEventEditingChanged)];
        _withdrawalBasicDataTVCell.IdNumberTF.delegate = self;
        _withdrawalBasicDataTVCell.IdNumberTF.returnKeyType = UIReturnKeyNext;
        _withdrawalBasicDataTVCell.IdNumberTF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        _withdrawalBasicDataTVCell.IdNumberTF.tag = 2;
        [_withdrawalBasicDataTVCell.IdNumberTF addTarget:self action:@selector(textFieldWithText:) forControlEvents:(UIControlEventEditingChanged)];
        _withdrawalBasicDataTVCell.BankCard.delegate = self;
        _withdrawalBasicDataTVCell.BankCard.returnKeyType = UIReturnKeyNext;
        _withdrawalBasicDataTVCell.BankCard.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        _withdrawalBasicDataTVCell.BankCard.tag = 3;
        [_withdrawalBasicDataTVCell.BankCard addTarget:self action:@selector(textFieldWithText:) forControlEvents:(UIControlEventEditingChanged)];
        return _withdrawalBasicDataTVCell;
    }else {
        self.withdrawValidationTVCell = [tableView dequeueReusableCellWithIdentifier:@"WithdrawValidationTVCell" forIndexPath:indexPath];
        _withdrawValidationTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _withdrawValidationTVCell.phoneNumberTF.delegate = self;
        _withdrawValidationTVCell.phoneNumberTF.returnKeyType = UIReturnKeyNext;
        _withdrawValidationTVCell.phoneNumberTF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        _withdrawValidationTVCell.phoneNumberTF.tag = 4;
        [_withdrawValidationTVCell.phoneNumberTF addTarget:self action:@selector(textFieldWithText:) forControlEvents:(UIControlEventEditingChanged)];
        _withdrawValidationTVCell.VerificationCodeTF.delegate = self;
        _withdrawValidationTVCell.VerificationCodeTF.returnKeyType = UIReturnKeyDone;
        _withdrawValidationTVCell.VerificationCodeTF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        _withdrawValidationTVCell.VerificationCodeTF.tag = 5;
        [_withdrawValidationTVCell.VerificationCodeTF addTarget:self action:@selector(textFieldWithText:) forControlEvents:(UIControlEventEditingChanged)];
        _withdrawValidationTVCell.delegate = self;
        return _withdrawValidationTVCell;
    }
}


- (void)textFieldWithText:(UITextField *)textField {

    switch (textField.tag) {
        case 0:
            self.WithdrawalAmountStr = textField.text;
            break;
        case 1:
            self.RealNameStr = textField.text;
            break;
        case 2:
            self.IdNumberStr = textField.text;
            break;
        case 3:
            self.BankCardStr = textField.text;
            break;
        case 4:
            self.phoneNumberStr = textField.text;
            break;
        case 5:
            self.VerificationCode = textField.text;
            break;
            
        default:
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 10;
    }else {
        return 0.01;
    }
}

- (void)handleGetVerificationCode:(JKCountDownButton *)sender {
    
    
    
    
    if (_phoneNumberStr.length ==0) {
        UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"警告!" message:@"手机号为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [alertV addAction:confirm];
        // 4.控制器 展示弹框控件，完成时不做操作
        [self presentViewController:alertV animated:YES completion:^{
            nil;
        }];
    }else {
        sender.enabled = NO;
        //button type要 设置成custom 否则会闪动
        [sender startWithSecond:60];
        
        [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            return title;
        }];
        [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";
        }];
        NSString *str=[NSString stringWithFormat:@"%@/floor/api/verifyCode", kSHY_100];
        NSMutableDictionary *URLDIC = [NSMutableDictionary dictionary];
        URLDIC[@"mobile"] = _phoneNumberStr;
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        __weak WithdrawRMBVC *VC = self;
        [session POST:str parameters:URLDIC progress:^(NSProgress * _Nonnull uploadProgress) {
            NSLog(@"uploadProgress%@", uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                       NSString *requltStr = [NSString stringWithFormat:@"%@", responseObject[@"reqult"]];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error%@", error);
        }];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
