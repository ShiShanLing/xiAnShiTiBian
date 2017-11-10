
//
//  PopUpView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/13.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "PopUpView.h"
#import "TyepTableViewCell.h"
#import "NumberTableViewCell.h"
#import "ModifyNumberView.h"

static NSInteger inventory = 1000000;

@interface PopUpView ()<UITableViewDataSource, UITableViewDelegate, ModifyNumberViewDelegate, TyepTableViewCellDelegate>
/**
 *
 */
@property (nonatomic, strong)UITableView *tableView;
/**
 *弹出view的头 因为有圆角所以进行了单独处理
 */
@property (nonatomic, strong)UIView *showView;
/**
 *确认按钮
 */
@property (nonatomic, strong)UIButton * ConfirmBtn;
/**
 *商品图片
 */
@property (nonatomic, strong)UIImageView *GoodsImage;
/**
 *商品名称
 */
@property (nonatomic, strong)UILabel *GoodsName;
/**
 *库存
 */
@property (nonatomic, strong)UILabel *GoodsPrice;
/**
 *商品原价
 */
@property (nonatomic, strong)UILabel *GoodsOriginalPrice;
/**
 *规格选择记录
 */
@property (nonatomic, strong)NSMutableArray *typeChooseID;
/**
 *规格选择记录
 */
@property (nonatomic, strong)NSMutableArray *typeChooseName;
/**
 *存储当前选择规格 库存 价格
 */
@property (nonatomic, strong)NSMutableDictionary *beSelectedSpecDic;


@end

@implementation PopUpView {
    NSInteger remainingInventory;
    CGFloat cellHeight;
}

- (NSMutableDictionary *)beSelectedSpecDic {
    if (!_beSelectedSpecDic) {
        _beSelectedSpecDic = [NSMutableDictionary dictionary];
    }
    return _beSelectedSpecDic;
}

- (NSMutableArray *)typeChooseID {
    if (!_typeChooseID) {
        _typeChooseID = [NSMutableArray array];
    }
    return _typeChooseID;
}
- (NSMutableArray *)typeChooseName {
    if (!_typeChooseName) {
        _typeChooseName =[NSMutableArray array];
    }
    return _typeChooseName;
}

- (NSMutableArray *)specIDArray {
    if (!_specIDArray) {
        _specIDArray = [NSMutableArray array];
        
    }
    return _specIDArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
        
        self.showView= [UIView new];
        _showView.backgroundColor = [UIColor whiteColor];
        _showView.layer.cornerRadius = 3;
        
        [self addSubview:_showView];
        _showView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, kFit(-20)).rightSpaceToView(self, 0).heightIs(kFit(115));
        
        self.GoodsImage = [UIImageView new];
        _GoodsImage.layer.cornerRadius = 3;
        _GoodsImage.layer.masksToBounds = YES;
        _GoodsImage.image = [UIImage imageNamed:@"zly"];
        
        [_GoodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImage_URL, _model.goodsImage]] placeholderImage:[UIImage imageNamed:@"ImageLoadDefault"]];
        [_showView addSubview:_GoodsImage];
        _GoodsImage.sd_layout.leftSpaceToView(_showView, kFit(12)).bottomSpaceToView(_showView, kFit(15)).widthIs(kFit(137)).heightIs(kFit(125));
        
        UIButton *ShutDownBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        UIImage *loginImg = [UIImage imageNamed:@"sc"];
        loginImg = [loginImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [ShutDownBtn setImage:loginImg forState:(UIControlStateNormal)];
        [ShutDownBtn addTarget:self action:@selector(handleShutDownBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self.showView addSubview:ShutDownBtn];
        ShutDownBtn.sd_layout.rightSpaceToView(self.showView,kFit(0)).topSpaceToView(_showView, kFit(0)).widthIs(kFit(52)).heightIs(kFit(52));
        
        self.GoodsName = [UILabel new];
        self.GoodsName.text =_model.goodsName;
        _GoodsName.textColor = MColor(51, 51, 51);
        
        self.GoodsName.font = MFont(kFit(17));
        
        [self.showView addSubview:_GoodsName];
        _GoodsName.sd_layout.leftSpaceToView(_GoodsImage, kFit(15)).topSpaceToView(_showView, kFit(25)).rightSpaceToView(ShutDownBtn, kFit(15)).heightIs(kFit(17));
        
        
        self.GoodsPrice = [UILabel new];
        _GoodsPrice.textColor = [UIColor redColor];
        _GoodsPrice.font = [UIFont systemFontOfSize:kFit(17)];
        _GoodsPrice.text = [NSString stringWithFormat:@"¥:%.2f", _model.goodsStorePrice];
        [self.showView addSubview:_GoodsPrice];
        _GoodsPrice.sd_layout.leftSpaceToView(_GoodsImage,kFit(15)).topSpaceToView(self.GoodsName, kFit(15)).rightSpaceToView(ShutDownBtn, kFit(15)).heightIs(kFit(17));
        
       
        
        
        self.GoodsOriginalPrice = [UILabel new];
        _GoodsOriginalPrice.textColor = MColor(168, 168, 168);
        _GoodsOriginalPrice.font = MFont(kFit(14));
        _GoodsOriginalPrice.text = @"剩余库存8件";
        [self.showView addSubview:_GoodsOriginalPrice];
        
        _GoodsOriginalPrice.sd_layout.leftSpaceToView(self.GoodsImage, kFit(15)).topSpaceToView(self.GoodsPrice,kFit(10)).rightEqualToView(_GoodsPrice).heightIs(kFit(14));
        
        UILabel *lineLabel = [UILabel new];
        lineLabel.backgroundColor = MColor(238, 238, 238);
        [self addSubview:lineLabel];
        lineLabel.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self.showView, 0).rightSpaceToView(self, 0).heightIs(0.5);

        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kFit(95.5), kScreen_widht, self.frame.size.height - kFit(150)) style:(UITableViewStylePlain)];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        //_tableView.backgroundColor = kNavigation_Color;
        [self.tableView registerClass:[TyepTableViewCell class] forCellReuseIdentifier:@"TyepTableViewCell"];
        [self.tableView registerClass:[NumberTableViewCell class] forCellReuseIdentifier:@"NumberTableViewCell"];
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
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

        [_ConfirmBtn addTarget:self action:@selector(handleGoodsDetermine:) forControlEvents:(UIControlEventTouchUpInside)];
        [_ConfirmBtn  setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self addSubview:_ConfirmBtn];
        _ConfirmBtn.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self.tableView, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);

    }
    return self;
}

/**
 *我在这个方法里面给控件赋值
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    {
        [_GoodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImage_URL, _model.goodsImage]] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
       // NSLog(@"goodsImage%@", _model.goodsImage);
        self.GoodsName.text = _model.goodsName;
        self.GoodsPrice.text = [NSString stringWithFormat:@"¥:%.2f", _model.goodsStorePrice];
        
        self.GoodsOriginalPrice.text = @"";
        
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *TextDic = (NSDictionary *)_model.goodsSpec;
    NSArray * TextArray = [TextDic allKeys];
    return TextArray.count + 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *TextDic = (NSDictionary *)_model.goodsSpec;
    NSArray * TextArray = [TextDic allKeys]; //获取有多少种规格
    if (indexPath.row == TextArray.count) {//数量加减cell
        NumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumberTableViewCell"forIndexPath:indexPath];
        cell.ModifyNumberView.delegate = self;
        cell.ModifyNumberView.numberTF.text = [NSString stringWithFormat:@"%ld", (long)self.goodsNum];
       // NSLog(@"cellForRowAtIndexPath%ld", (long)self.goodsNum);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {//规格选择cell
        TyepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TyepTableViewCell"forIndexPath:indexPath];
        NSDictionary *TextDic = _model.goodsSpec;
        NSArray * TextArray = [TextDic allKeys];
        
        [cell PhotoNamesDic:TextDic[TextArray[indexPath.row]] title:TextArray[indexPath.row] indexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
}
#pragma mark TyepTableViewCellDelegate
- (void)typeSubscript:(OrderBtn *)sender {
    
    self.typeChooseID[sender.tag/100-1] = sender.tyepID;
    
    self.typeChooseName[sender.tag/100-1] = sender.tyepName;
    
    self.GoodsOriginalPrice.text = @"请选择全部规格";
    
    for (NSDictionary *specDic in _specIDArray) {//比那里规格ID数组
            NSArray *specArray = [specDic allKeys];//获取所有的KEY
            BOOL specState = YES;//用来判断是不是包含这个KEY
            for (int i = 0; i< _typeChooseID.count; i ++) {
                NSString *key = _typeChooseID[i];
                if ([specArray containsObject:key]) {
                    specState = YES;
                }else {
                    specState = NO;
                    break;
                }
            }
            if (specState) {
           //     NSLog(@"specArray%@", specDic);
                self.GoodsPrice.text = [NSString stringWithFormat:@"¥:%@", specDic[@"specGoodsPrice"]];
                self.GoodsOriginalPrice.text = [NSString stringWithFormat:@"剩余库存%@件", specDic[@"specGoodsStorage"]];
                NSString *tempStr = specDic[@"specGoodsStorage"];
                remainingInventory = tempStr.integerValue;
                NSString *text = specDic[@"specGoodsStorage"];
                inventory = text.integerValue;
                self.beSelectedSpecDic = [NSMutableDictionary dictionaryWithDictionary:specDic];
                break;
            }else {
        }
    }
}
//这里需要根据规格值的多少来动态调整cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *TextDic = _model.goodsSpec;
    NSArray * TextArray = [TextDic allKeys];
    if (indexPath.row == TextArray.count) {
        return kFit(66);
    }else {
      //  NSLog(@"%@----%@------%d", TextDic, TextArray,indexPath.row);
        return [self cellHeight:TextDic[TextArray[indexPath.row]]];
    }
}
//隐藏视图
- (void)handleShutDownBtn {
    if ([_delegate respondsToSelector:@selector(hiddenView)]) {
        [_delegate hiddenView];
    }
}
//确认按钮
- (void)handleGoodsDetermine:(UIButton *)sender {
    BOOL type = YES;
    
    NSLog(@"handleGoodsDetermine%@", _typeChooseID);
    for (NSString  *str in _typeChooseID) {
        if ([str isEqualToString:@"0"]) {
        type = NO;
        break;
        }
    }
    
    NSArray *specArray = _model.specName;
    
    NSLog(@"specIDArray%@", self.specIDArray);
    NSDictionary *TextDic = (NSDictionary *)_model.goodsSpec;
    NSArray * TextArray = [TextDic allKeys];
    
    if (TextArray.count == 0) {
        if ([_delegate respondsToSelector:@selector(DetermineBtnClick:typeID:typeName:goodsNum:)]) {
            [_delegate DetermineBtnClick:sender typeID:_typeChooseID typeName:_typeChooseName goodsNum:self.goodsNum];
        }
        return;
    }
    
    if (remainingInventory == 0) {
        [self showAlert:@"该类商品已经卖完!"];
    }else if (!type) {
        [self showAlert:@"还有规格未选择"];
    }else if(inventory < self.goodsNum && inventory== 1000000){
        [self showAlert:@"选择的数量超出库存"];
    }else{
    if ([_delegate respondsToSelector:@selector(DetermineBtnClick:typeID:typeName:goodsNum:)]) {
        [_delegate DetermineBtnClick:sender typeID:_typeChooseID typeName:_typeChooseName goodsNum:self.goodsNum];
        }
    }
}
//数量加减
- (void)GoodsNumberChange:(UIButton*)sender view:(ModifyNumberView *)view {
    //如果是减 那么商品数量 -= 1
    if (sender.tag == 201) {
        if (self.goodsNum != 1) {
            self.goodsNum --;
        }
    }
    //如果是加 那么商品数量 += 1
    if (sender.tag == 202) {
        self.goodsNum ++;
    }
    view.numberTF.text  = [NSString stringWithFormat:@"%ld", (long)self.goodsNum];
    //[self.tableView reloadData];
}
//计算cell的高度 我事先想不出办法计算了只能用这种方法了 对不起了哥们
- (CGFloat)cellHeight:(NSDictionary *)dataDic{
    NSArray *keyArray = [dataDic allKeys];

    BOOL  isLineReturn = NO;
    float upX = 10;
    float upY = 40;
    for (int i = 0; i<keyArray.count; i++) {
        NSString *KeyStr = [keyArray objectAtIndex:i] ;
        NSString *valueStr = dataDic[KeyStr];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
        CGSize size = [valueStr sizeWithAttributes:dic];
        
        if ( upX > (self.frame.size.width-20 -size.width-35)) {
            isLineReturn = YES;
            upX = kFit(10);
            upY += kFit(38);
        }
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(upX, upY, size.width+30,28);
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:valueStr forState:0];
        btn.layer.cornerRadius = 8;
        btn.layer.borderColor = [UIColor clearColor].CGColor;
        btn.layer.borderWidth = 0;
        [btn.layer setMasksToBounds:YES];
        btn.tag = 101+i;
        upX+=size.width+35;
    }
   return  upY +=40;
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

-(void)setModel:(GoodsDetailsModel *)model {
    
    _model = model;
    NSMutableArray *array = (NSMutableArray *)_model.specName;
    for (int i = 0; i < array.count; i ++) {
        array[i] = @"0";
    }
    self.typeChooseID = [NSMutableArray arrayWithArray:array];
    
    NSArray *specArray = (NSMutableArray *)_model.specName;
    self.typeChooseName =[NSMutableArray arrayWithArray:specArray];
}

@end
