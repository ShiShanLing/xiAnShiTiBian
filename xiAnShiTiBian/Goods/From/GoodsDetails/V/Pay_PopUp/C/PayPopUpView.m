

//
//  PayPopUpView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/4.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "PayPopUpView.h"
#import "OrderNumberTVCell.h"
#import "PayWayTVCell.h"

static NSInteger payWay;//记录用户点击了那种支付方式 默认为0  3是积分 4是支付宝 5是微信

@interface PayPopUpView ()<UITableViewDataSource, UITableViewDelegate>
/**
 *
 */
@property (nonatomic, strong)UITableView *tableView;
/**
 *确认按钮
 */
@property (nonatomic, strong)UIButton * ConfirmBtn;

@end

@implementation PayPopUpView

- (instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *ShutDownBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        UIImage *loginImg = [UIImage imageNamed:@"sc"];
        loginImg = [loginImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [ShutDownBtn setImage:loginImg forState:(UIControlStateNormal)];
        [ShutDownBtn addTarget:self action:@selector(handleShutDownBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:ShutDownBtn];
        ShutDownBtn.sd_layout.leftSpaceToView(self,kFit(0)).topSpaceToView(self, kFit(0)).widthIs(kFit(52)).heightIs(kFit(45));
        
        UIButton *helpBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        UIImage *helpImage = [UIImage imageNamed:@"bangzhu"];
        helpImage = [helpImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [helpBtn setImage:helpImage forState:(UIControlStateNormal)];
        [helpBtn addTarget:self action:@selector(handleHelpBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:helpBtn];
        helpBtn.sd_layout.rightSpaceToView(self,kFit(0)).topSpaceToView(self, kFit(0)).widthIs(kFit(52)).heightIs(kFit(45));
        
        UILabel *lineLabel = [UILabel new];
        lineLabel.backgroundColor = MColor(210, 210, 210);
        [self addSubview:lineLabel];
        lineLabel.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, kFit(45)).rightSpaceToView(self, 0).heightIs(0.5);

        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kFit(45.5), kScreen_widht, self.frame.size.height - kFit(100.5)) style:(UITableViewStylePlain)];
        [self.tableView registerClass:[OrderNumberTVCell class] forCellReuseIdentifier:@"OrderNumberTVCell"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.tableView registerClass:[PayWayTVCell class] forCellReuseIdentifier:@"PayWayTVCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.rowHeight = kScreen_heigth/4.764286;
        [_tableView setBounces:NO];
        [self addSubview:self.tableView];
        
        //确认按钮
        self.ConfirmBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_ConfirmBtn setTitle:@"确认" forState:(UIControlStateNormal)];
        _ConfirmBtn.backgroundColor = kNavigation_Color;
        _ConfirmBtn.titleLabel.font = [UIFont systemFontOfSize:kFit(18)];
        
        [_ConfirmBtn addTarget:self action:@selector(handleConfirmBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [_ConfirmBtn  setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self addSubview:_ConfirmBtn];
        _ConfirmBtn.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self.tableView, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = @"选择支付方式";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 0 ){
        OrderNumberTVCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"OrderNumberTVCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *DataArray = @[@[@"需付款", [NSString stringWithFormat:@"%.2f", self.OrderPrice]]];
        [cell cellAssignment:DataArray[indexPath.row]];
        return cell;
    }else {
        PayWayTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayWayTVCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell ControlsAssignment:indexPath.row];
        if (indexPath.row == payWay) {
            [cell ChoosePayWay:YES];
        }else {
            [cell ChoosePayWay:NO];
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    payWay = indexPath.row;
    NSLog(@"payWay%ld",(long)payWay );
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(55);
}
//隐藏视图
- (void)handleShutDownBtn {
    if ([_delegate respondsToSelector:@selector(hiddenView)]) {
        [_delegate hiddenView];
    }
}

- (void)handleConfirmBtn:(UIButton *)sender { //点击的时候需要把值传过去
    if ([_delegate respondsToSelector:@selector(DetermineBtnClick:)]) {
        [_delegate DetermineBtnClick:payWay + 1];//这个给4是为了让系统判断为支付包支付 外面的逻辑就不用改了之后开通之后 就可以传 payWay
    }
}

- (void)handleHelpBtn {
    if ([_delegate respondsToSelector:@selector(handleHelp)]) {
        [_delegate handleHelp];
    }

}
@end
