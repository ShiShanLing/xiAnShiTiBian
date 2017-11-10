//
//  SearchStoreSortingView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/3.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SearchStoreSortingView.h"
#import "DownMenuCell.h"

#define KTableViewCellHeight 44
#define KDisplayMaxCellOfNumber  5
#define KTitleButtonTag 1000

static int cellIndex;

@interface SearchStoreSortingView ()<UITableViewDelegate, UITableViewDataSource>
/**
 *综合排序 comprehensive sequencing 缩写
 */
@property (nonatomic,strong)UIButton *CSBtn;
/**
 *销量排序  sales sequencing 的缩写
 */
@property (nonatomic, strong)UIButton *SSBtn;

@property (nonatomic)UITableView *tableView;
@property (nonatomic)NSMutableArray *tableDataArray;
@property (nonatomic) CGFloat selfOriginalHeight ;
@property (nonatomic) CGFloat tableViewMaxHeight ;
@property (nonatomic) NSMutableArray *buttonArray;
@property (nonatomic) UIView  *maskBackGroundView;

@end

@implementation SearchStoreSortingView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.tableViewMaxHeight = KTableViewCellHeight * KDisplayMaxCellOfNumber;
        self.selfOriginalHeight =frame.size.height;
        [self addSubview:self.maskBackGroundView];
        [self addSubview:self.tableView];
        
        self.CSBtn = [UIButton new];
        [_CSBtn setTitle:@"全部" forState:(UIControlStateNormal)];
        _CSBtn.titleLabel.font = MFont(kFit(15));
        _CSBtn.tag = KTitleButtonTag;
        [_CSBtn setTitleColor:MColor(134, 134, 134) forState:(UIControlStateNormal)];
        [_CSBtn setImage:[UIImage imageNamed:@"huixia"] forState:(UIControlStateNormal)];
        [_CSBtn setTitleColor:kNavigation_Color forState:(UIControlStateSelected)];
        [_CSBtn setImage:[UIImage imageNamed:@"hongshang"] forState:(UIControlStateSelected)];
        UIEdgeInsets imageFrame;
        imageFrame = _CSBtn.imageEdgeInsets ;
        imageFrame.right -= kFit(90);
        _CSBtn.imageEdgeInsets = imageFrame;
        
        UIEdgeInsets titleFrame;
        titleFrame = _CSBtn.titleEdgeInsets;
        titleFrame.right +=kFit(17);
        titleFrame.left = 0;
        _CSBtn.titleEdgeInsets = titleFrame;
        _CSBtn.titleLabel.textAlignment = 1;
        [_CSBtn addTarget:self action:@selector(handleCSBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_CSBtn];
        _CSBtn.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).widthIs(kFit(105)).heightIs(kFit(43));
        
        self.SSBtn = [UIButton new];
        [_SSBtn setTitle:@"信用" forState:(UIControlStateNormal)];
        _SSBtn.titleLabel.font = MFont(kFit(15));
        [_SSBtn setTitleColor:MColor(134, 134, 134) forState:(UIControlStateNormal)];
        [_SSBtn setTitleColor:kNavigation_Color forState:(UIControlStateSelected)];
        [self addSubview:_SSBtn];
        [_SSBtn addTarget:self action:@selector(handleSSBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        _SSBtn.sd_layout.leftSpaceToView(_CSBtn, 0).topSpaceToView(self, 0).heightIs(kFit(43)).widthIs(kFit(105));
        
               
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(210, 210, 210);
        [self addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self, 0).bottomSpaceToView(self, 0.5).rightSpaceToView(self, 0).heightIs(0.5);
    }
    
    return self;
}

- (void)handleCSBtn:(UIButton *)sender {
    NSUInteger index =  sender.tag - KTitleButtonTag;
    
    self.SSBtn.selected = NO;
    
    
    if (!_CSBtn.selected) {
        
        self.tableDataArray = self.menuDataArray[index];
        
        [self.tableView reloadData];
        CGFloat tableViewHeight =  self.tableDataArray.count * KTableViewCellHeight < self.tableViewMaxHeight ?
        self.tableDataArray.count * KTableViewCellHeight : self.tableViewMaxHeight;
        
        
        [self expandWithTableViewHeight:tableViewHeight];
        
    }else
    {
        
        [self takeBackTableView];
    }
}
- (void)handleSSBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    [self takeBackTableView];//收回
   
}

-(UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, kScreen_widht, 0)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.tableView.rowHeight= KTableViewCellHeight;
    [self.tableView registerClass:[DownMenuCell class] forCellReuseIdentifier:@"DownMenuCell"];
    
    return self.tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DownMenuCell *cell =[tableView dequeueReusableCellWithIdentifier:@"DownMenuCell" forIndexPath:indexPath];
    
    
    cell.textLabel.text = self.tableDataArray[indexPath.row];
    
    if (indexPath.row == cellIndex) {
        cell.isSelected = YES;
    }
    else
    {
        cell.isSelected=NO;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.CSBtn.selected = NO;
    DownMenuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = YES;
    cellIndex = indexPath.row;
    [_CSBtn setTitle:[NSString stringWithFormat:@"%@",self.tableDataArray[indexPath.row]] forState:0];
    if (self.handleSelectDataBlock) {
        self.handleSelectDataBlock(cell.textLabel.text,indexPath.row,1);
    }
    [self takeBackTableView];
}
//展开。
-(void)expandWithTableViewHeight:(CGFloat )tableViewHeight {
    
    self.maskBackGroundView.hidden=NO;
    _CSBtn.selected = YES;
    CGRect rect = self.frame;
    rect.size.height = KTableViewCellHeight * KDisplayMaxCellOfNumber + kFit(43);
    self.frame= rect;
    NSLog(@"-------%f", kScreen_widht - self.frame.origin.y);
    [self showSpringAnimationWithDuration:0.3 animations:^{
        
        self.tableView.frame = CGRectMake(0, self.selfOriginalHeight, kScreen_widht, tableViewHeight);
        
        self.maskBackGroundView.alpha =0.7;
        
    } completion:^{
        
    }];
}
//收起。
-(void)takeBackTableView {
    
    for (UIButton *button in self.buttonArray) {
        button.selected=NO;
    }
    _CSBtn.selected = NO;
    CGRect rect = self.frame;
    rect.size.height = kFit(43);
    self.frame = rect;
    [self showSpringAnimationWithDuration:.3 animations:^{
        
        self.tableView.frame = CGRectMake(0, self.selfOriginalHeight, kScreen_widht,0);;
        self.maskBackGroundView.alpha =0;
        
    } completion:^{
        self.maskBackGroundView.hidden=YES;
    }];
    
}

-(void)showSpringAnimationWithDuration:(CGFloat)duration
                            animations:(void (^)())animations
                            completion:(void (^)())completion {
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

-(void)maskBackGroundViewTapClick {
    [self takeBackTableView];
}

-(UIView *)maskBackGroundView {
    if (_maskBackGroundView) {
        return _maskBackGroundView;
    }
    self.maskBackGroundView=[[UIView alloc]initWithFrame:CGRectMake(0,self.frame.origin.y,self.frame.size.width, kScreen_heigth)];
    self.maskBackGroundView.backgroundColor=[UIColor colorWithRed:40/255 green:40/255 blue:40/255 alpha:.2];
    self.maskBackGroundView.hidden=YES;
    self.maskBackGroundView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskBackGroundViewTapClick)];
    [self.maskBackGroundView addGestureRecognizer:tap];
    
    return self.maskBackGroundView;
}

-(NSMutableArray *)menuDataArray{
    if (_menuDataArray) {
        return _menuDataArray;
    }
    self.menuDataArray =[[NSMutableArray alloc]init];
    
    return self.menuDataArray;
}

-(NSMutableArray *)tableDataArray {
    if (_tableDataArray) {
        return _tableDataArray;
    }
    self.tableDataArray = [[NSMutableArray alloc]init];
    
    return self.tableDataArray;
}

-(NSMutableArray *)buttonArray {
    if (_buttonArray) {
        return _buttonArray;
    }
    self.buttonArray =[[NSMutableArray alloc]init];
    
    return self.buttonArray;
}

@end
