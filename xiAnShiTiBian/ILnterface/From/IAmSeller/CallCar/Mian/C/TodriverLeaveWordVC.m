//
//  TodriverLeaveWordVC.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "TodriverLeaveWordVC.h"

@interface TodriverLeaveWordVC ()<UITextViewDelegate>

@property (nonatomic, strong)UITextView *textView;

@property (nonatomic, strong)UILabel *promptLabel;

@end

@implementation TodriverLeaveWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self createView];
}
-(void)createNavigation {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavigation_title_Color,NSFontAttributeName:[UIFont systemFontOfSize:kFit(18)]}];
    self.navigationItem.title = @"给司机留言";
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
    phoneLabel.text = @"留言";
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
    _promptLabel.text = @"请输入留言内容,但不能超过300个字符;";
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
    
    if (_textView.text.length == 0) {
        UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒!" message:@"您还没有添加留言信息,确认提交吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *determine = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (_leaveMessageBlock) {
                
                _leaveMessageBlock(_textView.text);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        
        // 3.将“取消”和“确定”按钮加入到弹框控制器中
        [alertV addAction:determine];
        [alertV addAction:cancel];
        // 4.控制器 展示弹框控件，完成时不做操作
        [self presentViewController:alertV animated:YES completion:^{
            nil;
        }];

    }
    
  
        if (_leaveMessageBlock) {
            
            _leaveMessageBlock(_textView.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
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
        _promptLabel.text=@"请输入留言内容,但不能超过300个字符;";
    }
}

@end
