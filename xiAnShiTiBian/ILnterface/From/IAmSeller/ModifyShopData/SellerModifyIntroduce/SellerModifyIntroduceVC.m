//
//  SellerModifyIntroduceVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/19.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerModifyIntroduceVC.h"

@interface SellerModifyIntroduceVC ()<UITextViewDelegate>

@property (nonatomic, strong)UITextView *textView;

@property (nonatomic, strong)UILabel *promptLabel;
@end

@implementation SellerModifyIntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self createView];
}
-(void)createNavigation {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color,NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];
    self.navigationItem.title = @"编辑店铺介绍";
    UIImage *returnimage = [UIImage imageNamed:@"return_black"];
    //设置图像渲染方式
    returnimage = [returnimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:returnimage style:UIBarButtonItemStylePlain target:self action:@selector(handleReturn)];//自定义导航条按钮
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = MColor(238, 238, 238);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)handleReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createView {
    UILabel *phoneLabel= [UILabel new];
    phoneLabel.text = @"请对店铺地址进行编辑";
    phoneLabel.textColor = MColor(51, 51, 51);
    phoneLabel.font = MFont(kFit(15));
    [self.view addSubview:phoneLabel];
    phoneLabel.sd_layout.leftSpaceToView(self.view, kFit(12)).topSpaceToView(self.view, kFit(15)+64).widthIs(kFit(200)).heightIs(kFit(15));
    
    self.textView = [UITextView new];
    _textView.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    _textView.delegate = self;//设置它的委托方法
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    _textView.font = [UIFont systemFontOfSize:kFit(15)];
    
    self.textView.scrollEnabled = YES;//是否可以拖动
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    [self.view addSubview:_textView];
    _textView.sd_layout.leftSpaceToView(self.view, 0).topSpaceToView(phoneLabel, kFit(12)).rightSpaceToView(self.view, 0).heightIs(kFit(100));
    
    
    self.promptLabel = [UILabel new];
    _promptLabel.text = @"请输入商店介绍不能超过300个字符;";
    _promptLabel.font = [UIFont systemFontOfSize:kFit(15)];
    _promptLabel.textColor = [UIColor lightGrayColor];
    _promptLabel.userInteractionEnabled = NO;
    [self.view addSubview:_promptLabel];
    _promptLabel.sd_layout.leftSpaceToView(self.view, kFit(12)).topEqualToView(_textView).rightSpaceToView(self.view, kFit(12)).heightIs(kFit(30));
    
    UIButton *submitBtn = [UIButton new];
    submitBtn.backgroundColor = kNavigation_Color;
    submitBtn.layer.cornerRadius = 3;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.titleLabel.font = MFont(kFit(17));
    [submitBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
    [submitBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [submitBtn addTarget:self action:@selector(handleSubmitBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:submitBtn];
    submitBtn.sd_layout.widthIs(kScreen_widht-kFit(24)).heightIs(kFit(47.5)).topSpaceToView(_textView, kFit(20)).centerXEqualToView(self.view);

    
    
}

- (void)handleSubmitBtn {
    
    
    if (_textView.text.length == 0 ) {
        [self showAlert:@"选项不能为空" time:1.0];
        return;
    }
    
    NSString *URL_Str = [NSString stringWithFormat:@"%@/storeapi/storeDescription", kSHY_100];
    NSMutableDictionary *URL_Dic = [NSMutableDictionary dictionary];
    URL_Dic[@"storeId"] = self.model.storeId;
    URL_Dic[@"memberId"] = self.model.memberId;
    
    URL_Dic[@"description"] = _textView.text;
    
    NSLog(@"URL_Str%@--URL_Dic%@",URL_Str, URL_Dic);
    __block SellerModifyIntroduceVC *VC = self;
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:URL_Str parameters:URL_Dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@", responseObject);
        NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
        if ([resultStr isEqualToString:@"1"]) {
            [VC showAlert:responseObject[@"msg"] time:1.0];
            [VC.navigationController popViewControllerAnimated:YES];
        }else {
            [VC showAlert:responseObject[@"msg"] time:1.0];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@", error);
        [VC showAlert:@"网络链接超时请重试!" time:1.3];
    }];
}

- (void)handleTap {
    [_textView resignFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
//点击textView的时候
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _promptLabel.text=@"";
    return YES;
    
}
//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    
}
//编辑完毕的时候
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        _promptLabel.text=@"请输入商店介绍,但不能超过300个字符;";
    }
}
//系统提示的弹出窗
- (void)timerFireMethod:(NSTimer*)theTimer {//弹出框
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message time:(CGFloat)time{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}


@end
